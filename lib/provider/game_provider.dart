import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/Boards/board_utils.dart';
import 'package:chess_offline/Boards/move.dart';
import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/game_state/checkmate_game_state_checker.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';
import 'package:chess_offline/game_state/stalemate_game_state_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Boards/board_widget_renderer.dart';

class GameProvider extends ChangeNotifier {
  late Board board;
  //final BoardConsoleRenderer renderer = BoardConsoleRenderer();
  final BoardWidgetRenderer renderer = BoardWidgetRenderer();
  late Column boardWidget;
  Piece? selectedPiece;
  late GameState state;
  final List<GameStateChecker> checkers = [
    StalemateGameStateChecker(),
    CheckmateGameStateChecker()
  ];

  ColorChess colorMovie = ColorChess.white;

  GameProvider(this.board) {
    newGame(board, ColorChess.white);
  }

  void newGame(Board board, ColorChess color) {
    this.board = board;
    colorMovie = color;

    boardWidget = renderer.render(board, null);
    state = determinateGameState(board, colorMovie);
  }

  void inputCoordinateTap(Coordinates coordinates) {
    if (state == GameState.ongoing) {
      //выбрать свою фигуру
      if (selectedPiece == null) {
        if (isPieceCanBeSelected(board, coordinates)) {
          selectedPiece = board.getPiece(coordinates);
        }
        //сделать ход на достнупные координаты либо выбрать другую фигуру
      } else if (selectedPiece!
          .getAvailableMoveSquares(board)
          .contains(coordinates)) {
        makeMove(board, Move(selectedPiece!.coordinates, coordinates));
      } else {
        selectedPiece = null;
      }
      //render
      boardWidget = renderer.render(board, selectedPiece);
      notifyListeners();
      state = determinateGameState(board, colorMovie);
      if (state != GameState.ongoing) {
        print("game ending state: $state");
      }
      //save stage if the number of moves matters
      if (board.moves.length > 2) saveGame();
    }
  }

  bool isPieceCanBeSelected(Board board, Coordinates coordinates) {
    return (!board.isSquareEmpty(coordinates) &&
        colorMovie == board.getPiece(coordinates).color &&
        board.getPiece(coordinates).getAvailableMoveSquares(board).isNotEmpty);
  }

  void makeMove(Board board, Move move) {
    if (Board.validateIfKingInCheckAfterMove(
        board, board.getPiece(move.from).color, move)) {
      print("your King is after attack");
    } else {
      board.makeMove(move);
      colorMovie = BoardUtils.oppositeColorChess(colorMovie);
    }
    selectedPiece = null;
  }

  GameState determinateGameState(Board board, ColorChess color) {
    for (var checker in checkers) {
      var state = checker.check(board, color);
      if (state != GameState.ongoing) return state;
    }
    return GameState.ongoing;
  }

  void saveGame() async {
    SharedPreferences save = await SharedPreferences.getInstance();
    save.setString("game", BoardFactory().toFen(board));
    save.setString("color", colorMovie.toString());
  }

  void loadGame() async {
    SharedPreferences save = await SharedPreferences.getInstance();
    ColorChess color;

    var loadColor = save.getString("color") ?? ColorChess.white.toString();
    if (loadColor == ColorChess.white.toString()) {
      color = ColorChess.white;
    } else {
      color = ColorChess.black;
    }

    newGame(BoardFactory().fromFEN(save.getString("game") ?? board.startingFen),
        color);
  }
}
