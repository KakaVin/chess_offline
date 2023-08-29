import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/rook.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("move not attach king", () {
    Board board = BoardFactory().boardFromFEN("7k/8/8/8/2K5/8/8/8 w - - 0 1");
    Piece blackKing = board.getPiece(Coordinates(File.H, 8));
    Piece whiteKing = board.getPiece(Coordinates(File.C, 4));

    test("count moves", () {
      expect(blackKing.getAvailableMoveSquares(board).length, 3);
      expect(whiteKing.getAvailableMoveSquares(board).length, 8);
    });
  });

  group("move attach king", () {
    Board board =
        BoardFactory().boardFromFEN("3b4/8/r2Np3/4K3/8/4k3/R3p3/8 w - - 0 1");
    Piece blackKing = board.getPiece(Coordinates(File.E, 3));
    Piece whiteKing = board.getPiece(Coordinates(File.E, 5));

    test("count moves", () {
      expect(blackKing.getAvailableMoveSquares(board).length, 3);
      expect(whiteKing.getAvailableMoveSquares(board).length, 1);
    });

    test("one knight", () {
      Board board =
          BoardFactory().boardFromFEN("8/8/8/4n3/8/4K3/8/7k w - - 0 1");
      expect(
          board
              .getPiece(Coordinates(File.E, 3))
              .getAvailableMoveSquares(board)
              .length,
          6);
    });
  });

  group("casting move", () {
    GameProvider game =
        GameProvider("r3k2r/1pppppp1/8/8/8/8/1PPPPPP1/R3K2R w KQkq - 0 1");
    Piece blackKing = game.board.getPiece(Coordinates(File.E, 8));
    Piece whiteKing = game.board.getPiece(Coordinates(File.E, 1));

    test("casting available", () {
      expect(blackKing.getAvailableMoveSquares(game.board).length, 4);
      expect(whiteKing.getAvailableMoveSquares(game.board).length, 4);
    });
    test("move white king", () {
      game.inputCoordinateTap(whiteKing.coordinates);
      game.inputCoordinateTap(Coordinates(File.D, 1));
      expect(whiteKing.getAvailableMoveSquares(game.board).length, 2);
      expect(game.board.casting.whiteLong, false);
      expect(game.board.casting.whiteShort, false);

      game.inputCoordinateTap(whiteKing.coordinates);
      game.inputCoordinateTap(Coordinates(File.E, 1));
      expect(whiteKing.getAvailableMoveSquares(game.board).length, 2);
      expect(game.board.casting.whiteLong, false);
      expect(game.board.casting.whiteShort, false);
    });
    test("move one black rook", () {
      game.inputCoordinateTap(Coordinates(File.H, 8));
      game.inputCoordinateTap(Coordinates(File.H, 5));
      expect(game.board.casting.blackShort, false);
      expect(game.board.casting.blackLong, true);
      expect(blackKing.getAvailableMoveSquares(game.board).length, 3);
    });
    test("move two black rook", () {
      game.colorMovie = ColorChess.black;
      game.inputCoordinateTap(Coordinates(File.A, 8));
      game.inputCoordinateTap(Coordinates(File.A, 7));
      expect(game.board.casting.blackLong, false);
      expect(blackKing.getAvailableMoveSquares(game.board).length, 2);
    });
  });

  group("available casting if square attach", () {
    GameProvider game =
        GameProvider("r3k2r/pp4pp/1B4B1/8/6b1/8/8/R3KB1R w KQkq - 0 1");
    Piece blackKing = game.board.getPiece(Coordinates(File.E, 8));
    Piece whiteKing = game.board.getPiece(Coordinates(File.E, 1));

    test("white king", () {
      expect(game.board.casting.whiteShort, true);
      expect(game.board.casting.whiteLong, true);
      expect(
          whiteKing.isSquareAvailableForMove(
              Coordinates(File.C, 1), game.board),
          false);
      expect(
          whiteKing.isSquareAvailableForMove(
              Coordinates(File.G, 1), game.board),
          false);
    });
    test("black king", () {
      expect(game.board.casting.blackLong, true);
      expect(game.board.casting.blackShort, true);
      expect(
          blackKing.isSquareAvailableForMove(
              Coordinates(File.C, 8), game.board),
          false);
      expect(
          blackKing.isSquareAvailableForMove(
              Coordinates(File.G, 8), game.board),
          false);
    });
  });

  group("short casting", () {
    GameProvider game =
        GameProvider("r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w KQkq - 0 1");
    Piece whiteKing = game.board.getPiece(Coordinates(File.E, 1));
    Piece blackKing = game.board.getPiece(Coordinates(File.E, 8));

    test("white king", () {
      game.inputCoordinateTap(whiteKing.coordinates);
      game.inputCoordinateTap(Coordinates(File.G, 1));
      expect(game.board.getPiece(Coordinates(File.F, 1)) is Rook, true);
      expect(whiteKing.coordinates == Coordinates(File.G, 1), true);
      expect(game.board.casting.whiteLong, false);
      expect(game.board.casting.whiteShort, false);
    });
    test("black king", () {
      game.inputCoordinateTap(blackKing.coordinates);
      game.inputCoordinateTap(Coordinates(File.G, 8));
      expect(game.board.getPiece(Coordinates(File.F, 8)) is Rook, true);
      expect(blackKing.coordinates == Coordinates(File.G, 8), true);
      expect(game.board.casting.blackShort, false);
      expect(game.board.casting.blackLong, false);
    });
  });

  group("long casting", () {
    GameProvider game =
        GameProvider("r3k2r/pppppppp/8/8/8/8/PPPPPPPP/R3K2R w KQkq - 0 1");
    Piece whiteKing = game.board.getPiece(Coordinates(File.E, 1));
    Piece blackKing = game.board.getPiece(Coordinates(File.E, 8));

    test("white king", () {
      game.inputCoordinateTap(whiteKing.coordinates);
      game.inputCoordinateTap(Coordinates(File.C, 1));
      expect(game.board.getPiece(Coordinates(File.D, 1)) is Rook, true);
      expect(whiteKing.coordinates == Coordinates(File.C, 1), true);
      expect(game.board.casting.whiteLong, false);
      expect(game.board.casting.whiteShort, false);
    });
    test("black king", () {
      game.inputCoordinateTap(blackKing.coordinates);
      game.inputCoordinateTap(Coordinates(File.C, 8));
      expect(game.board.getPiece(Coordinates(File.D, 8)) is Rook, true);
      expect(blackKing.coordinates == Coordinates(File.C, 8), true);
      expect(game.board.casting.blackShort, false);
      expect(game.board.casting.blackLong, false);
    });
  });
}
