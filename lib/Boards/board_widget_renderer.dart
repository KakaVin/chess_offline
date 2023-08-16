import 'package:chess_offline/Boards/board_console_renderer.dart';
import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:flutter/material.dart';

import '../Pieces/util/color_chess.dart';
import '../Pieces/util/coordinates.dart';
import 'board.dart';

class BoardWidgetRenderer {
  static const Color blackPieceColor = Colors.black;
  static const Color whitePieceColor = Colors.white;

  static const Color blackSquareBackgroundColor = Color(0xff996633);
  static const Color whiteSquareBackgroundColor = Colors.grey;

  static const Color highlightedSquareBackground = Colors.lightBlueAccent;

  static const double cellWidth = 50;

  BoardWidgetRenderer();

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
          line
              .add(_getPieceSprite(board.getPiece(coordinates), isHighLight));
        }
      }
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: line,
      );
      lineToRow.add(row);
    }
    return Column(
      children: lineToRow,
    );
  }

  Widget _getCellForEmptySquare(Coordinates coordinates, bool isHighLight) {
    return _colorizeSprite(
        " ", ColorChess.white, Board.isSquareDark(coordinates), isHighLight);
  }

  Widget _getPieceSprite(Piece piece, bool isHighLight) {
    return _colorizeSprite(
        BoardConsoleRenderer.selectUnicodeSpriteForPiece(piece),
        piece.color,
        Board.isSquareDark(piece.coordinates),
        isHighLight);
  }

  Widget _colorizeSprite(String sprite, ColorChess pieceColor,
      bool isSquareDark, bool isHighLight) {
    return Container(
        color: (isSquareDark)
            ? blackSquareBackgroundColor
            : whiteSquareBackgroundColor,
        width: cellWidth,
        height: cellWidth,
        child: Center(
            child: Text(
          sprite,
          style: TextStyle(
              fontSize: 40,
              color: (pieceColor == ColorChess.white)
                  ? whitePieceColor
                  : blackPieceColor),
        )));
  }
}
