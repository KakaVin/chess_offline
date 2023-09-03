import 'dart:collection' show HashSet;

import 'package:chess_offline/Pieces/util/coordinates_shift.dart';

mixin IBishop {
  Set<CoordinatesShift> getBishopMoves() {
    Set<CoordinatesShift> result = HashSet();
    //bottom-left to top-right
    for (var i = -7; i <= 7; i++) {
      if (i == 0) continue;
      result.add(CoordinatesShift(i, i));
    }
    //top-left to bottom-right
    for (var i = -7; i <= 7; i++) {
      if (i == 0) continue;
      result.add(CoordinatesShift(i, -i));
    }
    return result;
  }
}
