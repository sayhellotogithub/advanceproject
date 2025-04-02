// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: 
// -------------------------------------------------------------------
import 'board.dart';

abstract class Piece {
  final String id;
  final String owner;
  int x, y;

  Piece(this.id, this.owner, this.x, this.y);

  String get type;
  List<List<int>> getAvailableMoves(Board board);
  Piece copyWith({int? x, int? y});
}