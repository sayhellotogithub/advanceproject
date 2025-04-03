// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:♘ Knight（ナイト）
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Knight extends Piece {
  Knight(String id, String owner, int x, int y) : super(id, owner, x, y);
  @override String get type => 'knight';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    const offsets = [
      [1, 2], [2, 1], [-1, 2], [-2, 1],
      [1, -2], [2, -1], [-1, -2], [-2, -1],
    ];
    return offsets
        .map((o) => [x + o[0], y + o[1]])
        .where((pos) => board.canMoveTo(owner, pos[0], pos[1]))
        .toList();
  }
  @override
  Piece copyWith({int? x, int? y}) {
    return Knight(id, owner, x ?? this.x, y ?? this.y);
  }
}
