import 'dart:collection';

import 'package:chess_offline/Pieces/util/coordinates_shift.dart';

mixin IRook {
  Set<CoordinatesShift> getRookMoves() {
    Set<CoordinatesShift> result = HashSet();
    //left to right
    for (var i = -7; i <= 7; i++) {
      if (i == 0) continue;
      result.add(CoordinatesShift(i, 0));
    }
    //bottom to top
    for (var i = -7; i <= 7; i++) {
      if (i == 0) continue;
      result.add(CoordinatesShift(0, i));
    }
    return result;
  }
}
