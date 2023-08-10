import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/piece.dart';

import 'util/coordinates_shift.dart';

class King extends Piece {
  King(ColorChess color, Coordinates coordinates) : super(color, coordinates);

  @override
  Set<CoordinatesShift> getPieceMove() {
    // TODO: implement getPieceMove
    throw UnimplementedError();
  }
}
