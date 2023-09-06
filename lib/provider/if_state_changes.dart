import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class StateChanges {
  static ifStateChanges(BuildContext context) {
    if (context.read<GameProvider>().state == GameState.pawnOnEdgeOfBoard) {
      Routemaster.of(context).push("/game/select");
    }
    if (context.read<GameProvider>().state == GameState.checkMateToBlackKing) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              _showWinnerDialog(context, "White"));
    } else if (context.read<GameProvider>().state ==
        GameState.checkMateToWhiteKing) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              _showWinnerDialog(context, "Black"));
    } else if (context.read<GameProvider>().state == GameState.stalemate) {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              _showWinnerDialog(context, "Nobody"));
    }
  }

  static Widget _showWinnerDialog(BuildContext context, String whoWin) {
    return RotatedBox(
      quarterTurns:
          (context.read<GameProvider>().state == GameState.checkMateToBlackKing)
              ? 2
              : 0,
      child: AlertDialog(
        title: const Text("Game Ended"),
        content: Text("$whoWin won!"),
        actions: [
          TextButton(
              onPressed: () => Routemaster.of(context).pop(),
              child: const Text("Ok"))
        ],
      ),
    );
  }
}
