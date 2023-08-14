import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/board.dart';
import 'package:chess_offline/board_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("move not attach king", (){
    Board board = BoardFactory().fromFEN("7k/8/8/8/2K5/8/8/8 w - - 0 1");
    Piece blackKing = board.getPiece(Coordinates(File.H, 8));
    Piece whiteKing = board.getPiece(Coordinates(File.C, 4));

    test("count moves", (){
      expect(blackKing.getAvailableMoveSquares(board).length, 3);
      expect(whiteKing.getAvailableMoveSquares(board).length, 8);
    });
  });

  group("move attach king", (){
    Board board = BoardFactory().fromFEN("3b4/8/r2Np3/4K3/8/4k3/R3p3/8 w - - 0 1");
    Piece blackKing = board.getPiece(Coordinates(File.E, 3));
    Piece whiteKing = board.getPiece(Coordinates(File.E, 5));

    test("count moves", (){
      expect(blackKing.getAvailableMoveSquares(board).length, 3);
      expect(whiteKing.getAvailableMoveSquares(board).length, 1);
    });
    
    test("one knight", (){
      Board board = BoardFactory().fromFEN("8/8/8/4n3/8/4K3/8/7k w - - 0 1");
      expect(board.getPiece(Coordinates(File.E, 3)).getAvailableMoveSquares(board).length, 6);
    });
  });
}