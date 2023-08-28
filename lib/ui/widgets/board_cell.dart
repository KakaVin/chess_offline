import 'package:chess_offline/Boards/board_widget_renderer.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Pieces/util/color_chess.dart';

class BoardCell extends StatelessWidget {
  String sprite;
  ColorChess pieceColor;
  bool isSquareDark;
  bool isHighLight;
  Coordinates coordinates;

  BoardCell(this.sprite, this.pieceColor, this.isSquareDark, this.isHighLight,
      this.coordinates);

  Color getCellColor() {
    if (isHighLight) {
      return BoardWidgetRenderer.highlightedSquareBackground;
    } else if (isSquareDark) {
      return BoardWidgetRenderer.blackSquareBackgroundColor;
    } else {
      return BoardWidgetRenderer.whiteSquareBackgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GameProvider>().inputCoordinateTap(coordinates),
      child: Container(
          color: getCellColor(),
          width: BoardWidgetRenderer.cellWidth,
          height: BoardWidgetRenderer.cellWidth,
          child: Center(
              child: RotatedBox(
            quarterTurns:
                context.read<GameProvider>().colorMovie == ColorChess.white
                    ? 0
                    : 2,
            child: Text(
              sprite,
              style: TextStyle(
                  fontSize: 40,
                  color: (pieceColor == ColorChess.white)
                      ? BoardWidgetRenderer.whitePieceColor
                      : BoardWidgetRenderer.blackPieceColor),
            ),
          ))),
    );
  }
}
