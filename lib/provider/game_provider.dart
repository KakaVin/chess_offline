import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/Boards/move.dart';
import 'package:chess_offline/Pieces/pawn.dart';
import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/game_state/checkmate_game_state_checker.dart';
import 'package:chess_offline/game_state/draw_game_state_checker.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';
import 'package:chess_offline/game_state/stalemate_game_state_checker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Boards/board_widget_renderer.dart';
import '../Pieces/king.dart';
import '../Pieces/util/color_utils.dart';
import '../game_state/casting_checker.dart';

class GameProvider extends ChangeNotifier {
  late Board board;
  //final BoardConsoleRenderer renderer = BoardConsoleRenderer();
  final BoardWidgetRenderer renderer = BoardWidgetRenderer();
  late Column boardWidget;
  Piece? selectedPiece;
  late GameState state;
  final List<GameStateChecker> checkers = [
    StalemateGameStateChecker(),
    CheckmateGameStateChecker(),
    CastingChecker(),
    DrawGameStateChecker(),
  ];
  ColorChess colorMovie = ColorChess.white;

  GameProvider(String fen) {
    newGame(fen);
  }

  void newGame(String fen) {
    board = BoardFactory().boardFromFEN(fen);
    colorMovie = BoardFactory().colorFromFEN(fen);
    board.casting = BoardFactory().canCastingFromFEN(fen);
    board.fullMove = BoardFactory().fullMoveFromFEN(fen);
    board.halfMove = BoardFactory().halfMoveFromFEN(fen);

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
        //todo проверить может ли хороль сделать этот ход возможно являющийся рокировкой
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
      if (colorMovie == ColorChess.black) board.fullMove++;

      isHalfMove(board, move);
      isCasting(board, move);

      board.makeMove(move);
      colorMovie = ColorUtils.opposite(colorMovie);
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
    save.setString("game", BoardFactory().toFEN(board, colorMovie));
  }

  void loadGame() async {
    SharedPreferences save = await SharedPreferences.getInstance();

    newGame(save.getString("game") ?? board.startingFen);
  }

  isHalfMove(Board board, Move move) {
    if (!board.isSquareEmpty(move.from) && board.getPiece(move.from) is Pawn ||
        !board.isSquareEmpty(move.to) && board.getPiece(move.to) is Pawn) {
      board.halfMove = 0;
    } else {
      board.halfMove++;
    }
  }

  void isCasting(Board board, Move move) {
    if (board.getPiece(move.from) is King && Move.fileShift(move) == 2) {
      for (var rank = 1; rank <= 8; rank += 7) {
        if (move.to == Coordinates(File.G, rank)) {
          board.makeMove(
              Move(Coordinates(File.H, rank), Coordinates(File.F, rank)));
        }
        if (move.to == Coordinates(File.C, rank)) {
          board.makeMove(
              Move(Coordinates(File.A, rank), Coordinates(File.D, rank)));
        }
      }
    }
  }
}
