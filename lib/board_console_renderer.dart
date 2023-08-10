import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/board.dart';

class BoardConsoleRenderer {
  static const String ansiReset = "\u001B[0m";
  static const String ansiWhitePieceColor = "\u001B[97m";
  static const String ansiBlackPieceColor = "\u001B[30m";

  static const String ansiWhiteSquareBackground = "\u001B[47m";

  static const String ansiBlackSquareBackground = "\u001B[0;100m";

  static const String ansiHighlightedSquareBackground = "\u001B[45m";

  void render(Board board, Piece? pieceToMove) {
    Set<Coordinates> availableMoveSquares = {};
    if (pieceToMove != null) {
      availableMoveSquares = pieceToMove.getAvailableMoveSquares(board);
    }
    for (var rank = 8; rank >= 1; rank--) {
      String line = "";
      for (File file in File.values) {
        Coordinates coordinates = Coordinates(file, rank);
        var isHighLight = availableMoveSquares.contains(coordinates);
        if (board.isSquareEmpty(coordinates)) {
          line +=
              _getSpriteForEmptySquare(Coordinates(file, rank), isHighLight);
        } else {
          line += _getPieceSprite(board.getPiece(coordinates), isHighLight);
        }
      }
      line += ansiReset;
      print(line);
    }
  }

  String _colorizeSprite(String sprite, ColorChess pieceColor,
      bool isSquareDark, bool isHighLight) {
    String result = sprite;
    if (pieceColor == ColorChess.white) {
      result = ansiWhitePieceColor + result;
    } else {
      result = ansiBlackPieceColor + result;
    }
    if (isHighLight) {
      result = ansiHighlightedSquareBackground + result;
    } else if (isSquareDark) {
      result = ansiBlackSquareBackground + result;
    } else {
      result = ansiWhiteSquareBackground + result;
    }
    return result;
  }

  String _selectUnicodeSpriteForPiece(Piece piece) {
    switch (piece.runtimeType.toString()) {
      case "Pawn":
        return "♟︎";

      case "Knight":
        return "♞";

      case "Bishop":
        return "♝";

      case "Rook":
        return "♜";

      case "Queen":
        return "♛";

      case "King":
        return "♚";

      default:
        return "";
    }
  }

  String _getSpriteForEmptySquare(Coordinates coordinates, bool isHighLight) {
    return _colorizeSprite(
        "    ", ColorChess.white, Board.isSquareDark(coordinates), isHighLight);
  }

  String _getPieceSprite(Piece piece, bool isHighLight) {
    return _colorizeSprite(" ${_selectUnicodeSpriteForPiece(piece)} ",
        piece.color, Board.isSquareDark(piece.coordinates), isHighLight);
  }
}
