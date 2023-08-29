import 'package:chess_offline/Boards/board.dart';
import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/Boards/move.dart';
import 'package:chess_offline/Pieces/piece.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:chess_offline/game_state/game_state_checker.dart';

import '../Pieces/util/color_utils.dart';

class CheckmateGameStateChecker extends GameStateChecker {
  @override
  GameState check(Board board, ColorChess color) {
    Piece king = board.getKingByColor(color);
    if (!board.isSquareAttackedByColor(
        king.coordinates, ColorUtils.opposite(color))) {
      return GameState.ongoing;
    } else {
      var pieces = board.getPiecesByColor(color);

      for (var piece in pieces) {
        var availableMoveSquares = piece.getAvailableMoveSquares(board);

        for (var coordinates in availableMoveSquares) {
          var copy = BoardFactory().copy(board);
          copy.makeMove(Move(piece.coordinates, coordinates));

          var kingClone = copy.getKingByColor(color);

          if (!copy.isSquareAttackedByColor(
              kingClone.coordinates, ColorUtils.opposite(color))) {
            return GameState.ongoing;
          }
        }
      }
      if (color == ColorChess.white) {
        return GameState.checkMateToWhiteKing;
      } else {
        return GameState.checkMateToBlackKing;
      }
    }
  }
}
