import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Pawn move", () {
    test("basic count move", () {
      Board board =
          BoardFactory().boardFromFEN("3k4/3p4/8/p6P/8/8/3P4/3K4 w - - 0 1");
      Coordinates whitePawnDefaultPosition = Coordinates(File.D, 2);
      Coordinates whitePawnHasMoved = Coordinates(File.H, 5);

      Coordinates blackPawnDefaultPosition = Coordinates(File.D, 7);
      Coordinates blackPawnHasMoved = Coordinates(File.A, 5);

      expect(
          board
              .getPiece(whitePawnDefaultPosition)
              .getAvailableMoveSquares(board)
              .length,
          2);
      expect(
          board
              .getPiece(blackPawnDefaultPosition)
              .getAvailableMoveSquares(board)
              .length,
          2);
      expect(
          board
              .getPiece(whitePawnHasMoved)
              .getAvailableMoveSquares(board)
              .length,
          1);
      expect(
          board
              .getPiece(blackPawnHasMoved)
              .getAvailableMoveSquares(board)
              .length,
          1);
    });
    test("attach move", () {
      Board board =
          BoardFactory().boardFromFEN("3k4/8/8/8/p1P3n1/1P4P1/8/3K4 w - - 0 1");
      Piece whitePawnToAttach = board.getPiece(Coordinates(File.B, 3));
      Piece whitePawnDoNotMovie = board.getPiece(Coordinates(File.G, 3));
      Piece whitePawn = board.getPiece(Coordinates(File.C, 4));
      Piece blackPawn = board.getPiece(Coordinates(File.A, 4));

      expect(whitePawnDoNotMovie.getAvailableMoveSquares(board).length, 0);

      expect(whitePawnToAttach.getAvailableMoveSquares(board).length, 2);
      expect(
          whitePawnToAttach
              .getAvailableMoveSquares(board)
              .contains(Coordinates(File.A, 4)),
          true);
      expect(
          whitePawnToAttach
              .getAvailableMoveSquares(board)
              .contains(Coordinates(File.B, 4)),
          true);

      expect(blackPawn.getAvailableMoveSquares(board).length, 2);
      expect(whitePawn.getAvailableMoveSquares(board).length, 1);
    });
    test("pawn cannot move through a piece", () {
      Board board =
          BoardFactory().boardFromFEN("3k4/8/8/8/8/3p4/3P4/3K4 w - - 0 1");
      expect(
          board
              .getPiece(Coordinates(File.D, 2))
              .getAvailableMoveSquares(board)
              .length,
          0);
    });
  });
  group("moves after enPassant", () {
    GameProvider game = GameProvider(
        "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");

    game.inputCoordinateTap(Coordinates(File.E, 2));
    game.inputCoordinateTap(Coordinates(File.E, 4));

    game.inputCoordinateTap(Coordinates(File.F, 7));
    game.inputCoordinateTap(Coordinates(File.F, 5));

    game.inputCoordinateTap(Coordinates(File.E, 4));
    game.inputCoordinateTap(Coordinates(File.F, 5));

    test("en passant", () {
      expect(
          game.board
              .getPiece(Coordinates(File.G, 7))
              .getAvailableMoveSquares(game.board)
              .length,
          2);
      expect(
          game.board
              .getPiece(Coordinates(File.E, 7))
              .getAvailableMoveSquares(game.board)
              .length,
          2);
    });
  });
}
