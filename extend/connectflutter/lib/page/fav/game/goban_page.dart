// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/26
// Description:
// この高度な囲碁実装には、以下の機能が含まれています：
//
// 1. 高度な石の配置ロジック
// 2. グループ検出アルゴリズム
// 3. 呼吸点（リバティ）の概念
// 4. 石を取る（キャプチャー）処理
// 5. プレイヤー交代
// 6. ゲームリセット機能
// 7. 洗練されたUI
// 8. カスタム描画による美しい碁盤表現

// -------------------------------------------------------------------

import 'package:connectflutter/component/go_board/index.dart';
import 'package:flutter/material.dart';

class GoBanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoBanPageState();
  }
}

class _GoBanPageState extends State<GoBanPage> {
  final GoBoardController _boardController = GoBoardController();
  bool _isBlack = false;
  final scoring = GoScoring();

  @override
  void initState() {
    super.initState();
  }

  void _analyzeLifeAndDeath() {
    final analyzer = LifeAndDeathAnalyzer();
    final result = analyzer.analyzeLifeAndDeath(_boardController.boardList());

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('死活問題分析'),
            content: ListView(
              children:
                  result.entries.map((entry) {
                    final statusText =
                        {
                          StoneStatus.alive: '生',
                          StoneStatus.dead: '死',
                          StoneStatus.seki: 'セキ',
                          StoneStatus.unsure: '不明',
                        }[entry.value];

                    return Text(
                      '座標: (${entry.key.x}, ${entry.key.y}) - ステータス: $statusText',
                    );
                  }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('閉じる'),
              ),
            ],
          ),
    );
  }

  void _calculateAndShowScore() {
    final result = scoring.calculateScore(_boardController.boardList());

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('ゲーム結果'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('黒の石: ${result.blackStones}'),
                Text('白の石: ${result.whiteStones}'),
                Text('黒の領地: ${result.blackTerritory}'),
                Text('白の領地: ${result.whiteTerritory}'),
                Text('黒のスコア: ${result.blackScore.toStringAsFixed(1)}'),
                Text('白のスコア: ${result.whiteScore.toStringAsFixed(1)}'),
                Text('勝者: ${result.winner}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('閉じる'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('囲碁'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _boardController.clear();
            },
          ),
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: _calculateAndShowScore,
          ),
          IconButton(
            icon: Icon(Icons.visibility),
            onPressed: _analyzeLifeAndDeath,
          ),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GoBoardWidget(
                controller: _boardController,
                isBlack: (value) {
                  setState(() {
                    _isBlack = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '現在のプレイヤー: ${_isBlack ? '黒' : '白'}',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
