import 'dart:collection';

import 'package:chess_offline/Boards/board_utils.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/piece.dart';

import '../Boards/board.dart';
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
    return result;
  }

  @override
  bool isSquareAvailableForMove(Coordinates coordinates, Board board) {
    bool result = super.isSquareAvailableForMove(coordinates, board);
    if (!result) return result;
    return !board.isSquareAttackedByColor(
        coordinates, BoardUtils.oppositeColorChess(color));
  }
}
