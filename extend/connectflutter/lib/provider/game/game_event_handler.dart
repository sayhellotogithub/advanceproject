// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/04
// Description:
// -------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/game/message/message.dart';
import '../../model/game/message/move_message.dart';
import '../../model/game/message/win_message.dart';
import '../../provider/game/borad_state.dart';

class GameEventHandler {
  final WidgetRef ref;

  GameEventHandler(this.ref);

  void handle(Map<String, dynamic> json) {
    final msg = Message.fromJson(json);
    final board = ref.read(boardProvider.notifier);

    if (msg is MoveMessage) {
      board.applyRemoteMove(msg.pieceId, msg.x, msg.y, msg.nextTurn);
    } else if (msg is WinMessage) {
      //  showWin(msg.winner);
      //todo
    } else {
      //todo
    }
  }
}
