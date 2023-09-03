import 'package:chess_offline/Pieces/util/i_bishop.dart';
import 'package:chess_offline/Pieces/util/i_rook.dart';
import 'package:chess_offline/Pieces/util/long_range_piece.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';

import 'util/coordinates_shift.dart';

class Queen extends LongRangePiece with IRook, IBishop {
  Queen(ColorChess color, Coordinates coordinates) : super(color, coordinates);

  @override
  Set<CoordinatesShift> getPieceMove() {
    Set<CoordinatesShift> moves = getBishopMoves();
    moves.addAll(getRookMoves());

    return moves;
  }
}
