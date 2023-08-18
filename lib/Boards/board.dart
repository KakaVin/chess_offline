import 'dart:collection';
import 'package:chess_offline/Boards/move.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/piece.dart';

import '../Pieces/king.dart';
import 'board_factory.dart';
import 'board_utils.dart';

class Board {
  HashMap<Coordinates, Piece> pieces = HashMap();
  String startingFen;
  List<Move> moves = [];

  Board(this.startingFen);

  void setPiece(Coordinates coordinates, Piece piece) {
    piece.coordinates = coordinates;
    pieces.putIfAbsent(coordinates, () => piece);
  }

  void removePeace(Coordinates coordinates) {
    pieces.remove(coordinates);
  }

  void makeMove(Move move) {
    Piece piece = getPiece(move.from);

    removePeace(move.from);
    removePeace(move.to);

    setPiece(move.to, piece);

    moves.add(move);
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

    for (var piece in pieces) {
      var attackedSquares = piece.getAttackedSquares(this);

      if (attackedSquares.contains(coordinates)) {
        return true;
      }
    }
    return false;
  }

  List<Piece> getPiecesByColor(ColorChess color) {
    List<Piece> result = [];

    for (var piece in pieces.values) {
      if (piece.color == color) {
        result.add(piece);
      }
    }
    return result;
  }

  static bool validateIfKingInCheckAfterMove(
      Board board, ColorChess color, Move move) {
    Board copy = BoardFactory().copy(board);
    copy.makeMove(move);
    //допущение - король имеется на доске
    late Piece king;
    for (var piece in copy.getPiecesByColor(color)) {
      if (piece is King) king = piece;
    }
    return copy.isSquareAttackedByColor(
        king.coordinates, BoardUtils.oppositeColorChess(color));
  }
}
