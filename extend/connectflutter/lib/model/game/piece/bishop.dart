// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: ♗ Bishop（斜め無限）
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Bishop extends Piece {
  Bishop(String id, String owner, int x, int y) : super(id, owner, x, y);

  @override
  String get type => 'bishop';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    return board.getLinearMoves(
      x,
      y,
      owner,
      directions: [
        [1, 1],
        [-1, -1],
        [1, -1],
        [-1, 1],
      ],
    );
  }

  @override
  Piece copyWith({int? x, int? y}) {
    return Bishop(id, owner, x ?? this.x, y ?? this.y);
  }
}
