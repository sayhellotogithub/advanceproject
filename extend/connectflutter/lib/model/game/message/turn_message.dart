// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: ターン通知
// -------------------------------------------------------------------
import 'message.dart';

class TurnMessage extends Message {
  final String currentPlayerId;

  TurnMessage(this.currentPlayerId);

  @override
  String get type => 'turn';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'currentPlayerId': currentPlayerId,
  };

  factory TurnMessage.fromJson(Map<String, dynamic> json) =>
      TurnMessage(json['currentPlayerId']);
}
