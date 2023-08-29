import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';

class DrawGameStateChecker extends GameStateChecker {
  @override
  GameState check(Board board, ColorChess color) {
    if (board.halfMove >= 50) return GameState.draw;

    return GameState.ongoing;
  }
}
