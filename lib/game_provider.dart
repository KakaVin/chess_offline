import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:flutter/material.dart';

import 'Boards/board_widget_renderer.dart';

class GameProvider extends ChangeNotifier {
  final Board board;
  //final BoardConsoleRenderer renderer = BoardConsoleRenderer();
  final BoardWidgetRenderer renderer = BoardWidgetRenderer();
  late Column boardWidget;
  Piece? selectedPiece;

  bool isWhiteToMove = true;

  GameProvider(this.board) {
    boardWidget = renderer.render(board, null);
  }
  void inputCoordinateTap(Coordinates coordinates) {
    //выбрать свою фигуру
    if (selectedPiece == null) {
      if (!board.isSquareEmpty(coordinates)) {
        selectedPiece = board.getPiece(coordinates);
      }
      //сделать ход на достнупные координаты либо выбрать другую фигуру
    } else if (selectedPiece!
        .getAvailableMoveSquares(board)
        .contains(coordinates)) {
      if (!board.isSquareEmpty(coordinates)) board.removePeace(coordinates);
      board.movePeace(selectedPiece!.coordinates, coordinates);
      selectedPiece = null;
    } else {
      selectedPiece = null;
    }
    boardWidget = renderer.render(board, selectedPiece);
    notifyListeners();
  }

  void gameLoop() {
    while (true) {
      // render
      renderer.render(board, null);

      // input
      Piece piece = board.getPiece(Coordinates(File.A, 1));

      renderer.render(board, piece);
      // make move

      // pass move
      isWhiteToMove = !isWhiteToMove;
      notifyListeners();
    }
  }
}
