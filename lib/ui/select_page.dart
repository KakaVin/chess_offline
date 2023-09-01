import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:chess_offline/ui/widgets/choose_piece.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPage extends StatelessWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment:
                  (context.read<GameProvider>().colorMovie == ColorChess.black)
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
              children: [
                context.read<GameProvider>().boardWidget,
              ],
            ),
            Column(
              mainAxisAlignment:
                  (context.read<GameProvider>().colorMovie == ColorChess.black)
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
              children: [
                ChoosePiece(context.read<GameProvider>().board.moves.last.to),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
