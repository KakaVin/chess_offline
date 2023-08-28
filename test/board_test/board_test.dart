import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/Boards/move.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Pieces/pawn.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Board board = Board("8/8/8/8/8/8/8/8 w - - 0 1");
  Coordinates coordinatesPiece = Coordinates(File.A, 1);
  Coordinates coordinatesPieceMove = Coordinates(File.B, 1);
  Coordinates coordinatesEmpty = Coordinates(File.C, 1);

  test("set piece", () {
    board.setPiece(coordinatesPiece, Pawn(ColorChess.white, coordinatesPiece));
    expect(board.pieces.length, 1);
  });
  test("not Square empty", () {
    expect(board.isSquareEmpty(coordinatesPiece), false);
  });
  test("Square empty", () {
    expect(board.isSquareEmpty(coordinatesEmpty), true);
  });
  test("get Piece", () {
    expect((board.getPiece(coordinatesPiece) is Pawn), true);
  });
  test("make move", () {
    board.makeMove(Move(coordinatesPiece, coordinatesPieceMove));
    expect((board.getPiece(coordinatesPieceMove) is Pawn), true);
    expect((board.isSquareEmpty(coordinatesPiece)), true);
  });
  test("remove piece", () {
    board.removePeace(coordinatesPieceMove);
    expect(board.pieces.length, 0);
  });
  test("make move", () {
    Coordinates coordinatesWhitePawn = Coordinates(File.E, 4);
    board.setPiece(
        coordinatesWhitePawn, Pawn(ColorChess.white, coordinatesWhitePawn));
    Coordinates coordinatesBlackPawn = Coordinates(File.D, 5);
    board.setPiece(
        coordinatesBlackPawn, Pawn(ColorChess.black, coordinatesBlackPawn));
    expect(board.pieces.length, 2);
    board.makeMove(Move(coordinatesBlackPawn, coordinatesWhitePawn));
    expect(board.pieces.length, 1);
    expect(board.getPiece(coordinatesWhitePawn).color, ColorChess.black);
  });

  test("Square dark", () {
    expect(Board.isSquareDark(coordinatesPiece), true);
    expect(Board.isSquareDark(coordinatesPieceMove), false);
    expect(Board.isSquareDark(coordinatesEmpty), true);
  });

  group("king after move", () {
    Board board = BoardFactory().boardFromFEN("8/3k4/8/8/8/8/3N4/3K3r w - - 0 1");
    test("king move to attach square", () {
      expect(
          Board.validateIfKingInCheckAfterMove(board, ColorChess.white,
              Move(Coordinates(File.D, 1), Coordinates(File.E, 1))),
          true);
    });
    test("king move to attach king", () {
      expect(
          Board.validateIfKingInCheckAfterMove(board, ColorChess.white,
              Move(Coordinates(File.D, 2), Coordinates(File.F, 1))),
          false);
    });
    test("king move to not attach king", () {
      expect(
          Board.validateIfKingInCheckAfterMove(board, ColorChess.white,
              Move(Coordinates(File.D, 1), Coordinates(File.E, 2))),
          false);
    });
  });
}
