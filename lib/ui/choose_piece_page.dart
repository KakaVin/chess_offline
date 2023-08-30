import 'package:chess_offline/Pieces/knight.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

import '../Boards/board_console_renderer.dart';
import '../Pieces/bishop.dart';
import '../Pieces/piece.dart';
import '../Pieces/queen.dart';
import '../Pieces/rook.dart';
import '../Pieces/util/color_chess.dart';
import '../Pieces/util/coordinates.dart';
import '../Pieces/util/file.dart';

class ChoosePiecePage extends StatelessWidget{
  const ChoosePiecePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (context.read<GameProvider>().colorMovie == ColorChess.white) ? Colors.white : Colors.grey,
      body: RotatedBox(
        quarterTurns: (context.read<GameProvider>().colorMovie == ColorChess.white) ? 0 : 2,
        child: SimpleDialog(
              title: const Text("Choose piece"),
              children: [
                showChoosePiece(context, Queen(ColorChess.white, Coordinates(File.A, 1))),
                showChoosePiece(context, Knight(ColorChess.white, Coordinates(File.A, 1))),
                showChoosePiece(context, Rook(ColorChess.white, Coordinates(File.A, 1))),
                showChoosePiece(context, Bishop(ColorChess.white, Coordinates(File.A, 1))),
              ],
            ),
      ),
    );
  }

  showChoosePiece(BuildContext context, Piece piece) {
    return ListTile(
      leading: Text(BoardConsoleRenderer
          .selectUnicodeSpriteForPiece(piece),
        style: const TextStyle(fontSize: 30),),
      title: Text(piece.runtimeType.toString()),
      onTap: () {
        Routemaster.of(context).pop();
        print(piece.runtimeType.toString());
      },
    );
  }

}