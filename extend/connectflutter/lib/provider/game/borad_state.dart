// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:
// -------------------------------------------------------------------
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/game/piece/archer.dart';
import '../../model/game/piece/board.dart';
import '../../model/game/piece/king.dart';
import '../../model/game/piece/piece.dart';
import 'lan_connection_service.dart';

class BoardState {
  final List<Piece> pieces;
  final Piece? selectedPiece;
  final List<List<int>> highlightedCells;

  BoardState({
    required this.pieces,
    this.selectedPiece,
    this.highlightedCells = const [],
  });

  BoardState copyWith({
    List<Piece>? pieces,
    Piece? selectedPiece,
    List<List<int>>? highlightedCells,
  }) {
    return BoardState(
      pieces: pieces ?? this.pieces,
      selectedPiece: selectedPiece,
      highlightedCells: highlightedCells ?? this.highlightedCells,
    );
  }
}

class BoardController extends StateNotifier<BoardState> {
  static const int boardSize = 9;

  BoardController()
    : super(
        BoardState(
          pieces: [
            King('k1', 'p1', 4, 8),
            King('k2', 'p2', 4, 0),
            Archer('a1', 'p1', 2, 8),
            Archer('a2', 'p2', 6, 0),
          ],
        ),
      );

  void onCellTap(int x, int y,WidgetRef ref) {
    final tapped = state.pieces.firstWhereOrNull((p) => p.x == x && p.y == y);

    if (tapped != null && tapped.owner == 'p1') {
      // 自分の駒をタップした場合 → 選択してハイライト
      final board = Board(boardSize, state.pieces);
      final moves = tapped.getAvailableMoves(board);
      state = state.copyWith(selectedPiece: tapped, highlightedCells: moves);
    } else if (state.selectedPiece != null &&
        state.highlightedCells.any((c) => c[0] == x && c[1] == y)) {
      // 駒を移動させる
      final moved = state.selectedPiece!.copyWith(x: x, y: y);
      final updated =
          state.pieces
              .map((p) {
                if (p.id == moved.id) return moved;
                if (p.x == x && p.y == y && p.owner != moved.owner)
                  return null; // 相手駒を取る
                return p;
              })
              .whereType<Piece>()
              .toList();

      movePieceRemotely(state.selectedPiece!, x, y, ref);
      state = state.copyWith(
        pieces: updated,
        selectedPiece: null,
        highlightedCells: [],
      );

    } else {
      // それ以外 → 選択解除
      state = state.copyWith(selectedPiece: null, highlightedCells: []);
    }
  }

  void movePieceRemotely(Piece piece, int x, int y, WidgetRef ref) {
    final moved = piece.copyWith(x: x, y: y);
    final updatedPieces = [...state.pieces.map((p) => p.id == moved.id ? moved : p)];
    state = state.copyWith(pieces: updatedPieces);

    // 👇 通信で送る
    ref.read(lanConnectionProvider).send({
      'type': 'move',
      'pieceId': moved.id,
      'x': moved.x,
      'y': moved.y,
    });
  }
  void applyRemoteMove(String pieceId, int x, int y) {
    final moved = state.pieces.firstWhere((p) => p.id == pieceId).copyWith(x: x, y: y);
    final updated = state.pieces.map((p) => p.id == pieceId ? moved : p).toList();
    state = state.copyWith(pieces: updated);
  }


}

final boardProvider = StateNotifierProvider<BoardController, BoardState>((ref) {
  return BoardController();
});
