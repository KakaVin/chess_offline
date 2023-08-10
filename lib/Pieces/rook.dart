import 'package:chess_offline/Pieces/i_rook.dart';
import 'package:chess_offline/Pieces/long_range_piece.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';

import 'util/coordinates_shift.dart';

class Rook extends LongRangePiece with IRook {
  Rook(ColorChess color, Coordinates coordinates) : super(color, coordinates);

  @override
  Set<CoordinatesShift> getPieceMove() {
    return getRookMoves();
  }
}
