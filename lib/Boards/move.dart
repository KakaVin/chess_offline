import 'package:chess_offline/Pieces/util/coordinates.dart';

class Move {
  Coordinates from, to;

  Move(this.from, this.to);

  static int rankShift(Move move) {
    return (move.from.rank - move.to.rank).abs();
  }

  static int fileShift(Move move) {
    return (move.from.file.index - move.to.file.index).abs();
  }
}
