import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';

class CastingChecker extends GameStateChecker {
  @override
  GameState check(Board board, ColorChess color) {
    if (board.moves.isNotEmpty) {
      var lastMove = board.moves.last;

      //moves white rook
      if (board.casting.whiteShort &&
          (lastMove.to == Coordinates(File.H, 1) ||
              lastMove.from == Coordinates(File.H, 1))) {
        board.casting.whiteShort = false;
      }
      if (board.casting.whiteLong &&
          (lastMove.to == Coordinates(File.A, 1) ||
              lastMove.from == Coordinates(File.A, 1))) {
        board.casting.whiteLong = false;
      }
      //moves white king
      if ((board.casting.whiteLong || board.casting.whiteShort) &&
          lastMove.from == Coordinates(File.E, 1)) {
        board.casting.whiteLong = board.casting.whiteShort = false;
      }

      //moves black rook
      if (board.casting.blackShort &&
          (lastMove.to == Coordinates(File.H, 8) ||
              lastMove.from == Coordinates(File.H, 8))) {
        board.casting.blackShort = false;
      }
      if (board.casting.blackLong &&
          (lastMove.to == Coordinates(File.A, 8) ||
              lastMove.from == Coordinates(File.A, 8))) {
        board.casting.blackLong = false;
      }
      //moves black king
      if ((board.casting.blackLong || board.casting.blackShort) &&
          lastMove.from == Coordinates(File.E, 8)) {
        board.casting.blackLong = board.casting.blackShort = false;
      }
    }

    return GameState.ongoing;
  }
}
