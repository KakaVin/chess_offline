import 'package:chess_offline/Boards/board_utils.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isGameAvailableToLoad =
        context.read<GameProvider>().isGameAvailableTOLoad;
    Function()? loadPress;

    if (isGameAvailableToLoad) {
      loadPress = () {
        Routemaster.of(context).push("/game");
        context.read<GameProvider>().loadGame();
      };
    }

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
              context.read<GameProvider>().newGame(BoardUtils.defaultBoard);
            },
            child: const Text("Новая партия"),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: loadPress,
            child: const Text("Продолжить"),
          ),
          const Spacer(
            flex: 3,
          )
        ],
      )),
    );
  }
}
