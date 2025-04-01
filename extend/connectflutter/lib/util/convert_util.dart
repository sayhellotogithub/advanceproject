// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:
// -------------------------------------------------------------------
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Guid convert16BitUUID(int uuid16) {
  return Guid(
    "0000${uuid16.toRadixString(16).padLeft(4, '0')}-0000-1000-8000-00805F9B34FB",
  );
}
