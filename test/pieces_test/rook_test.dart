import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Boards/board_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Available Move Squares Rook", () {
    Coordinates coordinates = Coordinates(File.B, 1);
    Board board = BoardFactory().boardFromFEN("3k4/8/8/1p6/8/8/8/1R1K4 w - - 0 1");

    var piece = board.getPiece(coordinates);
    //left
    Coordinates move1 = Coordinates(File.A, 1);
    //right
    Coordinates move2 = Coordinates(File.C, 1);
    //top
    Coordinates move3 = Coordinates(File.B, 2);
    Coordinates move4 = Coordinates(File.B, 3);
    Coordinates move5 = Coordinates(File.B, 4);
    Coordinates move6 = Coordinates(File.B, 5);

    //behind white piece
    Coordinates incorrectMove1 = Coordinates(File.D, 1);
    Coordinates incorrectMove2 = Coordinates(File.E, 1);
    Coordinates incorrectMove3 = Coordinates(File.H, 1);
    //behind black piece
    Coordinates incorrectMove4 = Coordinates(File.B, 6);
    Coordinates incorrectMove5 = Coordinates(File.B, 8);

    test("count Available move", () {
      expect(piece.getAvailableMoveSquares(board).length, 6);
    });
    test("Available move", () {
      expect(piece.getAvailableMoveSquares(board).contains(move1), true);
      expect(piece.getAvailableMoveSquares(board).contains(move2), true);
      expect(piece.getAvailableMoveSquares(board).contains(move3), true);
      expect(piece.getAvailableMoveSquares(board).contains(move4), true);
      expect(piece.getAvailableMoveSquares(board).contains(move5), true);
      expect(piece.getAvailableMoveSquares(board).contains(move6), true);

      expect(
          piece.getAvailableMoveSquares(board).contains(incorrectMove1), false);
      expect(
          piece.getAvailableMoveSquares(board).contains(incorrectMove2), false);
      expect(
          piece.getAvailableMoveSquares(board).contains(incorrectMove3), false);
      expect(
          piece.getAvailableMoveSquares(board).contains(incorrectMove4), false);
      expect(
          piece.getAvailableMoveSquares(board).contains(incorrectMove5), false);
    });
  });
}
