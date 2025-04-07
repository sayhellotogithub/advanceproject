// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/04
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/provider/game/lan_connection_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/game/message/message.dart';

class GameMessenger {
  final LanConnectionService conn;

  GameMessenger(this.conn);

  void send(Message msg) => conn.send(msg.toJson());

  void sendToAll(Message msg) => conn.sendToAll(msg.toJson());
}

final gameMessengerProvider = Provider<GameMessenger>((ref) {
  final conn = ref.read(lanConnectionProvider);
  return GameMessenger(conn);
});
