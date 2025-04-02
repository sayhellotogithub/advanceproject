// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: ゲーム開始
// -------------------------------------------------------------------
import 'message.dart';

class StartGameMessage extends Message {
  final List<String> players;

  StartGameMessage(this.players);

  @override
  String get type => 'start_game';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'players': players,
  };

  factory StartGameMessage.fromJson(Map<String, dynamic> json) =>
      StartGameMessage(List<String>.from(json['players']));
}