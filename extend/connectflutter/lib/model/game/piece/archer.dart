// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: 弓兵（Archer）– 斜め1マス
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Archer extends Piece {
  Archer(String id, String owner, int x, int y) : super(id, owner, x, y);
  @override String get type => 'archer';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    final dirs = [[-1, -1], [-1, 1], [1, -1], [1, 1]];
    return dirs.map((d) => [x + d[0], y + d[1]])
        .where((pos) => board.canMoveTo(owner, pos[0], pos[1]))
        .toList();
  }
  @override
  Piece copyWith({int? x, int? y}) {
    return Archer(id, owner, x ?? this.x, y ?? this.y);
  }
}