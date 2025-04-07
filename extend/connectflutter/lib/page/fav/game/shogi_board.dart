import 'package:collection/collection.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/game/piece/piece.dart';
import '../../../provider/game/board_util.dart';
import '../../../provider/game/borad_state.dart';
import '../../../provider/game/game_messenger.dart';

class ShogiBoard extends ConsumerStatefulWidget {
  final String myPlayerId; // 'p1', 'p2', or 'spectator'
  const ShogiBoard({super.key, required this.myPlayerId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ShogiBoardState();
  }
}

class _ShogiBoardState extends ConsumerState<ShogiBoard> {
  static const int boardSize = BoardController.boardSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boardState = ref.watch(boardProvider);
    final controller = ref.read(boardProvider.notifier);
    final messenger = ref.read(gameMessengerProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    controller.setRole(widget.myPlayerId);

    final cellSize = (screenWidth - 0.5 * 20) / boardSize;

    // チェックメイト or 勝敗チェック
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final message = getGameOverMessage(boardState.pieces);
      if (message != null && context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (_) => AlertDialog(
                title: const Text("ゲーム終了"),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("閉じる"),
                  ),
                ],
              ),
        );
        return;
      }
    });

    // デバッグ出力 - build メソッドが呼び出されたことを確認
    AppLogger().debug(
      'ShogiBoard build: ${DateTime.now()}, pieces: ${boardState.pieces.length}',
    );

    return Scaffold(
      appBar: AppBar(title: Text('国際将棋（あなた: ${widget.myPlayerId}')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            "現在のターン: ${boardState.currentTurn}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:
                  boardState.currentTurn == widget.myPlayerId
                      ? Colors.green
                      : Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              controller.sendOldDataAgain(ref);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "もう一回やる",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // デバッグボタン - 状態更新をテスト
          ElevatedButton(
            onPressed: () {
              // テスト用の移動を適用
              if (widget.myPlayerId == 'p1') {
                print('手動でp2の王を動かします');
                controller.applyRemoteMove('k2', 4, 1, 'p1');
              } else {
                print('手動でp1の王を動かします');
                controller.applyRemoteMove('k1', 4, 7, 'p2');
              }
              // 状態が変わったことを確認
              print('手動移動後の駒: ${boardState.pieces.length}');
            },
            child: Text('テスト移動'),
          ),

          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(boardSize, (y) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(boardSize, (x) {
                      final piece = boardState.pieces.firstWhereOrNull(
                        (p) => p.x == x && p.y == y,
                      );

                      final isHighlighted = boardState.highlightedCells.any(
                        (c) => c[0] == x && c[1] == y,
                      );
                      final isSelected =
                          boardState.selectedPiece != null &&
                          boardState.selectedPiece!.x == x &&
                          boardState.selectedPiece!.y == y;

                      return GestureDetector(
                        onTap: () => controller.onCellTap(x, y, ref),
                        child: Container(
                          width: cellSize,
                          height: cellSize,
                          margin: const EdgeInsets.all(0.1),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? Colors.blue[300]
                                    : isHighlighted
                                    ? Colors.yellow[300]
                                    : ((x + y) % 2 == 0
                                        ? Colors.brown[100]
                                        : Colors.brown[200]),
                            border: Border.all(color: Colors.black, width: 0.1),
                          ),
                          child: Stack(
                            children: [
                              Center(child: buildPiece(piece)),
                              // セルの座標をデバッグ表示
                              Positioned(
                                right: 2,
                                bottom: 2,
                                child: Text(
                                  "$x,$y",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPiece(Piece? piece) {
    if (piece == null) {
      return const SizedBox.shrink(); // 常に Widget を返す
    }
    String pieceSymbol = getUnicodeSymbol(piece);

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: piece.owner == 'p1' ? Colors.blue[50] : Colors.red[50],
        shape: BoxShape.circle,
        border: Border.all(
          color: piece.owner == 'p1' ? Colors.blue : Colors.red,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          pieceSymbol,
          style: TextStyle(
            fontSize: FontSizeUtil.size24,
            color: piece.owner == 'p1' ? Colors.blue[800] : Colors.red[800],
          ),
        ),
      ),
    );
  }
}
