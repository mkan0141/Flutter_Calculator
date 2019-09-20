bool isDigit(String s, int idx) {
  return (s.codeUnitAt(idx) ^ 0x30) <= 9;
}