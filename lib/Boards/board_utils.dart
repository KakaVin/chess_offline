import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';

class BoardUtils {
  static List<Coordinates> getDiagonalCoordinatesBetween(
      Coordinates source, Coordinates target) {
    //one diagonal
    List<Coordinates> result = <Coordinates>[];

    int fileShift = (source.file.index < target.file.index) ? 1 : -1;
    int rankShift = (source.rank < target.rank) ? 1 : -1;

    for (var fileIndex = source.file.index + fileShift,
            rank = source.rank + rankShift;
        fileIndex != target.file.index && rank != target.rank;
        fileIndex += fileShift, rank += rankShift) {
      result.add(Coordinates(File.values[fileIndex], rank));
    }

    return result;
  }

  static List<Coordinates> getVerticalCoordinatesBetween(
      Coordinates source, Coordinates target) {
    //one vertical
    List<Coordinates> result = <Coordinates>[];

    int rankShift = (source.rank < target.rank) ? 1 : -1;

    for (int rank = source.rank + rankShift;
        rank != target.rank;
        rank += rankShift) {
      result.add(Coordinates(source.file, rank));
    }
    return result;
  }

  static List<Coordinates> getHorizontalCoordinatesBetween(
      Coordinates source, Coordinates target) {
    //one horizontal
    List<Coordinates> result = <Coordinates>[];

    int fileShift = (source.file.index < target.file.index) ? 1 : -1;

    for (var fileIndex = source.file.index + fileShift;
        fileIndex != target.file.index;
        fileIndex += fileShift) {
      result.add(Coordinates(File.values[fileIndex], source.rank));
    }

    return result;
  }
}
