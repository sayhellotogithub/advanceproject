import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/game/piece/piece.dart';
import '../../../provider/game/borad_state.dart';

class ShogiBoard extends ConsumerWidget {
  const ShogiBoard({super.key});

  static const int boardSize = 9;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardState = ref.watch(boardProvider);
    final controller = ref.read(boardProvider.notifier);

    final screenWidth = MediaQuery.of(context).size.width;

    final cellSize = (screenWidth - 0.5 * 20) / boardSize;

    return Scaffold(
      appBar: AppBar(title: const Text('国際将棋')),
      body: Center(
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

                return GestureDetector(
                  onTap: () => controller.onCellTap(x, y, ref),
                  child: Container(
                    width: cellSize,
                    height: cellSize,
                    margin: const EdgeInsets.all(0.1),
                    decoration: BoxDecoration(
                      color:
                          isHighlighted
                              ? Colors.yellow[300]
                              : ((x + y) % 2 == 0
                                  ? Colors.brown[100]
                                  : Colors.brown[200]),
                      border: Border.all(color: Colors.black, width: 0.1),
                    ),
                    child: Center(child: buildPiece(piece)),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }

  Widget? buildPiece(Piece? piece) {
    if (piece == null) {
      return null;
    }
    return Text(
      piece.type.toUpperCase(),
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: piece.owner == 'p1' ? Colors.blue : Colors.red,
      ),
    );
  }
}
