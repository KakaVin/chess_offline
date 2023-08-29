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
      GameProvider game = GameProvider(
          "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
    });
    test("state male", () {
      GameProvider game =
          GameProvider("8/8/8/8/6p1/2k2pP1/2p2P2/2K4N w - - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.stalemate);
    });
    test("state male after move", () {
      GameProvider game = GameProvider("4k3/4P3/8/4K3/8/8/8/8 w - - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      game.board.makeMove(Move(Coordinates(File.E, 5), Coordinates(File.E, 6)));
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.stalemate);
    });
  });
  group("check mate game check", () {
    test("mate", () {
      GameProvider game = GameProvider(
          "rnb1kbnr/pppp1ppp/8/4p3/6Pq/5P2/PPPPP2P/RNBQKBNR w KQkq - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.checkMateToWhiteKing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
    test("mate", () {
      GameProvider game =
          GameProvider("k2r4/8/8/8/8/2P1P3/2PKP3/2PPP3 w - - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.checkMateToWhiteKing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
    test("not mate", () {
      GameProvider game =
          GameProvider("k2r4/7R/8/8/8/2P1P3/2PKP3/2PPP3 w - - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
    });
    test("not mate", () {
      GameProvider game =
          GameProvider("k2r3R/8/8/8/8/2P1P3/2PKP3/2PPP3 w - - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
  });
  group("normal game", () {
    test("normal", () {
      GameProvider game = GameProvider(
          "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
    test("normal", () {
      GameProvider game = GameProvider(
          "rnbqkbnr/ppp2ppp/3p4/1P2Q1PP/8/2p5/PPP3PP/RNB1KBNR w KQkq - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
    test("normal", () {
      GameProvider game = GameProvider("RRRRRRRK/6k1/8/8/8/8/8/8 w - - 0 1");
      expect(game.determinateGameState(game.board, ColorChess.white),
          GameState.ongoing);
      expect(game.determinateGameState(game.board, ColorChess.black),
          GameState.ongoing);
    });
  });

  group("draw game", () {
    GameProvider game =
        GameProvider("r3k2r/pp4pp/1B6/8/6b1/8/8/R3KB1R w KQkq - 0 1");

    test("normal move", () {
      for (var i = 0; i < 12; i++) {
        game.inputCoordinateTap(Coordinates(File.A, 1));
        game.inputCoordinateTap(Coordinates(File.A, 2));

        game.inputCoordinateTap(Coordinates(File.A, 8));
        game.inputCoordinateTap(Coordinates(File.B, 8));

        game.inputCoordinateTap(Coordinates(File.A, 2));
        game.inputCoordinateTap(Coordinates(File.A, 1));

        game.inputCoordinateTap(Coordinates(File.B, 8));
        game.inputCoordinateTap(Coordinates(File.A, 8));

        expect(game.state, GameState.ongoing);
      }
    });
    test("draw", () {
      game.inputCoordinateTap(Coordinates(File.A, 1));
      game.inputCoordinateTap(Coordinates(File.A, 2));

      game.inputCoordinateTap(Coordinates(File.A, 8));
      game.inputCoordinateTap(Coordinates(File.B, 8));

      expect(game.state, GameState.draw);
    });
  });
}
