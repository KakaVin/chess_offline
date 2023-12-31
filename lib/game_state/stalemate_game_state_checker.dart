import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/color_utils.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';

class StalemateGameStateChecker extends GameStateChecker {
  @override
  GameState check(Board board, ColorChess color) {
    if (board.halfMove >= 50) return GameState.stalemate;

    var pieces = board.getPiecesByColor(color);
    for (var piece in pieces) {
      var availableMoveSquares = piece.getAvailableMoveSquares(board);
      if (availableMoveSquares.isNotEmpty) {
        return GameState.ongoing;
      }
    }
    if (!board.isSquareAttackedByColor(
        board.getKingByColor(color).coordinates, ColorUtils.opposite(color))) {
      return GameState.stalemate;
    } else {
      return GameState.ongoing;
    }
  }
}
