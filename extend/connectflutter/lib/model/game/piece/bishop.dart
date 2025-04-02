// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: Bishop（斜め無限）
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Bishop extends Piece {
  Bishop(String id, String owner, int x, int y) : super(id, owner, x, y);

  @override
  String get type => 'bishop';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    final dirs = [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1],
    ];
    final result = <List<int>>[];

    for (var d in dirs) {
      int nx = x + d[0], ny = y + d[1];
      while (board.canMoveTo(owner, nx, ny)) {
        result.add([nx, ny]);
        if (board.isOccupied(nx, ny)) break;
        nx += d[0];
        ny += d[1];
      }
    }
    return result;
  }

  @override
  Piece copyWith({int? x, int? y}) {
    return Bishop(id, owner, x ?? this.x, y ?? this.y);
  }
}
