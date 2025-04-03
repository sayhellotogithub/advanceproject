// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/03
// Description: ♙ Pawn
// ✅ 前に1マス	基本の移動。空いている必要あり。
// ✅ 初手のみ前に2マス	1歩目だけ 2マス前進できる。間も空いている必要あり。
// ✅ 斜め前に1マス取り	敵駒がある場合のみ、斜め1マスに移動して取れる。
// ❌ 後退・横移動	不可。
// ✅ 昇格（プロモーション）	最終ランクに到達したら、Queen 等に昇格できる。
// ✅ アンパッサン（en passant）	特殊ルール。相手が2マス進んだ直後に隣接していると1回だけ取れる。
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/piece/piece.dart';

import 'board.dart';

class Pawn extends Piece {
  Pawn(String id, String owner, int x, int y) : super(id, owner, x, y);

  @override
  String get type => 'pawn';

  @override
  List<List<int>> getAvailableMoves(Board board) {
    List<List<int>> moves = [];
    int dy = owner == 'p1' ? -1 : 1;
    int startRow = owner == 'p1' ? 6 : 1;
    int promotionRow = owner == 'p1' ? 0 : 7;

    // 前進 1 マス
    if (board.isInside(x, y + dy) && board.isEmpty(x, y + dy)) {
      moves.add([x, y + dy]);

      // 初手 2 マス
      if (y == startRow && board.isEmpty(x, y + dy * 2)) {
        moves.add([x, y + dy * 2]);
      }
    }

    // 斜め攻撃
    for (int dx in [-1, 1]) {
      int nx = x + dx;
      int ny = y + dy;
      if (board.isInside(nx, ny)) {
        final target = board.getPieceAt(nx, ny);
        if (target != null && target.owner != owner) {
          moves.add([nx, ny]);
        }
      }
    }

    return moves;
  }

  @override
  Piece copyWith({int? x, int? y}) => Pawn(id, owner, x ?? this.x, y ?? this.y);
}
