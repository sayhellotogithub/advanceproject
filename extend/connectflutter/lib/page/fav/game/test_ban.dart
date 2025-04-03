// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/03
// Description:
// -------------------------------------------------------------------
// 🎯 国際将棋対応盤面（自由サイズ対応 + 駒向き + 英語ラベル）

import 'package:connectflutter/model/game/piece/queen.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/game/piece/king.dart';
import '../../../model/game/piece/piece.dart';
class ShogiBoardBase extends StatelessWidget {
  final double cellSize;
  final int boardSize;
  final List<Piece> pieces;
  final List<List<int>> highlightedCells;
  final void Function(int x, int y)? onCellTap;
  final List<String> capturedPieces;
  final bool isReversed;

  const ShogiBoardBase({
    super.key,
    required this.cellSize,
    this.boardSize = 9,
    this.pieces = const [],
    this.highlightedCells = const [],
    this.onCellTap,
    this.capturedPieces = const [],
    this.isReversed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 持ち駒表示欄（上）
        if (capturedPieces.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: capturedPieces.map((label) => Text(label, style: const TextStyle(fontSize: 20))).toList(),
            ),
          ),
        AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              // 盤面背景（自由サイズ）+ ハイライト
              Column(
                children: List.generate(boardSize, (row) {
                  final y = isReversed ? boardSize - 1 - row : row;
                  return Row(
                    children: List.generate(boardSize, (col) {
                      final x = isReversed ? boardSize - 1 - col : col;
                      final isHighlighted = highlightedCells.any((c) => c[0] == x && c[1] == y);
                      return GestureDetector(
                        onTap: () => onCellTap?.call(x, y),
                        child: Container(
                          width: cellSize,
                          height: cellSize,
                          decoration: BoxDecoration(
                            color: isHighlighted
                                ? Colors.yellow.withOpacity(0.6)
                                : (x + y) % 2 == 0
                                ? Colors.brown[100]
                                : Colors.brown[200],
                            border: Border.all(color: Colors.black54, width: 0.5),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
              // 駒を上に描画
              ...pieces.map((piece) {
                final x = isReversed ? boardSize - 1 - piece.x : piece.x;
                final y = isReversed ? boardSize - 1 - piece.y : piece.y;
                final color = piece.owner == 'p2' ? Colors.red : Colors.blue;
                final rotation = piece.owner == 'p2' ? 3.14 : 0.0;
                return Positioned(
                  left: x * cellSize,
                  top: y * cellSize,
                  child: SizedBox(
                    width: cellSize,
                    height: cellSize,
                    child: Center(
                      child: Transform.rotate(
                        angle: rotation,
                        child: Text(
                          piece.type.toUpperCase(),
                          style: TextStyle(
                            fontSize: cellSize * 0.45,
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}


class TestPage extends ConsumerStatefulWidget {
  const TestPage({super.key});

  @override
  ConsumerState<TestPage> createState() => _TestPageState();
}

class _TestPageState extends ConsumerState<TestPage> {
  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPage(
      ShogiBoardBase(
        cellSize: 40,
        boardSize: 10,
        pieces: [
          King('k1', 'p1', 4, 9),
          Queen('a2', 'p2', 5, 0),
        ],
        highlightedCells: [ [4, 8], [5, 9] ],
        capturedPieces: ["ARCHER", 'WARRIOR'],
        isReversed: false,
        onCellTap: (x, y) => print('Tapped: \$x,\$y'),
      ),
      null,
    );
  }
}

// ShogiBoardBase(
//   cellSize: 40,
//   boardSize: 10,
//   pieces: [
//     ShogiPieceData(x: 4, y: 9, label: 'KING', color: Colors.blue),
//     ShogiPieceData(x: 5, y: 0, label: 'ARCHER', color: Colors.red, rotation: 3.14),
//   ],
//   highlightedCells: [ [4, 8], [5, 9] ],
//   capturedPieces: ['ARCHER', 'WARRIOR'],
//   isReversed: false,
//   onCellTap: (x, y) => print('Tapped: \$x,\$y'),
// );
