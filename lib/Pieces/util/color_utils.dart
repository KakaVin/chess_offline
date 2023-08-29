import 'color_chess.dart';

class ColorUtils{
  static ColorChess opposite(ColorChess color) {
    if (color == ColorChess.white) {
      return ColorChess.black;
    } else {
      return ColorChess.white;
    }
  }
}