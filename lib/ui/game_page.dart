import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

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
          ElevatedButton(
              onPressed: () {
                Routemaster.of(context).push("/game/ChoosePiece");
              },
              child: const Text("Piece"))
        ],
      ),
    );
  }
}
