import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/board.dart';
import 'package:chess_offline/board_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Available Move Squares Bishop", (){
    Coordinates coordinates = Coordinates(File.D, 4);
    Board board = BoardFactory().fromFEN("3k4/8/5n2/2N5/3B4/8/8/3K4 w - - 0 1");

    var piece = board.getPiece(coordinates);
    //top-left
    Coordinates move1 = Coordinates(File.E, 5);
    Coordinates move2 = Coordinates(File.F, 6);
    //bottom-left
    Coordinates move3 = Coordinates(File.E, 3);
    Coordinates move4 = Coordinates(File.F, 2);
    Coordinates move5 = Coordinates(File.G, 1);

    //behind white piece
    Coordinates incorrectMove1 = Coordinates(File.C, 5);
    Coordinates incorrectMove2 = Coordinates(File.B, 6);
    Coordinates incorrectMove3 = Coordinates(File.A, 7);
    //behind black piece
    Coordinates incorrectMove4 = Coordinates(File.G, 7);
    Coordinates incorrectMove5 = Coordinates(File.H, 8);

    test("count Available move", (){
      expect(piece.getAvailableMoveSquares(board).length, 8);
    });
    test("Available move", (){
      expect(piece.getAvailableMoveSquares(board).contains(move1), true);
      expect(piece.getAvailableMoveSquares(board).contains(move2), true);
      expect(piece.getAvailableMoveSquares(board).contains(move3), true);
      expect(piece.getAvailableMoveSquares(board).contains(move4), true);
      expect(piece.getAvailableMoveSquares(board).contains(move5), true);

      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove1), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove2), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove3), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove4), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove5), false);
    });
  });
}