// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:接続メッセージ
// -------------------------------------------------------------------
import 'message.dart';

class ConnectMessage extends Message {
  final String playedId;

  ConnectMessage(this.playedId);

  @override
  String get type => 'connect';

  @override
  Map<String, dynamic> toJson() => {'type': type, 'playerId': playedId};

  factory ConnectMessage.fromJson(Map<String, dynamic> json) =>
      ConnectMessage(json['playerId']);
}
