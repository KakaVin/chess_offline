import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          ElevatedButton(
            onPressed: () {
              Routemaster.of(context).push("/game");
              context.read<GameProvider>().newGame(
                  BoardFactory().fromFEN(
                      "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"),
                  ColorChess.white);
            },
            child: const Text("Новая партия"),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Routemaster.of(context).push("/game");
              context.read<GameProvider>().loadGame();
            },
            child: Text("Продолжить"),
          ),
          const Spacer(
            flex: 3,
          )
        ],
      )),
    );
  }
}
