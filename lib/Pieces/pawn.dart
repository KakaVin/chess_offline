import 'dart:collection';

import 'package:chess_offline/Boards/board_utils.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/piece.dart';

import '../Boards/board.dart';
import 'util/coordinates_shift.dart';

class Pawn extends Piece {
  Pawn(ColorChess color, Coordinates coordinates) : super(color, coordinates);

  @override
  Set<CoordinatesShift> getPieceMove() {
    Set<CoordinatesShift> result = HashSet();

    if (color == ColorChess.white) {
      {
        result.add(CoordinatesShift(0, 1));

        if (coordinates.rank == 2) {
          result.add(CoordinatesShift(0, 2));
        }

        result.add(CoordinatesShift(1, 1));
        result.add(CoordinatesShift(-1, 1));
      }
    } else {
      result.add(CoordinatesShift(0, -1));

      if (coordinates.rank == 7) {
        result.add(CoordinatesShift(0, -2));
      }

      result.add(CoordinatesShift(1, -1));
      result.add(CoordinatesShift(-1, -1));
    }

    return result;
  }

  @override
  Set<CoordinatesShift> getPieceAttacked() {
    Set<CoordinatesShift> result = HashSet();
    if (color == ColorChess.white) {
      result.add(CoordinatesShift(1, 1));
      result.add(CoordinatesShift(-1, 1));
    } else {
      result.add(CoordinatesShift(1, -1));
      result.add(CoordinatesShift(-1, -1));
    }

    return result;
  }

  @override
  bool isSquareAvailableForMove(Coordinates coordinates, Board board) {
    if (coordinates.file == this.coordinates.file) {
      var rankShift = (this.coordinates.rank - coordinates.rank).abs();
      if (rankShift == 2){
        var between = BoardUtils.getVerticalCoordinatesBetween(this.coordinates, coordinates);
        return board.isSquareEmpty(between[0]);
      } else {
        return board.isSquareEmpty(coordinates);
      }
    } else {
      if (board.isSquareEmpty(coordinates)) {
        return false;
      } else {
        return board.getPiece(coordinates).color != color;
      }
    }
  }
}
