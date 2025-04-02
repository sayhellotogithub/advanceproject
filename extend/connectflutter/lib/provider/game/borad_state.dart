// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:
// -------------------------------------------------------------------
import 'package:collection/collection.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/game/piece/archer.dart';
import '../../model/game/piece/board.dart';
import '../../model/game/piece/king.dart';
import '../../model/game/piece/piece.dart';
import '../../model/game/role.dart';
import 'lan_connection_service.dart';

class BoardState {
  final List<Piece> pieces;
  final Piece? selectedPiece;
  final List<List<int>> highlightedCells;
  final String currentTurn;

  BoardState({
    required this.pieces,
    this.selectedPiece,
    this.highlightedCells = const [],
    this.currentTurn = 'p1',
  });

  BoardState copyWith({
    List<Piece>? pieces,
    Piece? selectedPiece,
    List<List<int>>? highlightedCells,
    String? currentTurn,
  }) {
    return BoardState(
      pieces: pieces ?? this.pieces,
      selectedPiece: selectedPiece,
      highlightedCells: highlightedCells ?? this.highlightedCells,
      currentTurn: currentTurn ?? this.currentTurn,
    );
  }
}

class BoardController extends StateNotifier<BoardState> {
  static const int boardSize = 9;

  String myRole = "p1";

  BoardController()
    : super(
        BoardState(
          pieces: [
            King('k1', getMyPlayerIdFromRole(Role.player1), 4, 8),
            King('k2', getMyPlayerIdFromRole(Role.player2), 4, 0),
            Archer('a1', getMyPlayerIdFromRole(Role.player1), 2, 8),
            Archer('a2', getMyPlayerIdFromRole(Role.player2), 6, 0),
          ],
        ),
      );

  bool isMyTurn() {
    return state.currentTurn == myRole;
  }

  void setRole(String role) {
    this.myRole = role;
  }

  bool canMove(Piece piece) {
    AppLogger().debug(
      "state.currentTurn${state.currentTurn}-myPlayerId:$myRole",
    );
    if (!isMyTurn()) return false;
    return piece.owner == myRole;
  }

  Piece? oldPiece;
  String? preTurn;

  void sendOldDataAgain(WidgetRef ref) {
    if (oldPiece != null) {
      // 👇 通信で送る
      ref.read(lanConnectionProvider).send({
        'type': 'move',
        'pieceId': oldPiece!.id,
        'x': oldPiece!.x,
        'y': oldPiece!.y,
        'nextTurn': preTurn,
      });
    }
  }

  void saveOldData(Piece? oldPiece, String? preTurn) {
    this.oldPiece = oldPiece;
    this.preTurn = preTurn;
  }

  void onCellTap(int x, int y, WidgetRef ref) {
    final tapped = state.pieces.firstWhereOrNull((p) => p.x == x && p.y == y);

    if (tapped != null && canMove(tapped)) {
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
      final nextTurn = myRole == 'p1' ? 'p2' : 'p1';
      saveOldData(moved, nextTurn);
      // 👇 通信で送る
      ref.read(lanConnectionProvider).send({
        'type': 'move',
        'pieceId': moved.id,
        'x': moved.x,
        'y': moved.y,
        'nextTurn': nextTurn,
      });

      state = state.copyWith(
        pieces: updated,
        selectedPiece: null,
        highlightedCells: [],
        currentTurn: nextTurn,
      );
    } else {
      // それ以外 → 選択解除
      state = state.copyWith(selectedPiece: null, highlightedCells: []);
    }
  }

  void applyRemoteMove(String pieceId, int x, int y, String nextTurn) {
    try {
      // 指定されたIDの駒を見つける
      final moved = state.pieces.firstWhereOrNull((p) => p.id == pieceId);

      if (moved == null) {
        print("駒が見つからないため、移動を中止します");
        return;
      }

      // 移動後の駒を作成
      final movedPiece = moved.copyWith(x: x, y: y);

      // 移動先に既に駒がある場合は削除する（駒を取る）
      final updated =
          state.pieces
              .map((p) {
                if (p.id == movedPiece.id) return movedPiece;
                if (p.x == x && p.y == y && p.owner != movedPiece.owner) {
                  print("駒 ${p.id} が取られました");
                  return null; // 相手の駒を取る
                }
                return p;
              })
              .whereType<Piece>() // nullを除外
              .toList();

      // 状態を更新
      state = state.copyWith(
        pieces: updated,
        selectedPiece: null,
        highlightedCells: [],
        currentTurn: nextTurn,
      );
    } catch (e) {
      print("ERROR in applyRemoteMove: $e");
    }
  }
}

final boardProvider = StateNotifierProvider<BoardController, BoardState>((ref) {
  return BoardController();
});
