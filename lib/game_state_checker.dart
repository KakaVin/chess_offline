import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/game_state.dart';

import 'Boards/board.dart';

abstract class GameStateChecker {
  GameState check(Board board, ColorChess color);
}
