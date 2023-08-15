import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Boards/board.dart';

class BoardWidget extends StatelessWidget {
  const BoardWidget({Key? key}) : super(key: key);

  static const Color blackPieceColor = Colors.black;
  static const Color whitePieceColor = Colors.white;

  static const Color blackSquareBackgroundColor = Color(0xff996633);
  static const Color whiteSquareBackgroundColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var file in File.values) ChessCell(Coordinates(file, 2)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var file in File.values) ChessCell(Coordinates(file, 1)),
          ],
        ),
      ],
    ));
  }
}

class ChessCell extends StatelessWidget {
  Coordinates coordinates;

  ChessCell(this.coordinates, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (Board.isSquareDark(coordinates))
          ? BoardWidget.blackSquareBackgroundColor
          : BoardWidget.whiteSquareBackgroundColor,
      width: 50,
      height: 50,
      child: Center(
          child: Text(
        context.read<GameProvider>().renderer.selectUnicodeSpriteForPiece(
            context.read<GameProvider>().board.getPiece(coordinates)),
        style: TextStyle(
            fontSize: 40,
            color: (context
                        .read<GameProvider>()
                        .board
                        .getPiece(coordinates)
                        .color ==
                    ColorChess.white)
                ? BoardWidget.whitePieceColor
                : BoardWidget.blackPieceColor),
      )),
    );
  }
}
