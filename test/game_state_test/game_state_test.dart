import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/game_provider.dart';
import 'package:chess_offline/game_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("state male game check", (){
    test("not state male", (){
      GameProvider game = GameProvider(BoardFactory().fromFEN("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white), GameState.ongoing);
    });
    test("state male", (){

    });

  });
}