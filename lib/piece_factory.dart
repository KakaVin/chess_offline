import 'package:chess_offline/Pieces/bishop.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/king.dart';
import 'package:chess_offline/Pieces/knight.dart';
import 'package:chess_offline/Pieces/pawn.dart';
import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/queen.dart';
import 'package:chess_offline/Pieces/rook.dart';

class PieceFactory {
  Piece fromFenChar(String char, Coordinates coordinates) {
    switch (char) {
      case 'k':
        return King(ColorChess.black, coordinates);
      case 'K':
        return King(ColorChess.white, coordinates);

      case 'q':
        return Queen(ColorChess.black, coordinates);
      case 'Q':
        return Queen(ColorChess.white, coordinates);

      case 'b':
        return Bishop(ColorChess.black, coordinates);
      case 'B':
        return Bishop(ColorChess.white, coordinates);

      case 'n':
        return Knight(ColorChess.black, coordinates);
      case 'N':
        return Knight(ColorChess.white, coordinates);

      case 'r':
        return Rook(ColorChess.black, coordinates);
      case 'R':
        return Rook(ColorChess.white, coordinates);

      case 'p':
        return Pawn(ColorChess.black, coordinates);
      case 'P':
        return Pawn(ColorChess.white, coordinates);

      default:
        throw RangeError("Unknown FEN char");
    }
  }
}
