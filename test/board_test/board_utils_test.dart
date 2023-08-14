import 'package:chess_offline/Boards/board_utils.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Diaginal", () {
    test("top-right diagonal", () {
      expect(
          BoardUtils.getDiagonalCoordinatesBetween(
                  Coordinates(File.D, 4), Coordinates(File.G, 8))
              .length,
          2);
    });
    test("bottom-right diagonal", () {
      expect(
          BoardUtils.getDiagonalCoordinatesBetween(
                  Coordinates(File.D, 4), Coordinates(File.G, 1))
              .length,
          2);
    });
    test("bottom-right diagonal", () {
      expect(
          BoardUtils.getDiagonalCoordinatesBetween(
                  Coordinates(File.D, 4), Coordinates(File.A, 1))
              .length,
          2);
    });
    test("bottom-right diagonal", () {
      expect(
          BoardUtils.getDiagonalCoordinatesBetween(
                  Coordinates(File.D, 4), Coordinates(File.A, 7))
              .length,
          2);
    });
  });

  group("Vertical", () {
    test("vertical diagonal between", () {
      expect(
          BoardUtils.getVerticalCoordinatesBetween(
                  Coordinates(File.D, 4), Coordinates(File.D, 8))
              .length,
          3);
    });
    test("vertical diagonal between", () {
      expect(
          BoardUtils.getVerticalCoordinatesBetween(
                  Coordinates(File.D, 4), Coordinates(File.D, 2))
              .length,
          1);
    });
  });

  group("Horizontal", () {
    test("diagonal between", () {
      expect(
          BoardUtils.getHorizontalCoordinatesBetween(
                  Coordinates(File.D, 4), Coordinates(File.H, 4))
              .length,
          3);
    });
    test("diagonal between", () {
      expect(
          BoardUtils.getHorizontalCoordinatesBetween(
                  Coordinates(File.D, 4), Coordinates(File.A, 4))
              .length,
          2);
    });
  });

  test("opposite color", () {
    expect(BoardUtils.oppositeColorChess(ColorChess.white), ColorChess.black);
    expect(BoardUtils.oppositeColorChess(ColorChess.black), ColorChess.white);
  });
}
