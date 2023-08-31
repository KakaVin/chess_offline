import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Pieces/pawn.dart';
import 'package:chess_offline/Pieces/queen.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';

class PawnGameChecker extends GameStateChecker {
  @override
  GameState check(Board board, ColorChess color) {
    if (board.moves.isNotEmpty) {
      print(board.moves.last.to.rank);
      print(board.getPiece(board.moves.last.to) is Pawn);

      if ((board.moves.last.to.rank == 8 ||
              board.moves.last.to.rank == 1) &&
          board.getPiece(board.moves.last.to) is Pawn) {
        var queen = Queen((board.getPiece(board.moves.last.to)).color, board.moves.last.to);
        board.removePeace(board.moves.last.to);
        board.setPiece(
            board.moves.last.to, queen);
        return GameState.pawnOnEdgeOfBoard;
      }
    }
    return GameState.ongoing;
  }
}
