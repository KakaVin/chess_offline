import 'package:chess_offline/Pieces/util/i_bishop.dart';
import 'package:chess_offline/Pieces/util/long_range_piece.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';

import 'util/coordinates_shift.dart';

class Bishop extends LongRangePiece with IBishop {
  Bishop(ColorChess color, Coordinates coordinates) : super(color, coordinates);

  @override
  Set<CoordinatesShift> getPieceMove() {
    return getBishopMoves();
  }
}
