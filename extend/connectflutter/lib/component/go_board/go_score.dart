// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/26
// Description:
// ```
//
// この得点計算実装の特徴：
//
// 1. 複雑な領域判定アルゴリズム
// - フラッドフィル法による領域検出
// - 石と領地の分離判定
//
// 2. スコアリング方法
// - 石の数
// - 占有領域
// - こみ（白石に与えられる補正点）

part of 'index.dart';

// 得点計算クラス
class ScoringResult {
  double blackTerritory = 0;
  double whiteTerritory = 0;
  double blackStones = 0;
  double whiteStones = 0;
  double blackScore = 0;
  double whiteScore = 0;
  double komi = 6.5; // 白石にデフォルトで与えられる得点

  String get winner {
    return blackScore > whiteScore ? '黒' : '白';
  }
}

class GoScoring {
  static const int BOARD_SIZE = 19;
  final result = ScoringResult();

  // メイン得点計算メソッド
  ScoringResult calculateScore(List<List<StoneType>> board) {
    final territory = _identifyTerritory(board);

    // 石と領域のカウント
    for (int y = 0; y < BOARD_SIZE; y++) {
      for (int x = 0; x < BOARD_SIZE; x++) {
        switch (board[y][x]) {
          case StoneType.black:
            result.blackStones++;
            break;
          case StoneType.white:
            result.whiteStones++;
            break;
          case StoneType.empty:
            break;
        }

        switch (territory[y][x]) {
          case StoneType.black:
            result.blackTerritory++;
            break;
          case StoneType.white:
            result.whiteTerritory++;
            break;
          default:
            break;
        }
      }
    }

    // 最終スコア計算
    result.blackScore = result.blackStones + result.blackTerritory;
    result.whiteScore =
        result.whiteStones + result.whiteTerritory + result.komi;

    return result;
  }

  // 領域判定アルゴリズム
  List<List<StoneType>> _identifyTerritory(List<List<StoneType>> board) {
    final territory = List.generate(
      BOARD_SIZE,
      (_) => List.filled(BOARD_SIZE, StoneType.empty),
    );

    for (int y = 0; y < BOARD_SIZE; y++) {
      for (int x = 0; x < BOARD_SIZE; x++) {
        if (board[y][x] == StoneType.empty) {
          territory[y][x] = _determinePointOwnership(board, x, y);
        } else {
          territory[y][x] =
              board[y][x] == 'black' ? StoneType.black : StoneType.white;
        }
      }
    }

    return territory;
  }

  // 特定の空点の所有権を判定
  StoneType _determinePointOwnership(
    List<List<StoneType>> board,
    int x,
    int y,
  ) {
    final visited = List.generate(
      BOARD_SIZE,
      (_) => List.filled(BOARD_SIZE, false),
    );
    final connectedPoints = <Point<int>>[];

    void floodFill(int cx, int cy) {
      if (cx < 0 ||
          cx >= BOARD_SIZE ||
          cy < 0 ||
          cy >= BOARD_SIZE ||
          visited[cy][cx] ||
          board[cy][cx] != StoneType.empty)
        return;

      visited[cy][cx] = true;
      connectedPoints.add(Point(cx, cy));

      // 4方向に再帰
      floodFill(cx + 1, cy);
      floodFill(cx - 1, cy);
      floodFill(cx, cy + 1);
      floodFill(cx, cy - 1);
    }

    floodFill(x, y);

    // 周囲の石をチェック
    final surroundingColors = <StoneType>{};
    for (var point in connectedPoints) {
      final directions = [Point(0, 1), Point(0, -1), Point(1, 0), Point(-1, 0)];

      for (var dir in directions) {
        final nx = point.x + dir.x;
        final ny = point.y + dir.y;

        if (nx >= 0 &&
            nx < BOARD_SIZE &&
            ny >= 0 &&
            ny < BOARD_SIZE &&
            board[ny][nx] != StoneType.empty) {
          surroundingColors.add(board[ny][nx]);
        }
      }
    }

    // 領域の所有権判定
    if (surroundingColors.length == 1) {
      return surroundingColors.first == 'black'
          ? StoneType.black
          : StoneType.white;
    }

    return StoneType.empty;
  }
}
