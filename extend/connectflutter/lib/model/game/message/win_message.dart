// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: 
// -------------------------------------------------------------------
import 'message.dart';

class WinMessage extends Message {
  final String winner;

  WinMessage(this.winner);

  @override
  String get type => 'win';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'winner': winner,
  };

  factory WinMessage.fromJson(Map<String, dynamic> json) =>
      WinMessage(json['winner']);
}
