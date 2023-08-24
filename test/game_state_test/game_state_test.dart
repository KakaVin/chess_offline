import 'package:chess_offline/Boards/board_factory.dart';
import 'package:chess_offline/Boards/move.dart';
import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/provider/game_provider.dart';
import 'package:chess_offline/game_state/game_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("state male game check", () {
    test("not state male", () {
      GameProvider game = GameProvider(BoardFactory()
          .fromFEN("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
    });
    test("state male", () {
      GameProvider game = GameProvider(
          BoardFactory().fromFEN("8/8/8/8/6p1/2k2pP1/2p2P2/2K4N w - - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.stalemate);
    });
    test("state male after move", () {
      GameProvider game = GameProvider(
          BoardFactory().fromFEN("4k3/4P3/8/4K3/8/8/8/8 w - - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      game.board.makeMove(Move(Coordinates(File.E, 5), Coordinates(File.E, 6)));
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.stalemate);
    });
  });
  group("check mate game check", () {
    test("mate", () {
      GameProvider game = GameProvider(BoardFactory().fromFEN(
          "rnb1kbnr/pppp1ppp/8/4p3/6Pq/5P2/PPPPP2P/RNBQKBNR w KQkq - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.checkMateToWhiteKing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
    test("mate", () {
      GameProvider game = GameProvider(
          BoardFactory().fromFEN("k2r4/8/8/8/8/2P1P3/2PKP3/2PPP3 w - - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.checkMateToWhiteKing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
    test("not mate", () {
      GameProvider game = GameProvider(
          BoardFactory().fromFEN("k2r4/7R/8/8/8/2P1P3/2PKP3/2PPP3 w - - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
    });
    test("not mate", () {
      GameProvider game = GameProvider(
          BoardFactory().fromFEN("k2r3R/8/8/8/8/2P1P3/2PKP3/2PPP3 w - - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
  });
  group("normal game", () {
    test("normal", () {
      GameProvider game = GameProvider(BoardFactory()
          .fromFEN("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
    test("normal", () {
      GameProvider game = GameProvider(BoardFactory().fromFEN(
          "rnbqkbnr/ppp2ppp/3p4/1P2Q1PP/8/2p5/PPP3PP/RNB1KBNR w KQkq - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
    test("normal", () {
      GameProvider game = GameProvider(
          BoardFactory().fromFEN("RRRRRRRK/6k1/8/8/8/8/8/8 w - - 0 1"));
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
  });
}
