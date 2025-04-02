// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: 剣士（Swordsman）– 上下左右2マス（直進型）
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Swordsman extends Piece {
  Swordsman(String id, String owner, int x, int y) : super(id, owner, x, y);
  @override String get type => 'swordsman';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    final dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    final result = <List<int>>[];

    for (var d in dirs) {
      for (int i = 1; i <= 2; i++) {
        final nx = x + d[0] * i;
        final ny = y + d[1] * i;
        if (!board.canMoveTo(owner, nx, ny)) break;
        result.add([nx, ny]);
        if (board.isOccupied(nx, ny)) break;
      }
    }
    return result;
  }
  @override
  Piece copyWith({int? x, int? y}) {
    return Swordsman(id, owner, x ?? this.x, y ?? this.y);
  }

}
