// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:接続メッセージ
// -------------------------------------------------------------------
import 'message.dart';

class ConnectMessage extends Message {
  final String role; // 'p1' / 'p2' / 'spectator'

  ConnectMessage(this.role);

  @override
  String get type => 'connect';

  @override
  Map<String, dynamic> toJson() => {'type': type, 'role': role};

  static ConnectMessage fromJson(Map<String, dynamic> json) =>
      ConnectMessage(json['role']);
}
