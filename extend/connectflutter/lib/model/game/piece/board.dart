// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:
// -------------------------------------------------------------------
import 'package:collection/collection.dart';
import 'package:connectflutter/model/game/piece/piece.dart';

class Board {
  final int size;
  final List<Piece> pieces;

  Board(this.size, this.pieces);

  bool isInside(int x, int y) => x >= 0 && y >= 0 && x < size && y < size;

  bool isEmpty(int x, int y) => !isOccupied(x, y);

  bool isOccupied(int x, int y) => pieces.any((p) => p.x == x && p.y == y);

  bool isOccupiedBy(String owner, int x, int y) =>
      pieces.any((p) => p.x == x && p.y == y && p.owner == owner);

  bool canMoveTo(String owner, int x, int y) =>
      isInside(x, y) && !isOccupiedBy(owner, x, y);

  Piece? getPieceAt(int x, int y) {
    return pieces.firstWhereOrNull((p) => p.x == x && p.y == y);
  }

  List<List<int>> getLinearMoves(
    int x,
    int y,
    String owner, {
    required List<List<int>> directions,
  }) {
    List<List<int>> moves = [];
    for (final dir in directions) {
      int dx = dir[0];
      int dy = dir[1];
      int cx = x + dx;
      int cy = y + dy;

      while (isInside(cx, cy)) {
        final target = getPieceAt(cx, cy);
        if (target == null) {
          moves.add([cx, cy]);
        } else {
          if (target.owner != owner) {
            moves.add([cx, cy]); // 敵の駒は取れる
          }
          break; // 自分 or 敵がいるとそれ以上進めない
        }
        cx += dx;
        cy += dy;
      }
    }
    return moves;
  }
}
