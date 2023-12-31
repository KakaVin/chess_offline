import 'dart:collection';

import 'package:chess_offline/Boards/board_utils.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/color_utils.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/file.dart';

import '../Boards/board.dart';
import '../Boards/move.dart';
import 'util/coordinates_shift.dart';

class King extends Piece {
  King(ColorChess color, Coordinates coordinates) : super(color, coordinates);

  @override
  Set<CoordinatesShift> getPieceMove() {
    Set<CoordinatesShift> result = HashSet();

    for (var fileShift = -1; fileShift <= 1; fileShift++) {
      for (var rankShift = -1; rankShift <= 1; rankShift++) {
        if (rankShift == 0 && fileShift == 0) {
          continue;
        } else {
          result.add(CoordinatesShift(fileShift, rankShift));
        }
      }
    }
    if ((coordinates.file == File.E && coordinates.rank == 1) ||
        (coordinates.file == File.E && coordinates.rank == 8)) {
      result.add(CoordinatesShift(2, 0));
      result.add(CoordinatesShift(-2, 0));
    }
    return result;
  }

  @override
  bool isSquareAvailableForMove(Coordinates coordinates, Board board) {
    bool result = board.isSquareEmpty(coordinates) ||
        board.getPiece(coordinates).color != color;
    if (!result) return result;

    if (Move.fileShift(Move(this.coordinates, coordinates)) == 2) {
      result = isSquareAvailableFromCasting(coordinates, board);
      if (!result) return result;
    }

    return !board.isSquareAttackedByColor(
        coordinates, ColorUtils.opposite(color));
  }

  bool isSquareAvailableFromCasting(Coordinates coordinates, Board board) {
    if (board.isSquareAttackedByColor(
        this.coordinates, ColorUtils.opposite(color))) {
      return false;
    }

    var between = BoardUtils.getHorizontalCoordinatesBetween(
        this.coordinates, coordinates);
    for (var value in between) {
      if (!board.isSquareEmpty(value) ||
          board.isSquareAttackedByColor(value, ColorUtils.opposite(color))) {
        return false;
      }
    }

    if (color == ColorChess.white) {
      if (coordinates == Coordinates(File.G, 1)) {
        return board.casting.whiteShort;
      }
      if (coordinates == Coordinates(File.C, 1)) {
        return board.casting.whiteLong;
      }
    }
    if (color == ColorChess.black) {
      if (coordinates == Coordinates(File.G, 8)) {
        return board.casting.blackShort;
      }
      if (coordinates == Coordinates(File.C, 8)) {
        return board.casting.blackLong;
      }
    }

    throw RangeError("Unknown move from casting");
  }
}
