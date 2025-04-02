// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:基底クラス
// -------------------------------------------------------------------
import 'package:connectflutter/model/game/message/start_game_message.dart';
import 'package:connectflutter/model/game/message/turn_message.dart';
import 'package:connectflutter/model/game/message/win_message.dart';

import 'connet_message.dart';
import 'move_message.dart';

abstract class Message {
  String get type;

  Map<String, dynamic> toJson();

  static Message fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'connect':
        return ConnectMessage.fromJson(json);
      case 'move':
        return MoveMessage.fromJson(json);
      case 'start_game':
        return StartGameMessage.fromJson(json);
      case 'turn':
        return TurnMessage.fromJson(json);
      case 'win':
        return WinMessage.fromJson(json);
      default:
        throw Exception('Unknown message type: ${json['type']}');
    }
  }
}
