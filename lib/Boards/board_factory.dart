import 'package:chess_offline/Boards/casting.dart';
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

  Casting canCastingFromFEN(String fen) {
    Casting result = Casting(false, false, false, false);
    List<String> parts = fen.split(" ");
    String casting = parts[2];

    if (casting.contains("Q")) result.whiteLong = true;
    if (casting.contains("K")) result.whiteShort = true;
    if (casting.contains("q")) result.blackLong = true;
    if (casting.contains("k")) result.blackShort = true;

    return result;
  }

  Coordinates? enPassantFromFen(String fen) {
    List<String> parts = fen.split(" ");
    String enPassant = parts[3];
    Coordinates result;

    if (enPassant.length == 1) {
      return null;
    } else {
      switch (enPassant[0]) {
        case "a":
          result = Coordinates(File.A, int.parse(enPassant[1]));
          break;
        case "b":
          result = Coordinates(File.B, int.parse(enPassant[1]));
          break;
        case "c":
          result = Coordinates(File.C, int.parse(enPassant[1]));
          break;
        case "d":
          result = Coordinates(File.D, int.parse(enPassant[1]));
          break;
        case "e":
          result = Coordinates(File.E, int.parse(enPassant[1]));
          break;
        case "f":
          result = Coordinates(File.F, int.parse(enPassant[1]));
          break;
        case "g":
          result = Coordinates(File.G, int.parse(enPassant[1]));
          break;
        default:
          result = Coordinates(File.H, int.parse(enPassant[1]));
      }
      return result;
    }
  }

  Board copy(Board source) {
    Board result = boardFromFEN(source.startingFen);

    for (var move in source.moves) {
      result.makeMove(move);
    }

    return result;
  }

  String toFEN(Board board, ColorChess color) {
    var result = boardToFEN(board);
    result += infoToFEN(board, color);

    return result;
  }

  int fullMoveFromFEN(String fen) {
    List<String> parts = fen.split(" ");
    String fullMove = parts[5];

    return int.parse(fullMove);
  }

  int halfMoveFromFEN(String fen) {
    List<String> parts = fen.split(" ");
    String halfMove = parts[4];

    return int.parse(halfMove);
  }

  String boardToFEN(Board board) {
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
      if (rank != 1) result += "/";
    }
    return result;
  }

  String infoToFEN(Board board, ColorChess color) {
    String result = "";

    //active color
    if (color == ColorChess.white) {
      result += " w";
    } else {
      result += " b";
    }
    //castingAvailable
    var casting = " ";
    if (board.casting.whiteShort) casting += "K";
    if (board.casting.whiteLong) casting += "Q";
    if (board.casting.blackShort) casting += "k";
    if (board.casting.blackLong) casting += "q";
    if (casting.length == 1) casting += "-";
    result += casting;
    //En passant target square
    if (board.enPassant != null) {
      result += " " + board.enPassant!.toSave();
    } else {
      result += " -";
    }
    //Half move
    result += " " + board.halfMove.toString();
    //Full move
    result += " " + board.fullMove.toString();

    print(result);
    return result;
  }
}
