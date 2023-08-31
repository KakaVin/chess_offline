import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:chess_offline/ui/widgets/choose_piece.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = "№ ${context.read<GameProvider>().board.fullMove} ";
    if (context.read<GameProvider>().board.halfMove > 25) {
      text += " - " + context.read<GameProvider>().board.halfMove.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(text)),
      ),
      body: Stack(
        children: [
          Center(child: context.watch<GameProvider>().boardWidget),
          (context.read<GameProvider>().state == GameState.pawnOnEdgeOfBoard) ? _showSelectedPiece(context) : const Center(),
        ],
      ),
    );
  }

  Widget _showSelectedPiece(BuildContext context){
    //context.read<GameProvider>().determinateGameState(context.read<GameProvider>().board, context.read<GameProvider>().colorMovie);
    showDialog(
      context: context,
      builder: (BuildContext context) => ChoosePiece(Coordinates(File.F, 1)));
    return const Center();
  }
}
