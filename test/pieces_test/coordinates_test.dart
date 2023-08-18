import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/coordinates_shift.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Coordinates coordinates = Coordinates(File.D, 4);
  Coordinates coordinatesIdentical = Coordinates(File.D, 4);
  Coordinates coordinatesDifferent = Coordinates(File.A, 4);

  group("Can shift within the table borders", () {
    test("up", () {
      expect(coordinates.canShift(CoordinatesShift(4, 0)), true);
    });
    test("left", () {
      expect(coordinates.canShift(CoordinatesShift(1, -3)), true);
    });
    test("right", () {
      expect(coordinates.canShift(CoordinatesShift(0, 4)), true);
    });
    test("down", () {
      expect(coordinates.canShift(CoordinatesShift(-3, 0)), true);
    });
  });

  group("Can shift outside the border of the board", () {
    test("up", () {
      expect(coordinates.canShift(CoordinatesShift(5, 0)), false);
    });
    test("left", () {
      expect(coordinates.canShift(CoordinatesShift(1, -4)), false);
    });
    test("right", () {
      expect(coordinates.canShift(CoordinatesShift(0, 5)), false);
    });
    test("down", () {
      expect(coordinates.canShift(CoordinatesShift(-34, 0)), false);
    });
  });

  group("comparison of identical coordinates", () {
    test("==", () {
      expect(coordinates == coordinatesIdentical, true);
    });
    test("hashCode", () {
      expect(coordinates.hashCode == coordinatesIdentical.hashCode, true);
    });
  });

  group("comparison of different coordinates", () {
    test("==", () {
      expect(coordinates == coordinatesDifferent, false);
    });
    test("hashCode", () {
      expect(coordinates.hashCode == coordinatesDifferent.hashCode, false);
    });
  });
}
