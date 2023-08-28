import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Boards/board_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Available Move Squares Knight", () {
    Coordinates coordinates = Coordinates(File.B, 2);
    Board board = BoardFactory().boardFromFEN("8/8/8/8/P7/8/1N6/3p4 w - - 0 1");

    var knight = board.getPiece(coordinates);
    Coordinates move1 = Coordinates(File.C, 4);
    Coordinates move2 = Coordinates(File.D, 3);
    Coordinates move3 = Coordinates(File.D, 1);

    Coordinates incorrectMove1 = Coordinates(File.A, 4);
    Coordinates incorrectMove2 = Coordinates(File.B, 4);
    Coordinates incorrectMove3 = Coordinates(File.D, 4);

    test("count Available move", () {
      expect(knight.getAvailableMoveSquares(board).length, 3);
    });
    test("Available move", () {
      expect(knight.getAvailableMoveSquares(board).contains(move1), true);
      expect(knight.getAvailableMoveSquares(board).contains(move2), true);
      expect(knight.getAvailableMoveSquares(board).contains(move3), true);

      expect(knight.getAvailableMoveSquares(board).contains(incorrectMove1),
          false);
      expect(knight.getAvailableMoveSquares(board).contains(incorrectMove2),
          false);
      expect(knight.getAvailableMoveSquares(board).contains(incorrectMove3),
          false);
    });
    test("Square available for move", () {
      expect(knight.isSquareAvailableForMove(incorrectMove1, board), false);
      expect(knight.isSquareAvailableForMove(incorrectMove2, board), true);
      expect(knight.isSquareAvailableForMove(incorrectMove3, board), true);
    });
  });
}
