import 'package:chess_offline/Boards/board_console_renderer.dart';
import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/ui/widgets/board_cell.dart';
import 'package:flutter/material.dart';

import '../Pieces/util/color_chess.dart';
import '../Pieces/util/coordinates.dart';
import 'board.dart';

class BoardWidgetRenderer {
  static const Color blackPieceColor = Colors.black;
  static const Color whitePieceColor = Colors.white;

  static const Color blackSquareBackgroundColor = Color(0xff996633);
  static const Color whiteSquareBackgroundColor = Colors.grey;

  static const Color highlightedSquareBackground = Color(0x50006600);

  static const double cellWidth = 50;

  Column render(Board board, Piece? pieceToMove) {
    late List<Widget> lineToRow = [];

    Set<Coordinates> availableMoveSquares = {};
    if (pieceToMove != null) {
      availableMoveSquares = pieceToMove.getAvailableMoveSquares(board);
    }

    for (var rank = 8; rank >= 1; rank--) {
      List<Widget> line = [];
      for (File file in File.values) {
        Coordinates coordinates = Coordinates(file, rank);
        var isHighLight = availableMoveSquares.contains(coordinates);
        if (board.isSquareEmpty(coordinates)) {
          line.add(_getCellForEmptySquare(coordinates, isHighLight));
        } else {
          line.add(_getPieceSprite(board.getPiece(coordinates), isHighLight));
        }
      }
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: line,
      );
      lineToRow.add(row);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: lineToRow,
    );
  }

  Widget _getCellForEmptySquare(Coordinates coordinates, bool isHighLight) {
    return BoardCell(" ", ColorChess.white, Board.isSquareDark(coordinates),
        isHighLight, coordinates);
  }

  Widget _getPieceSprite(Piece piece, bool isHighLight) {
    return BoardCell(
        BoardConsoleRenderer.selectUnicodeSpriteForPiece(piece),
        piece.color,
        Board.isSquareDark(piece.coordinates),
        isHighLight,
        piece.coordinates);
  }
}
