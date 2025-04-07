// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/04
// Description: 
// -------------------------------------------------------------------
import 'message.dart';

class ResetMessage extends Message {
  @override
  String get type => 'reset';

  @override
  Map<String, dynamic> toJson() => {'type': type};

  static ResetMessage fromJson(Map<String, dynamic> json) => ResetMessage();
}