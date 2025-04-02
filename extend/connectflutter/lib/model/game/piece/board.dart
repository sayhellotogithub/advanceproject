// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

class Board {
  final int size;
  final List<Piece> pieces;

  Board(this.size, this.pieces);

  bool isInside(int x, int y) =>
      x >= 0 && y >= 0 && x < size && y < size;

  bool isOccupied(int x, int y) =>
      pieces.any((p) => p.x == x && p.y == y);

  bool isOccupiedBy(String owner, int x, int y) =>
      pieces.any((p) => p.x == x && p.y == y && p.owner == owner);

  bool canMoveTo(String owner, int x, int y) =>
      isInside(x, y) && !isOccupiedBy(owner, x, y);
}
