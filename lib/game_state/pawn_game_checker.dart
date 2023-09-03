import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Pieces/pawn.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';

class PawnGameChecker extends GameStateChecker {
  @override
  GameState check(Board board, ColorChess color) {
    if (board.moves.isNotEmpty) {
      if ((board.moves.last.to.rank == 8 || board.moves.last.to.rank == 1) &&
          board.getPiece(board.moves.last.to) is Pawn) {
        return GameState.pawnOnEdgeOfBoard;
      }
    }
    return GameState.ongoing;
  }
}
