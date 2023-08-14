import 'dart:collection';

import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/board.dart';

import 'util/coordinates_shift.dart';

abstract class Piece {
  final ColorChess color;
  Coordinates coordinates;

  Piece(this.color, this.coordinates);

  Set<Coordinates> getAvailableMoveSquares(Board board) {
    Set<Coordinates> result = HashSet();
    for (CoordinatesShift shift in getPieceMove()) {
      if (coordinates.canShift(shift)) {
        Coordinates newCoordinates = coordinates.shift(shift);
        if (isSquareAvailableForMove(newCoordinates, board)) {
          result.add(newCoordinates);
        }
      }
    }
    return result;
  }

  Set<CoordinatesShift> getPieceMove();

  bool isSquareAvailableForMove(Coordinates coordinates, Board board) {
    return board.isSquareEmpty(coordinates) ||
        board.getPiece(coordinates).color != color;
  }

  Set<Coordinates> getAttackedSquares(Board board) {
    Set<CoordinatesShift> pieceAttacked = getPieceAttacked();
    Set<Coordinates> result = HashSet();

    for (CoordinatesShift pieceAttack in pieceAttacked){
      if (coordinates.canShift(pieceAttack)){
        var shiftedCoordinates = coordinates.shift(pieceAttack);
        
        if (isSquareAvailableForAttack(shiftedCoordinates, board)){
          result.add(shiftedCoordinates);
        }
      }
    }

    return result;
  }

  Set<CoordinatesShift> getPieceAttacked() {
    return getPieceMove();
  }

  bool isSquareAvailableForAttack(Coordinates coordinates, Board board) {
    return true;
  }
}
