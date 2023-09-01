import 'package:chess_offline/Pieces/util/file.dart';

import 'coordinates_shift.dart';

class Coordinates {
  final File file;
  final int rank;

  Coordinates(this.file, this.rank);

  Coordinates shift(CoordinatesShift shift) {
    return Coordinates(
        File.values[file.index + shift.fileShift], rank + shift.rankShift);
  }

  bool canShift(CoordinatesShift shift) {
    int f = file.index + shift.fileShift;
    int r = rank + shift.rankShift;
    if (f < 0 || f > 7) return false; // 1..7 good
    if (r < 1 || r > 8) return false; // 1..8 v
    return true;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinates &&
          runtimeType == other.runtimeType &&
          file == other.file &&
          rank == other.rank;

  @override
  int get hashCode => 31 * file.hashCode + rank.hashCode;

  @override
  String toString() {
    return "$file" + rank.toString();
  }
  String toSave(){
    switch (file) {
      case File.A:
        return "a" + rank.toString();
      case File.B:
        return "b" + rank.toString();
      case File.C:
        return "c" + rank.toString();
      case File.D:
        return "d" + rank.toString();
      case File.E:
        return "e" + rank.toString();
      case File.F:
        return "f" + rank.toString();
      case File.G:
        return "g" + rank.toString();
      default:
        return "h" + rank.toString();
    }
  }
}
