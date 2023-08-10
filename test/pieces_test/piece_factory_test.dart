import 'package:chess_offline/Pieces/util/color_chess.dart';
import 'package:chess_offline/Pieces/util/coordinates.dart';
import 'package:chess_offline/Pieces/util/file.dart';
import 'package:chess_offline/Pieces/knight.dart';
import 'package:chess_offline/Pieces/pawn.dart';
import 'package:chess_offline/piece_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PieceFactory factory = PieceFactory();
  Coordinates coordinates = Coordinates(File.A, 1);

  test("get black pawn", (){
    expect((factory.fromFenChar("p", coordinates) is Pawn), true);
    expect((factory.fromFenChar("p", coordinates) as Pawn).color, ColorChess.black);
  });
  test("get white Knight", (){
    expect((factory.fromFenChar("N", coordinates) is Knight), true);
    expect((factory.fromFenChar("N", coordinates) as Knight).color, ColorChess.white);
  });
  test("get unknown char", (){
    expect(() => throw factory.fromFenChar("g", coordinates), throwsA(isA<RangeError>()));
  });
}