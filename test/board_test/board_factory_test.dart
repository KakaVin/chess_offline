import 'package:chess_offline/Pieces/bishop.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Pieces/king.dart';
import 'package:chess_offline/Pieces/knight.dart';
import 'package:chess_offline/Pieces/pawn.dart';
import 'package:chess_offline/Pieces/rook.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("board 7 piece", () {
    Board board =
        BoardFactory().boardFromFEN("rnb1k3/8/8/3p4/3P4/8/8/4K3 w q - 0 1");

    test("count Piece", () {
      expect(board.pieces.length, 7);
    });
    test("empty place", () {
      expect(board.isSquareEmpty(Coordinates(File.D, 8)), true);
    });

    test("white Pawn", () {
      expect(board.getPiece(Coordinates(File.D, 4)) is Pawn, true);
      expect((board.getPiece(Coordinates(File.D, 4)) as Pawn).color,
          ColorChess.white);
    });
    test("black Pawn", () {
      expect(board.getPiece(Coordinates(File.D, 5)) is Pawn, true);
      expect((board.getPiece(Coordinates(File.D, 5)) as Pawn).color,
          ColorChess.black);
    });

    test("black Rook", () {
      expect(board.getPiece(Coordinates(File.A, 8)) is Rook, true);
      expect((board.getPiece(Coordinates(File.A, 8)) as Rook).color,
          ColorChess.black);
    });
    test("black Knight", () {
      expect(board.getPiece(Coordinates(File.B, 8)) is Knight, true);
      expect((board.getPiece(Coordinates(File.B, 8)) as Knight).color,
          ColorChess.black);
    });
    test("black Bishop", () {
      expect(board.getPiece(Coordinates(File.C, 8)) is Bishop, true);
      expect((board.getPiece(Coordinates(File.C, 8)) as Bishop).color,
          ColorChess.black);
    });
    test("black King", () {
      expect(board.getPiece(Coordinates(File.E, 8)) is King, true);
      expect((board.getPiece(Coordinates(File.E, 8)) as King).color,
          ColorChess.black);
    });
    test("white King", () {
      expect(board.getPiece(Coordinates(File.E, 1)) is King, true);
      expect((board.getPiece(Coordinates(File.E, 1)) as King).color,
          ColorChess.white);
    });
  });

  group("start board", () {
    Board board = BoardFactory().boardFromFEN(
        "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");

    test("count Piece", () {
      expect(board.pieces.length, 32);
    });
    test("empty place", () {
      expect(board.isSquareEmpty(Coordinates(File.H, 3)), true);
      expect(board.isSquareEmpty(Coordinates(File.H, 4)), true);
      expect(board.isSquareEmpty(Coordinates(File.H, 5)), true);
      expect(board.isSquareEmpty(Coordinates(File.H, 6)), true);

      expect(board.isSquareEmpty(Coordinates(File.A, 3)), true);
      expect(board.isSquareEmpty(Coordinates(File.A, 4)), true);
      expect(board.isSquareEmpty(Coordinates(File.A, 5)), true);
      expect(board.isSquareEmpty(Coordinates(File.A, 6)), true);
    });
    test("white Pawn", () {
      expect(board.getPiece(Coordinates(File.A, 2)) is Pawn, true);
      expect((board.getPiece(Coordinates(File.A, 2)) as Pawn).color,
          ColorChess.white);
    });
    test("black Pawn", () {
      expect(board.getPiece(Coordinates(File.H, 7)) is Pawn, true);
      expect((board.getPiece(Coordinates(File.H, 7)) as Pawn).color,
          ColorChess.black);
    });
    test("white King", () {
      expect(board.getPiece(Coordinates(File.E, 1)) is King, true);
      expect((board.getPiece(Coordinates(File.E, 1)) as King).color,
          ColorChess.white);
    });
    test("black King", () {
      expect(board.getPiece(Coordinates(File.E, 8)) is King, true);
      expect((board.getPiece(Coordinates(File.E, 8)) as King).color,
          ColorChess.black);
    });
  });

  group("save and load fen", () {
    test("normal data", () {
      String fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";
      GameProvider game = GameProvider(fen);

      expect(BoardFactory().toFen(game.board, game.colorMovie), fen);
    });
    test("clear board", () {
      String fen = "8/8/8/8/8/8/8/8 w - - 0 1";
      GameProvider game = GameProvider(fen);

      expect(BoardFactory().toFen(game.board, game.colorMovie), fen);
    });
    test("chaos board", () {
      String fen =
          "1nbq1rk1/r2p1p1p/1p3b1n/1NpP4/pPB1pP1R/2P3p1/P3P1PP/2RK1BN1 w - - 20 30";
      GameProvider game = GameProvider(fen);

      expect(BoardFactory().toFen(game.board, game.colorMovie), fen);
    });
  });
}
