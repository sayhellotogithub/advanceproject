// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: 駒の移動
// -------------------------------------------------------------------
import 'message.dart';

class MoveMessage extends Message {
  final String pieceId;
  final List<int> from;
  final List<int> to;
  final String playerId;

  MoveMessage(this.pieceId, this.from, this.to, this.playerId);

  @override
  String get type => 'move';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'pieceId': pieceId,
    'from': from,
    'to': to,
    'playerId': playerId,
  };

  factory MoveMessage.fromJson(Map<String, dynamic> json) => MoveMessage(
    json['pieceId'],
    List<int>.from(json['from']),
    List<int>.from(json['to']),
    json['playerId'],
  );
}
