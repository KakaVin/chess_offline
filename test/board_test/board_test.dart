import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Pieces/pawn.dart';
import 'package:chess_offline/board.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Board board = Board();
  Coordinates coordinatesPiece = Coordinates(File.A, 1);
  Coordinates coordinatesPieceMove = Coordinates(File.B, 1);
  Coordinates coordinatesEmpty = Coordinates(File.C, 1);

  test("set piece", (){
    board.setPiece(coordinatesPiece, Pawn(ColorChess.white, coordinatesPiece));
    expect(board.pieces.length, 1);
  });
  test("not Square empty", (){
    expect(board.isSquareEmpty(coordinatesPiece), false);
  });
  test("Square empty", (){
    expect(board.isSquareEmpty(coordinatesEmpty), true);
  });
  test("get Piece", (){
    expect((board.getPiece(coordinatesPiece) is Pawn), true);
  });
  test("Move Piece", (){
    board.movePeace(coordinatesPiece, coordinatesPieceMove);
    expect((board.getPiece(coordinatesPieceMove) is Pawn), true);
    expect((board.isSquareEmpty(coordinatesPiece)), true);
  });
  test("remove piece", (){
    board.removePeace(coordinatesPieceMove);
    expect(board.pieces.length, 0);
  });

  test("Square dark", (){
    expect(Board.isSquareDark(coordinatesPiece), true);
    expect(Board.isSquareDark(coordinatesPieceMove), false);
    expect(Board.isSquareDark(coordinatesEmpty), true);
  });

}