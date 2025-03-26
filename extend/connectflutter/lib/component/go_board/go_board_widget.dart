// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/26
// Description:
// -------------------------------------------------------------------
part of 'index.dart';

enum StoneType { black, white, empty }

enum GameState { playing, blackWin, whiteWin, draw }

class GoBoardWidget extends StatefulWidget {
  ValueChanged<bool>? isBlack;
  final GoBoardController? controller;

  GoBoardWidget({Key? key, this.controller, this.isBlack}) : super(key: key);

  @override
  _GoBoardWidgetState createState() => _GoBoardWidgetState();
}

class _GoBoardWidgetState extends State<GoBoardWidget> {
  static const int BOARD_SIZE = 19;
  List<List<StoneType>> board = List.generate(
    BOARD_SIZE,
    (_) => List.filled(BOARD_SIZE, StoneType.empty),
  );

  StoneType currentPlayer = StoneType.black;
  GameState gameState = GameState.playing;

  // 囲碁の本格的なルール実装
  List<List<Point<int>>> capturedGroups = [];

  void placeStone(int x, int y) {
    if (board[y][x] != StoneType.empty || gameState != GameState.playing)
      return;

    setState(() {
      board[y][x] = currentPlayer;

      // 石を取る処理
      checkAndCaptureSurroundedGroups(x, y);

      // プレイヤー交代
      setCurrentPlayer(
        currentPlayer == StoneType.black ? StoneType.white : StoneType.black,
      );
    });
  }

  void checkAndCaptureSurroundedGroups(int x, int y) {
    // 周囲のグループをチェックし、呼吸点がなければ取る
    final opponents =
        currentPlayer == StoneType.black ? StoneType.white : StoneType.black;

    // 上下左右の隣接セル
    final directions = [Point(0, 1), Point(0, -1), Point(1, 0), Point(-1, 0)];

    for (var dir in directions) {
      final nx = x + dir.x;
      final ny = y + dir.y;

      if (nx >= 0 && nx < BOARD_SIZE && ny >= 0 && ny < BOARD_SIZE) {
        if (board[ny][nx] == opponents) {
          final group = findGroup(nx, ny);
          if (hasNoLiberties(group)) {
            removeGroup(group);
          }
        }
      }
    }
  }

  List<Point<int>> findGroup(int x, int y) {
    final group = <Point<int>>[];
    final visited = List.generate(
      BOARD_SIZE,
      (_) => List.filled(BOARD_SIZE, false),
    );
    final targetColor = board[y][x];

    void dfs(int cx, int cy) {
      if (cx < 0 ||
          cx >= BOARD_SIZE ||
          cy < 0 ||
          cy >= BOARD_SIZE ||
          visited[cy][cx] ||
          board[cy][cx] != targetColor)
        return;

      visited[cy][cx] = true;
      group.add(Point(cx, cy));

      // 再帰的に隣接セルをチェック
      dfs(cx + 1, cy);
      dfs(cx - 1, cy);
      dfs(cx, cy + 1);
      dfs(cx, cy - 1);
    }

    dfs(x, y);
    return group;
  }

  bool hasNoLiberties(List<Point<int>> group) {
    for (var stone in group) {
      final directions = [Point(0, 1), Point(0, -1), Point(1, 0), Point(-1, 0)];

      for (var dir in directions) {
        final nx = stone.x + dir.x;
        final ny = stone.y + dir.y;

        if (nx >= 0 &&
            nx < BOARD_SIZE &&
            ny >= 0 &&
            ny < BOARD_SIZE &&
            board[ny][nx] == StoneType.empty) {
          return false;
        }
      }
    }
    return true;
  }

  void removeGroup(List<Point<int>> group) {
    for (var stone in group) {
      board[stone.y][stone.x] = StoneType.empty;
    }
  }

  void refresh() {
    setState(() {
      // ゲームリセット
      board = List.generate(
        BOARD_SIZE,
        (_) => List.filled(BOARD_SIZE, StoneType.empty),
      );
      setCurrentPlayer(StoneType.black);
      gameState = GameState.playing;
    });
  }

  void setCurrentPlayer(StoneType stoneType) {
    currentPlayer = stoneType;
    if (widget.isBlack != null) {
      widget.isBlack!(currentPlayer == StoneType.black);
    }
  }

  @override
  void initState() {
    widget.controller?._delegate =
        _GoBoardControllerDelegate()
          ..onClear = () {
            refresh();
          }
          ..getBoardList = () {
            return board;
          };

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: CustomPaint(
        painter: GoBoardPainter(board: board, boardSize: BOARD_SIZE),
        child: GestureDetector(
          onTapDown: (details) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final localPosition = box.globalToLocal(details.globalPosition);
            final cellSize = box.size.width / BOARD_SIZE;

            final x = (localPosition.dx / cellSize).floor();
            final y = (localPosition.dy / cellSize).floor();

            if (x >= 0 && x < BOARD_SIZE && y >= 0 && y < BOARD_SIZE) {
              placeStone(x, y);
            }
          },
        ),
      ),
    );
  }
}

class GoBoardPainter extends CustomPainter {
  final List<List<StoneType>> board;
  final int boardSize;
  final _paint = Paint()..color = Colors.black;
  final woodColor = Color(0xFFC19A6B);

  // スターポイント
  final starPoints = [
    Point(3, 3),
    Point(3, 9),
    Point(3, 15),
    Point(9, 3),
    Point(9, 9),
    Point(9, 15),
    Point(15, 3),
    Point(15, 9),
    Point(15, 15),
  ];

  GoBoardPainter({required this.board, required this.boardSize});

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / boardSize;

    // 碁盤の背景
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = woodColor,
    );

    // 碁盤の線を引く
    for (int i = 0; i < boardSize; i++) {
      canvas.drawLine(
        Offset(i * cellSize, 0),
        Offset(i * cellSize, size.height),
        _paint,
      );
      canvas.drawLine(
        Offset(0, i * cellSize),
        Offset(size.width, i * cellSize),
        _paint,
      );
    }

    for (var point in starPoints) {
      canvas.drawCircle(
        Offset(point.x * cellSize, point.y * cellSize),
        3,
        _paint,
      );
    }

    // 石の描画
    for (int y = 0; y < boardSize; y++) {
      for (int x = 0; x < boardSize; x++) {
        if (board[y][x] != StoneType.empty) {
          final stonePaint =
              board[y][x] == StoneType.black
                  ? (Paint()..color = Colors.black)
                  : (Paint()..color = Colors.white);

          final stoneOutline =
              Paint()
                ..color = Colors.black
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1;

          canvas.drawCircle(
            Offset(x * cellSize, y * cellSize),
            cellSize / 2 - 2,
            stonePaint,
          );

          // 白石の場合は輪郭線を追加
          if (board[y][x] == StoneType.white) {
            canvas.drawCircle(
              Offset(x * cellSize, y * cellSize),
              cellSize / 2 - 2,
              stoneOutline,
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
