import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/board.dart';

import 'Pieces/piece.dart';

class InputCoordinates {
  static Coordinates input(Coordinates coordinates) {
    return coordinates;
  }

  static Coordinates inputPieceCoordinatesForColor(
      ColorChess color, Board board) {
    Coordinates coordinates = Coordinates(File.A, 0);

    Piece piece = board.getPiece(coordinates);
    // if color != piece.color
    var availableMoveSquares = piece.getAvailableMoveSquares(board);
    //if availableMoveSquares!= 0
    return coordinates;
  }
}
