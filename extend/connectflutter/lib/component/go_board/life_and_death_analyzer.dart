// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/28
// Description:
// この実装の主な特徴：
//
// 1. 死活問題の複雑な判定
// - 呼吸点の計算
// - グループの状態判定
// - セキ（相互に取れない状態）の検出
//
// 2. 石のステータス
// - 生きている
// - 死んでいる
// - セキ
// - 判定不能
//
// 3. アルゴリズムの主要な要素
// - 深さ優先探索（DFS）によるグループ検出
// - 呼吸点の計算
// - 隣接グループの相互作用分析
//
// 主な死活問題の判定ロジック：
// - 呼吸点がある → 生きている
// - 呼吸点がない → 死んでいる
// - 特殊な境界条件 → セキ
//
// 注意点と限界：
// - 囲碁の死活問題は非常に複雑
// - この実装は完全ではなく、簡略化されたアルゴリズム
// - 実際のトーナメントでは人間の判定が必要な場合がある
//
// 改善の余地：
// - より高度な境界条件の検出
// - 人工知能による学習モデルの統合
// - より複雑なセキ判定アルゴリズム
//
// 拡張可能性：
// - 機械学習モデルとの統合
// - 複雑な死活問題のパターン認識
// - リアルタイム分析機能
// -------------------------------------------------------------------
part of 'index.dart';

enum StoneStatus {
  alive, //生きている石
  dead, //死んでいる石
  seki, //せき　相互に取れない状態
  unsure, //判定不能
}

// グループの情報を保持するクラス
class StoneGroup {
  final List<Point<int>> stones;
  final String color;
  StoneStatus status;
  int liberties;

  StoneGroup({
    required this.stones,
    required this.color,
    this.status = StoneStatus.unsure,
    this.liberties = 0,
  });
}

class LifeAndDeathAnalyzer {
  static const int BOARD_SIZE = 19;

  // メイン死活判定メソッド
  Map<Point<int>, StoneStatus> analyzeLifeAndDeath(
    List<List<StoneType>> board,
  ) {
    final groups = _findGroups(board);
    final lifeAndDeathMap = <Point<int>, StoneStatus>{};

    for (var group in groups) {
      _determineGroupStatus(board, group, groups);

      // 各石のステータスをマップに追加
      for (var stone in group.stones) {
        lifeAndDeathMap[stone] = group.status;
      }
    }

    return lifeAndDeathMap;
  }

  // グループ検出アルゴリズム
  List<StoneGroup> _findGroups(List<List<StoneType>> board) {
    final groups = <StoneGroup>[];
    final visited = List.generate(
      BOARD_SIZE,
      (_) => List.filled(BOARD_SIZE, false),
    );

    for (int y = 0; y < BOARD_SIZE; y++) {
      for (int x = 0; x < BOARD_SIZE; x++) {
        if (board[y][x]== StoneType.empty && !visited[y][x]) {
          final group = _findConnectedGroup(board, x, y, visited);
          groups.add(group);
        }
      }
    }

    return groups;
  }

  // 連結した石のグループを見つける
  StoneGroup _findConnectedGroup(
    List<List<StoneType>> board,
    int startX,
    int startY,
    List<List<bool>> visited,
  ) {
    final stones = <Point<int>>[];
    final color = board[startY][startX].name;
    int liberties = 0;

    void dfs(int x, int y) {
      if (x < 0 ||
          x >= BOARD_SIZE ||
          y < 0 ||
          y >= BOARD_SIZE ||
          visited[y][x] ||
          board[y][x].name != color)
        return;

      visited[y][x] = true;
      stones.add(Point(x, y));

      // 呼吸点をカウント
      final directions = [Point(0, 1), Point(0, -1), Point(1, 0), Point(-1, 0)];

      for (var dir in directions) {
        final nx = x + dir.x;
        final ny = y + dir.y;

        if (nx >= 0 && nx < BOARD_SIZE && ny >= 0 && ny < BOARD_SIZE) {
          if (board[ny][nx] == StoneType.empty) {
            liberties++;
          } else if (board[ny][nx].name != color) {
            // 隣接する異なる色の石
            continue;
          }
        }
      }

      // 再帰的に隣接する石を探索
      dfs(x + 1, y);
      dfs(x - 1, y);
      dfs(x, y + 1);
      dfs(x, y - 1);
    }

    dfs(startX, startY);

    return StoneGroup(stones: stones, color: color, liberties: liberties);
  }

  // グループのステータスを判定
  void _determineGroupStatus(
    List<List<StoneType>> board,
    StoneGroup group,
    List<StoneGroup> allGroups,
  ) {
    // 呼吸点がある場合は生きている
    if (group.liberties > 0) {
      group.status = StoneStatus.alive;
      return;
    }

    // セキ（相互に取れない）の判定
    if (_isSeki(board, group, allGroups)) {
      group.status = StoneStatus.seki;
      return;
    }

    // 呼吸点がない場合は死んでいる
    group.status = StoneStatus.dead;
  }

  // セキ（相互に取れない状態）の判定
  bool _isSeki(
    List<List<StoneType>> board,
    StoneGroup group,
    List<StoneGroup> allGroups,
  ) {
    // セキの複雑な判定ロジック
    // これは非常に単純化された実装
    for (var otherGroup in allGroups) {
      if (otherGroup.color != group.color) {
        // 異なる色のグループとの接触を確認
        bool touchesBorder = _groupsTouchBorder(group, otherGroup);
        if (touchesBorder) {
          return true;
        }
      }
    }
    return false;
  }

  // 2つのグループが境界線で接しているかを判定
  bool _groupsTouchBorder(StoneGroup group1, StoneGroup group2) {
    for (var stone1 in group1.stones) {
      for (var stone2 in group2.stones) {
        // 隣接している可能性のある石をチェック
        if ((stone1.x - stone2.x).abs() + (stone1.y - stone2.y).abs() == 1) {
          return true;
        }
      }
    }
    return false;
  }
}
