import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Pieces/util/piece_factory.dart';

import '../Pieces/util/color_chess.dart';
import '../Pieces/util/file.dart';

class BoardFactory {
  Board boardFromFEN(String fen) {
    List<String> parts = fen.split(" ");
    List<String> fenRows = parts[0].split("/");
    Board board = Board(fen);
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

  ColorChess colorFromFEN(String fen) {
    List<String> parts = fen.split(" ");
    if (parts[1] == "w") {
      return ColorChess.white;
    } else {
      return ColorChess.black;
    }
  }

  List<bool> canCastingFromFEN(String fen) {
    List<bool> result = [false, false, false, false];
    List<String> parts = fen.split(" ");
    String casting = parts[2];

    if (casting.contains("Q")) result[0] = true;
    if (casting.contains("K")) result[1] = true;
    if (casting.contains("q")) result[2] = true;
    if (casting.contains("k")) result[3] = true;

    return result;
  }

  Board copy(Board source) {
    Board result = boardFromFEN(source.startingFen);

    for (var move in source.moves) {
      result.makeMove(move);
    }

    return result;
  }

  String toFen(Board board) {
    var result = "";
    for (var rank = 8; rank > 0; rank--) {
      var spaceCount = 0;
      for (var file in File.values) {
        if (board.isSquareEmpty(Coordinates(file, rank))) {
          spaceCount++;
        } else {
          if (spaceCount != 0) {
            result += spaceCount.toString();
            spaceCount = 0;
          }
          result += PieceFactory()
              .pieceFromFen(board.getPiece(Coordinates(file, rank)));
        }
      }
      if (spaceCount != 0) {
        result += spaceCount.toString();
      }
      result += "/";
    }
    return result;
  }
}
