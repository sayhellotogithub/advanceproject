// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/03
// Description: ♕ Queen
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Queen extends Piece {
  Queen(String id, String owner, int x, int y) : super(id, owner, x, y);
  @override String get type => 'queen';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    return board.getLinearMoves(x, y, owner, directions: [
      [1, 0], [-1, 0], [0, 1], [0, -1],
      [1, 1], [-1, -1], [1, -1], [-1, 1],
    ]);
  }

  @override
  Piece copyWith({int? x, int? y}) {
    return Queen(id, owner, x ?? this.x, y ?? this.y);
  }
}