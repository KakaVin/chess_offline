import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';

import '../Boards/move.dart';
import '../Pieces/pawn.dart';

class EnPassantGameChecker extends GameStateChecker {
  @override
  GameState check(Board board, ColorChess color) {
    if (board.moves.isNotEmpty && board.getPiece(board.moves.last.to) is Pawn && Move.rankShift(board.moves.last) == 2) {
      if ((board.getPiece(board.moves.last.to) as Pawn).color == ColorChess.white) {
        board.enPassant = Coordinates(board.moves.last.to.file, board.moves.last.to.rank - 1);
      } else {
        board.enPassant = Coordinates(board.moves.last.to.file, board.moves.last.to.rank + 1);
      }
    } else {
      board.enPassant = null;
    }
    return GameState.ongoing;
  }
}
