// // -------------------------------------------------------------------
// // Author: WANG JUN
// // Date: 2025/03/26
// // Description:
// // -------------------------------------------------------------------
// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//
// class GoBoardBluetoothApp extends StatefulWidget {
//   @override
//   _GoBoardBluetoothAppState createState() => _GoBoardBluetoothAppState();
// }
//
// class _GoBoardBluetoothAppState extends State<GoBoardBluetoothApp> {
//   // Bluetooth state management
//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
//   FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
//   BluetoothConnection? _connection;
//
//   // Go board state
//   List<List<StoneType>> _boardState = List.generate(
//       19,
//           (_) => List.generate(19, (_) => StoneType.empty)
//   );
//   StoneType _currentPlayer = StoneType.black;
//
//   // Enum for stone types
//   enum StoneType {
//   black,
//   white,
//   empty
//   }
//
//   @override
//   void initState() {
//   super.initState();
//
//   // Initialize Bluetooth state
//   _bluetooth.state.then((state) {
//   setState(() {
//   _bluetoothState = state;
//   });
//   });
//   }
//
//   // Scan for Bluetooth devices
//   Future<void> _startDeviceDiscovery() async {
//   List<BluetoothDevice> devices = await _bluetooth.getBondedDevices();
//
//   showDialog(
//   context: context,
//   builder: (BuildContext context) {
//   return AlertDialog(
//   title: Text('Select Bluetooth Device'),
//   content: SingleChildScrollView(
//   child: ListBody(
//   children: devices.map((device) => ListTile(
//   title: Text(device.name ?? 'Unknown Device'),
//   subtitle: Text(device.address),
//   onTap: () {
//   Navigator.of(context).pop();
//   _connectToDevice(device);
//   },
//   )).toList(),
//   ),
//   ),
//   );
//   },
//   );
//   }
//
//   // Connect to a specific Bluetooth device
//   Future<void> _connectToDevice(BluetoothDevice device) async {
//   try {
//   BluetoothConnection connection = await BluetoothConnection.toAddress(device.address);
//   setState(() {
//   _connection = connection;
//   });
//
//   // Listen for incoming data
//   connection.input?.listen(_onDataReceived).onDone(() {
//   // Handle disconnection
//   _disconnectDevice();
//   });
//
//   ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(content: Text('Connected to ${device.name}'))
//   );
//   } catch (e) {
//   ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(content: Text('Connection failed: $e'))
//   );
//   }
//   }
//
//   // Place a stone on the board
//   void _placeStone(int x, int y) {
//   if (_boardState[y][x] == StoneType.empty) {
//   setState(() {
//   _boardState[y][x] = _currentPlayer;
//   _currentPlayer = _currentPlayer == StoneType.black
//   ? StoneType.white
//       : StoneType.black;
//   });
//
//   // Send board state via Bluetooth
//   _sendBoardState(x, y);
//   }
//   }
//
//   // Serialize and send board state
//   void _sendBoardState(int x, int y) {
//   if (_connection != null && _connection!.isConnected) {
//   // Create a simple serialization format
//   // Format: x,y,stoneType
//   String message = '$x,$y,${_boardState[y][x].index}';
//   _connection!.output.add(Uint8List.fromList(message.codeUnits));
//   _connection!.output.allSent.then((_) {
//   print('Board state sent');
//   });
//   }
//   }
//
//   // Process received board state
//   void _onDataReceived(Uint8List data) {
//   String message = String.fromCharCodes(data);
//   List<String> parts = message.split(',');
//
//   if (parts.length == 3) {
//   int x = int.parse(parts[0]);
//   int y = int.parse(parts[1]);
//   StoneType stoneType = StoneType.values[int.parse(parts[2])];
//
//   setState(() {
//   _boardState[y][x] = stoneType;
//   _currentPlayer = stoneType == StoneType.black
//   ? StoneType.white
//       : StoneType.black;
//   });
//   }
//   }
//
//   // Disconnect from the device
//   void _disconnectDevice() {
//   if (_connection != null) {
//   _connection!.dispose();
//   setState(() {
//   _connection = null;
//   });
//   }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//   return Scaffold(
//   appBar: AppBar(
//   title: Text('Bluetooth Go Board'),
//   actions: [
//   IconButton(
//   icon: Icon(Icons.bluetooth),
//   onPressed: _startDeviceDiscovery,
//   ),
//   if (_connection != null)
//   IconButton(
//   icon: Icon(Icons.close),
//   onPressed: _disconnectDevice,
//   )
//   ],
//   ),
//   body: Column(
//   children: [
//   // Current player indicator
//   Padding(
//   padding: const EdgeInsets.all(8.0),
//   child: Text(
//   '現在のプレイヤー: ${_currentPlayer == StoneType.black ? '黒' : '白'}',
//   style: TextStyle(fontSize: 18),
//   ),
//   ),
//
//   // Go board
//   Expanded(
//   child: GridView.builder(
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//   crossAxisCount: 19,
//   ),
//   itemBuilder: (context, index) {
//   int x = index % 19;
//   int y = index ~/ 19;
//
//   return GestureDetector(
//   onTap: () => _placeStone(x, y),
//   child: Container(
//   decoration: BoxDecoration(
//   border: Border.all(color: Colors.black12),
//   ),
//   child: _buildStone(_boardState[y][x]),
//   ),
//   );
//   },
//   itemCount: 19 * 19,
//   ),
//   ),
//   ],
//   ),
//   );
//   }
//
//   // Render stone based on its type
//   Widget _buildStone(StoneType stoneType) {
//   switch (stoneType) {
//   case StoneType.black:
//   return Container(
//   margin: EdgeInsets.all(4),
//   decoration: BoxDecoration(
//   color: Colors.black,
//   shape: BoxShape.circle,
//   ),
//   );
//   case StoneType.white:
//   return Container(
//   margin: EdgeInsets.all(4),
//   decoration: BoxDecoration(
//   color: Colors.white,
//   shape: BoxShape.circle,
//   border: Border.all(color: Colors.black),
//   ),
//   );
//   case StoneType.empty:
//   return SizedBox.shrink();
//   }
//   }
//
//   @override
//   void dispose() {
//   _disconnectDevice();
//   super.dispose();
//   }
// }