import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Boards/board_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Available Move Squares Queen", () {
    Coordinates coordinates = Coordinates(File.C, 4);
    Board board =
        BoardFactory().boardFromFEN("3k4/8/8/2R5/2Q1p3/8/8/3K4 w - - 0 1");

    var piece = board.getPiece(coordinates);
    //left
    Coordinates move1 = Coordinates(File.A, 4);
    //right
    Coordinates move2 = Coordinates(File.E, 4);
    //bottom
    Coordinates move3 = Coordinates(File.C, 1);

    //behind white piece
    Coordinates incorrectMove1 = Coordinates(File.C, 6);
    //behind black piece
    Coordinates incorrectMove2 = Coordinates(File.H, 4);

    test("count Available move", () {
      expect(piece.getAvailableMoveSquares(board).length, 18);
    });
    test("Available move", () {
      expect(piece.getAvailableMoveSquares(board).contains(move1), true);
      expect(piece.getAvailableMoveSquares(board).contains(move2), true);
      expect(piece.getAvailableMoveSquares(board).contains(move3), true);

      expect(
          piece.getAvailableMoveSquares(board).contains(incorrectMove1), false);
      expect(
          piece.getAvailableMoveSquares(board).contains(incorrectMove2), false);
    });
  });
}
