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
      if (board.casting[0] &&
          (lastMove.to == Coordinates(File.H, 1) ||
              lastMove.from == Coordinates(File.H, 1))) {
        board.casting[0] = false;
      }
      if (board.casting[1] &&
          (lastMove.to == Coordinates(File.A, 1) ||
              lastMove.from == Coordinates(File.A, 1))) {
        board.casting[1] = false;
      }
      //moves white king
      if ((board.casting[0] || board.casting[1]) &&
          lastMove.from == Coordinates(File.E, 1)) {
        board.casting[0] = board.casting[1] = false;
      }

      //moves black rook
      if (board.casting[2] &&
          (lastMove.to == Coordinates(File.H, 8) ||
              lastMove.from == Coordinates(File.H, 8))) {
        board.casting[2] = false;
      }
      if (board.casting[3] &&
          (lastMove.to == Coordinates(File.A, 8) ||
              lastMove.from == Coordinates(File.A, 8))) {
        board.casting[3] = false;
      }
      //moves black king
      if ((board.casting[2] || board.casting[3]) &&
          lastMove.from == Coordinates(File.E, 8)) {
        board.casting[2] = board.casting[3] = false;
      }
    }

    return GameState.ongoing;
  }
}
