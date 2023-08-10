import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/board.dart';
import 'package:chess_offline/board_console_renderer.dart';

class Game {
  final Board board;
  final BoardConsoleRenderer renderer = BoardConsoleRenderer();
  bool isWhiteToMove = true;

  Game(this.board);

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
    }
  }
}
