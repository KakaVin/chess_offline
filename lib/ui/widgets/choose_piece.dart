import 'package:chess_offline/Boards/board_widget_renderer.dart';
import 'package:chess_offline/Pieces/bishop.dart';
import 'package:chess_offline/Pieces/knight.dart';
import 'package:chess_offline/Pieces/queen.dart';
import 'package:chess_offline/Pieces/rook.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Boards/board_console_renderer.dart';
import '../../Pieces/piece.dart';
import '../../Pieces/util/color_chess.dart';
import '../../Pieces/util/coordinates.dart';

class ChoosePiece extends StatelessWidget{
  Coordinates coordinates;
  ChoosePiece(this.coordinates, {Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorMove = context.read<GameProvider>().colorMovie;

    return RotatedBox(
      quarterTurns: (colorMove == ColorChess.white) ? 0 : 2,
      child: SimpleDialog(
        title: const Text("Choose piece"),
        children: [
          showChoosePiece(context, Queen(colorMove, coordinates)),
          showChoosePiece(context, Knight(colorMove,coordinates)),
          showChoosePiece(context, Rook(colorMove, coordinates)),
          showChoosePiece(context, Bishop(colorMove, coordinates)),
        ],
      ),
    );
  }

  showChoosePiece(BuildContext context, Piece piece) {
    return ListTile(
      selected: (piece is Queen) ? true : false,
      selectedColor: Colors.black,
      selectedTileColor: Colors.black12,
      leading: Text(
        BoardConsoleRenderer.selectUnicodeSpriteForPiece(piece),
        style: const TextStyle(
            fontSize: 30,
            color: BoardWidgetRenderer.blackPieceColor),
      ),
      title: Text(piece.runtimeType.toString()),
      onTap: () {
        Navigator.pop(context);
        print(piece.runtimeType.toString());
      },
    );
  }
}