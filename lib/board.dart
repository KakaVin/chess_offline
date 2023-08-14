import 'dart:collection';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/piece.dart';

class Board {
  HashMap<Coordinates, Piece> pieces = HashMap();

  void setPiece(Coordinates coordinates, Piece piece) {
    piece.coordinates = coordinates;
    pieces.putIfAbsent(coordinates, () => piece);
  }

  void removePeace(Coordinates coordinates) {
    pieces.remove(coordinates);
  }

  void movePeace(Coordinates from, Coordinates to) {
    Piece piece = getPiece(from);
    removePeace(from);
    setPiece(to, piece);
  }

  bool isSquareEmpty(Coordinates coordinates) {
    return !pieces.containsKey(coordinates);
  }

  Piece getPiece(Coordinates coordinates) {
    return pieces[coordinates]!;
  }

  static bool isSquareDark(Coordinates coordinates) {
    return ((coordinates.file.index + 1) + coordinates.rank) % 2 == 0;
  }

  bool isSquareAttackedByColor(Coordinates coordinates, ColorChess color) {
    List<Piece> pieces = getPiecesByColor(color);

    for (var piece in pieces){
      var attackedSquares = piece.getAttackedSquares(this);

      if (attackedSquares.contains(coordinates)){
        return true;
      }
    }
    return false;
  }

  List<Piece> getPiecesByColor(ColorChess oppositeColorChess) {
    List<Piece> result = [];

    for (var piece in pieces.values){
      if (piece.color == oppositeColorChess) {
        result.add(piece);
      }
    }
    return result;
  }
}
