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

  group("Available Move Squares Knight", (){
    Coordinates coordinates = Coordinates(File.B, 2);
    Board board = BoardFactory().fromFEN("8/8/8/8/P7/8/1N6/3p4 w - - 0 1");

    var knight = board.getPiece(coordinates);
    Coordinates move1 = Coordinates(File.C, 4);
    Coordinates move2 = Coordinates(File.D, 3);
    Coordinates move3 = Coordinates(File.D, 1);

    Coordinates incorrectMove1 = Coordinates(File.A, 4);
    Coordinates incorrectMove2 = Coordinates(File.B, 4);
    Coordinates incorrectMove3 = Coordinates(File.D, 4);

    test("count Available move", (){
      expect(knight.getAvailableMoveSquares(board).length, 3);
    });
    test("Available move", (){
      expect(knight.getAvailableMoveSquares(board).contains(move1), true);
      expect(knight.getAvailableMoveSquares(board).contains(move2), true);
      expect(knight.getAvailableMoveSquares(board).contains(move3), true);

      expect(knight.getAvailableMoveSquares(board).contains(incorrectMove1), false);
      expect(knight.getAvailableMoveSquares(board).contains(incorrectMove2), false);
      expect(knight.getAvailableMoveSquares(board).contains(incorrectMove3), false);
    });
    test("Square available for move", (){
      expect(knight.isSquareAvailableForMove(incorrectMove1, board), false);
      expect(knight.isSquareAvailableForMove(incorrectMove2, board), true);
      expect(knight.isSquareAvailableForMove(incorrectMove3, board), true);
    });
  });

  group("Available Move Squares Rook", (){
    Coordinates coordinates = Coordinates(File.B, 1);
    Board board = BoardFactory().fromFEN("3k4/8/8/1p6/8/8/8/1R1K4 w - - 0 1");

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

    test("count Available move", (){
      expect(piece.getAvailableMoveSquares(board).length, 6);
    });
    test("Available move", (){
      expect(piece.getAvailableMoveSquares(board).contains(move1), true);
      expect(piece.getAvailableMoveSquares(board).contains(move2), true);
      expect(piece.getAvailableMoveSquares(board).contains(move3), true);
      expect(piece.getAvailableMoveSquares(board).contains(move4), true);
      expect(piece.getAvailableMoveSquares(board).contains(move5), true);
      expect(piece.getAvailableMoveSquares(board).contains(move6), true);

      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove1), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove2), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove3), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove4), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove5), false);
    });
  });

  group("Available Move Squares Queen", (){
    Coordinates coordinates = Coordinates(File.C, 4);
    Board board = BoardFactory().fromFEN("3k4/8/8/2R5/2Q1p3/8/8/3K4 w - - 0 1");

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

    test("count Available move", (){
      expect(piece.getAvailableMoveSquares(board).length, 18);
    });
    test("Available move", (){
      expect(piece.getAvailableMoveSquares(board).contains(move1), true);
      expect(piece.getAvailableMoveSquares(board).contains(move2), true);
      expect(piece.getAvailableMoveSquares(board).contains(move3), true);

      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove1), false);
      expect(piece.getAvailableMoveSquares(board).contains(incorrectMove2), false);
    });
  });
}