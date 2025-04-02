// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: Knight（ナイト）
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Knight extends Piece {
  Knight(String id, String owner, int x, int y) : super(id, owner, x, y);
  @override String get type => 'knight';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    final moves = [
      [x + 1, y + 2], [x - 1, y + 2],
      [x + 1, y - 2], [x - 1, y - 2],
      [x + 2, y + 1], [x + 2, y - 1],
      [x - 2, y + 1], [x - 2, y - 1],
    ];
    return moves.where((pos) => board.canMoveTo(owner, pos[0], pos[1])).toList();
  }
  @override
  Piece copyWith({int? x, int? y}) {
    return Knight(id, owner, x ?? this.x, y ?? this.y);
  }
}
