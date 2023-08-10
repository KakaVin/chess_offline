import 'dart:collection';

import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/piece.dart';

import 'util/coordinates_shift.dart';

class Knight extends Piece {
  Knight(ColorChess color, Coordinates coordinates) : super(color, coordinates);

  @override
  Set<CoordinatesShift> getPieceMove() {
    HashSet<CoordinatesShift> result = HashSet();
    result.add(CoordinatesShift(1, 2));
    result.add(CoordinatesShift(2, 1));

    result.add(CoordinatesShift(1, -2));
    result.add(CoordinatesShift(2, -1));

    result.add(CoordinatesShift(-2, -1));
    result.add(CoordinatesShift(-1, -2));

    result.add(CoordinatesShift(-2, 1));
    result.add(CoordinatesShift(-1, 2));

    return result;
  }
}
