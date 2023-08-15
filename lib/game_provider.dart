import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:flutter/material.dart';

import 'Boards/board_console_renderer.dart';

class GameProvider extends ChangeNotifier {
  final Board board;
  late Widget boardWidget;
  final BoardConsoleRenderer renderer = BoardConsoleRenderer();
  //final BoardWidgetRenderer renderer = BoardWidgetRenderer();
  bool isWhiteToMove = true;

  GameProvider(this.board){
    renderer.render(board, null);
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
