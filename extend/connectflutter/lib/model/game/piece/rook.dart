// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: 
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Rook extends Piece {
  Rook(String id, String owner, int x, int y) : super(id, owner, x, y);
  @override String get type => 'rook';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    final dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
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
    return Rook(id, owner, x ?? this.x, y ?? this.y);
  }
}
