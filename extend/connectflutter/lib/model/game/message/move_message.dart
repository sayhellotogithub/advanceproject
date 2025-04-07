// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: 駒の移動
// -------------------------------------------------------------------
import 'message.dart';

class MoveMessage extends Message {
  final String pieceId;
  final int x, y;
  final String nextTurn;

  MoveMessage({
    required this.pieceId,
    required this.x,
    required this.y,
    required this.nextTurn,
  });

  @override
  String get type => 'move';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'pieceId': pieceId,
    'x': x,
    'y': y,
    'nextTurn': nextTurn,
  };

  static MoveMessage fromJson(Map<String, dynamic> json) {
    return MoveMessage(
      pieceId: json['pieceId'],
      x: json['x'],
      y: json['y'],
      nextTurn: json['nextTurn'],
    );
  }
}
