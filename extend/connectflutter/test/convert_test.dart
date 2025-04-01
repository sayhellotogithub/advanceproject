// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description: 
// -------------------------------------------------------------------
import 'package:connectflutter/util/convert_util.dart';

void main() {
  List<int> uuids = [
    0x1800, 0x1801, 0x180A, 0x180F, 0x180D,
    0x1810, 0x1808, 0x1818, 0x1816, 0x1814,
    0x181A, 0x1819
  ];

  for (var uuid in uuids) {
    print("${uuid.toRadixString(16).toUpperCase()}: ${convert16BitUUID(uuid)}");
  }
}