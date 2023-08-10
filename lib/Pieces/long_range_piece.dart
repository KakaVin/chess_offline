import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/coordinates_shift.dart';
import 'package:chess_offline/board.dart';

import '../Boards/board_utils.dart';

class LongRangePiece extends Piece {
  LongRangePiece(ColorChess color, Coordinates coordinates)
      : super(color, coordinates);

  @override
  Set<CoordinatesShift> getPieceMove() {
    // TODO: implement getPieceMove
    throw UnimplementedError();
  }

  @override
  bool isSquareAvailableForMove(Coordinates coordinates, Board board) {
    bool result = super.isSquareAvailableForMove(coordinates, board);

    if (result) {
      List<Coordinates> coordinatesBetween;
      if (this.coordinates.file == coordinates.file) {
        coordinatesBetween = BoardUtils.getVerticalCoordinatesBetween(
            this.coordinates, coordinates);
      } else if (this.coordinates.rank == coordinates.rank) {
        coordinatesBetween = BoardUtils.getHorizontalCoordinatesBetween(
            this.coordinates, coordinates);
      } else {
        coordinatesBetween = BoardUtils.getDiagonalCoordinatesBetween(
            this.coordinates, coordinates);
      }
      for (var e in coordinatesBetween) {
        if (!board.isSquareEmpty(e)) return false;
      }
    } else {
      return false;
    }
    return true;
  }
}
