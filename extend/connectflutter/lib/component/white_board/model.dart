// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

part of 'index.dart';
class _Stroke {
  final path = Path();
  final Color color;
  final double width;
  final bool erase;

  _Stroke({
    this.color = Colors.black,
    this.width = 4,
    this.erase = false,
  });
}

class RedoUndoHistory {
  final VoidCallback undo;
  final VoidCallback redo;

  RedoUndoHistory({
    required this.undo,
    required this.redo,
  });
}