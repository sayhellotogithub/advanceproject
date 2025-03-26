// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/26
// Description:
// -------------------------------------------------------------------

part of 'index.dart';

class GoBoardController {
  late _GoBoardControllerDelegate _delegate;

  void clear() => _delegate.onClear();

  List<List<StoneType>> boardList() => _delegate.getBoardList();
}

class _GoBoardControllerDelegate {
  late VoidCallback onClear;
  late List<List<StoneType>> Function() getBoardList;
}
