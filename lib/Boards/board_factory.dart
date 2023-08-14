import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/piece_factory.dart';

import '../Pieces/util/file.dart';

class BoardFactory {
  Board fromFEN(String fen) {
    List<String> parts = fen.split(" ");
    List<String> fenRows = parts[0].split("/");
    Board board = Board();
    PieceFactory _pieceFactory = PieceFactory();

    for (int i = 0; i < fenRows.length; i++) {
      String row = fenRows[i];
      int rank = 8 - i;
      int fileIndex = 0;

      for (var j = 0; j < row.length; j++) {
        String fenChar = row[j];
        int fenCharIndex = fenChar.codeUnitAt(0);

        if (fenCharIndex > "0".codeUnitAt(0) &&
            fenCharIndex < "9".codeUnitAt(0)) {
          fileIndex += int.tryParse(fenChar)!;
        } else {
          File file = File.values[fileIndex];
          Coordinates coordinates = Coordinates(file, rank);
          board.setPiece(
              coordinates, _pieceFactory.fromFenChar(fenChar, coordinates));
          fileIndex++;
        }
      }
    }

    return board;
  }
}
