// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/28
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/provider/blue_tooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BluePage extends ConsumerStatefulWidget {
  @override
  _BluePageState createState() => _BluePageState();
}

class _BluePageState extends ConsumerState<BluePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bluetoothProvider.notifier).refreshConnectedDevices();
      ref.read(bluetoothProvider.notifier).refreshSystemDevices();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bluetoothState = ref.watch(bluetoothProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("scan buletooth device"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildBluetoothStateIcon(bluetoothState.adapterState),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "接続済みデバイス",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(bluetoothProvider.notifier)
                          .refreshConnectedDevices();
                    },
                    child: Text("更新"),
                  ),
                ],
              ),
            ),
            if (bluetoothState.connectedDevices.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("接続済みデバイスはありません"),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: bluetoothState.connectedDevices.length,
                itemBuilder: (context, index) {
                  final device = bluetoothState.connectedDevices[index];
                  return ListTile(
                    leading: Icon(Icons.bluetooth_connected),
                    title: Text(device.name),
                    subtitle: Text(device.id.toString()),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                    onTap: (){
                      ref
                          .read(bluetoothProvider.notifier)
                          .connectToDevice(device, context);
                    },
                  );
                },
              ),
            Divider(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "システムデバイス",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(bluetoothProvider.notifier)
                          .refreshSystemDevices();
                    },
                    child: Text("更新"),
                  ),
                ],
              ),
            ),
            if (bluetoothState.systemDevices.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("システム接続済みデバイスはありません"),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: bluetoothState.systemDevices.length,
                itemBuilder: (context, index) {
                  final device = bluetoothState.systemDevices[index];
                  return ListTile(
                    leading: Icon(Icons.bluetooth_connected),
                    title: Text(device.name),
                    subtitle: Text(device.id.toString()),
                    trailing: Icon(Icons.check_circle, color: Colors.green),
                  );
                },
              ),
            Divider(),

            // Available devices section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "利用可能なデバイス",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (bluetoothState.isScanning)
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                ],
              ),
            ),
            if (bluetoothState.devices.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("デバイスが見つかりません。スキャンを実行してください。"),
              )
            else
              ListView.builder(
                itemCount: bluetoothState.devices.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final device = bluetoothState.devices[index];
                  final isConnected = bluetoothState.connectedDevices.any(
                    (d) => d.id == device.id,
                  );

                  return ListTile(
                    leading: Icon(Icons.bluetooth),
                    title: Text(device.name),
                    subtitle: Text(device.id.toString()),
                    trailing:
                        isConnected
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.circle_outlined),
                    onTap:
                        () => ref
                            .read(bluetoothProvider.notifier)
                            .connectToDevice(device, context),
                  );
                },
              ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(bluetoothState.isScanning ? Icons.stop : Icons.search),
        onPressed: () {
          ref.read(bluetoothProvider.notifier).startScan();
        },
        tooltip: bluetoothState.isScanning ? "スキャン停止" : "スキャン開始",
      ),
    );
  }

  Widget _buildBluetoothStateIcon(BluetoothAdapterState state) {
    switch (state) {
      case BluetoothAdapterState.on:
        return Icon(Icons.bluetooth_connected, color: Colors.green);
      case BluetoothAdapterState.off:
        return Icon(Icons.bluetooth_disabled, color: Colors.red);
      case BluetoothAdapterState.turningOn:
      case BluetoothAdapterState.turningOff:
        return SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        );
      default:
        return Icon(Icons.bluetooth_disabled, color: Colors.grey);
    }
  }
}

class ChatPage extends ConsumerStatefulWidget {
  final BluetoothDevice device;

  ChatPage({required this.device});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bluetoothProvider.notifier).discoverChatService();
    });
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      ref
          .read(bluetoothProvider.notifier)
          .sendMessage(messageController.text.trim());
      setState(() {
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bluetoothState = ref.watch(bluetoothProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Bluetoothチャット: ${widget.device.name}")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bluetoothState.messages.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(bluetoothState.messages[index]));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(hintText: "入力メッセージ"),
                  ),
                ),
                IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
