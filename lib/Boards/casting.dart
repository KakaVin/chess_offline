class Casting {
  bool whiteLong, whiteShort;
  bool blackLong, blackShort;

  Casting(this.whiteLong, this.whiteShort, this.blackLong, this.blackShort);

  @override
  String toString() {
    return "whiteLong: $whiteLong whiteShort: $whiteShort blackLong: $blackLong blackShort $blackShort";
  }
}
