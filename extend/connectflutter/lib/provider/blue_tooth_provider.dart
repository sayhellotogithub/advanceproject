// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/31
// Description:
// -------------------------------------------------------------------
import 'dart:async';
import 'dart:io';

import 'package:connectflutter/page/fav/game/blue_page.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// 1.Bluetooth アダプターの状態をリアルタイムで監視して、
/// チャットを実現
/// Generic Access (汎用アクセス)	0x1800
//サービス名	16-bit UUID	変換後 (128-bit GUID)
//Generic Access (汎用アクセス)	0x1800	00001800-0000-1000-8000-00805F9B34FB
//Generic Attribute (汎用アトリビュート)	0x1801	00001801-0000-1000-8000-00805F9B34FB
//Device Information (デバイス情報)	0x180A	0000180A-0000-1000-8000-00805F9B34FB
//Battery Service (バッテリー情報)	0x180F	0000180F-0000-1000-8000-00805F9B34FB
//Heart Rate (心拍センサー)	0x180D	0000180D-0000-1000-8000-00805F9B34FB
//Blood Pressure (血圧計)	0x1810	00001810-0000-1000-8000-00805F9B34FB
//Glucose (血糖値センサー)	0x1808	00001808-0000-1000-8000-00805F9B34FB
//Cycling Power (サイクリングパワーメーター)	0x1818	00001818-0000-1000-8000-00805F9B34FB
//Cycling Speed and Cadence (ケイデンスセンサー)	0x1816	00001816-0000-1000-8000-00805F9B34FB
//Running Speed and Cadence (ランニングセンサー)	0x1814	00001814-0000-1000-8000-00805F9B34FB
//Environmental Sensing (温度・湿度・気圧)	0x181A	0000181A-0000-1000-8000-00805F9B34FB
//Location and Navigation (GPS・ナビゲーション)	0x1819	00001819-0000-1000-8000-00805F9B34FB
///

class BluetoothDateState {
  final List<BluetoothDevice> devices;
  final List<BluetoothDevice> connectedDevices;
  final bool isScanning;
  final BluetoothAdapterState adapterState;

  final BluetoothCharacteristic? chatCharacteristic;
  final List<String> messages;
  final List<BluetoothDevice> systemDevices;

  BluetoothDateState({
    this.devices = const [],
    this.connectedDevices = const [],
    this.isScanning = false,
    this.adapterState = BluetoothAdapterState.unknown,
    this.chatCharacteristic = null,
    this.messages = const [],
    this.systemDevices = const [],
  });

  BluetoothDateState copyWith({
    List<BluetoothDevice>? devices,
    List<BluetoothDevice>? connectedDevices,
    bool? isScanning,
    BluetoothAdapterState? adapterState,
    BluetoothCharacteristic? chatCharacteristic,
    List<String>? messages,
    List<BluetoothDevice>? systemDevices,
  }) {
    return BluetoothDateState(
      devices: devices ?? this.devices,
      connectedDevices: connectedDevices ?? this.connectedDevices,
      isScanning: isScanning ?? this.isScanning,
      adapterState: adapterState ?? this.adapterState,
      chatCharacteristic: chatCharacteristic,
      messages: messages ?? this.messages,
      systemDevices: systemDevices ?? this.systemDevices,
    );
  }
}

final bluetoothProvider =
    StateNotifierProvider<BluetoothNotifier, BluetoothDateState>((ref) {
      return BluetoothNotifier();
    });

class BluetoothNotifier extends StateNotifier<BluetoothDateState> {
  late StreamSubscription _streamSubscription;
  late StreamSubscription scanSubscription;

  BluetoothDevice? _device;

  BluetoothNotifier() : super(BluetoothDateState()) {
    init();
  }

  void init() async {
    if (await FlutterBluePlus.isSupported == false) {
      AppLogger().debug("Bluetooth not supported by this device");
      return;
    }
    _streamSubscription = FlutterBluePlus.adapterState.listen((
      BluetoothAdapterState adapterState,
    ) {
      AppLogger().debug(adapterState.toString());
      state = state.copyWith(adapterState: adapterState);

      if (adapterState == BluetoothAdapterState.on) {
        refreshConnectedDevices();
      }
    });
    // turn on bluetooth ourself if we can
    // for iOS, the user controls bluetooth enable/disable
    if (!kIsWeb && Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      final List<BluetoothDevice> devices = [...state.devices];
      for (ScanResult r in results) {
        AppLogger().debug(r.device.toString());
        //!devices.contains(r.device) && r.device.name.isNotEmpty
        if (!devices.contains(r.device) && r.device.name.isNotEmpty) {
          AppLogger().debug("Found device: ${r.device.name}");
          devices.add(r.device);
        }
        // if (
        //     !devices.any((d) => d.id == r.device.id)) {
        //   AppLogger().debug("Found device: ${r.device.name}");
        //   devices.add(r.device);
        // }
      }
      state = state.copyWith(devices: devices);
    });
  }

  Future<void> refreshConnectedDevices() async {
    try {
      final devices = await FlutterBluePlus.connectedDevices;
      state = state.copyWith(connectedDevices: devices);
    } catch (e) {
      AppLogger().debug("Error getting connected devices: $e");
    }
  }

  Future<void> refreshSystemDevices() async {
    List<Guid> withServices = [
      Guid("00001800-0000-1000-8000-00805F9B34FB"),
      // Heart Rate Service
      Guid("00001801-0000-1000-8000-00805F9B34FB"),
      Guid("0000180A-0000-1000-8000-00805F9B34FB"),
      Guid("0000180F-0000-1000-8000-00805F9B34FB"),
      Guid("0000180D-0000-1000-8000-00805F9B34FB"),
      Guid("00001810-0000-1000-8000-00805F9B34FB"),
      Guid("00001808-0000-1000-8000-00805F9B34FB"),
      Guid("00001818-0000-1000-8000-00805F9B34FB"),
      Guid("00001816-0000-1000-8000-00805F9B34FB"),
      Guid("00001814-0000-1000-8000-00805F9B34FB"),
      Guid("0000181A-0000-1000-8000-00805F9B34FB"),
      Guid("00001819-0000-1000-8000-00805F9B34FB"),
    ];
    try {
      // List<BluetoothDevice> devices = await FlutterBluePlus.bondedDevices;
      List<BluetoothDevice> devices = await FlutterBluePlus.systemDevices(
        withServices,
      );
      state = state.copyWith(systemDevices: devices);
    } catch (e) {
      AppLogger().debug("Error getting connected devices: $e");
    }
  }

  List<BluetoothDevice> getConnectdDevices() {
    return FlutterBluePlus.connectedDevices;
  }

  void startScan() async {
    if (state.isScanning) {
      await stopScan();
      return;
    }
    state = state.copyWith(devices: [], isScanning: true);

    try {
      FlutterBluePlus.startScan(timeout: Duration(seconds: 5));
      Future.delayed(Duration(seconds: 5), () {
        state = state.copyWith(isScanning: false);
      });
    } catch (e) {
      AppLogger().debug('スキャン中にエラーが発生: $e');
      state = state.copyWith(isScanning: false);
    }
  }

  Future<void> stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } finally {
      state = state.copyWith(isScanning: false);
    }
  }

  void connectToDevice(BluetoothDevice device, BuildContext context) async {
    _device = device;
    await device.connect();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatPage(device: device)),
    );
  }

  Future<void> discoverChatService() async {
    if (_device == null) {
      return;
    }
    List<BluetoothService> services = await _device!.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.write &&
            characteristic.properties.notify) {
          state = state.copyWith(chatCharacteristic: characteristic);
          // 开始监听接收消息
          characteristic.setNotifyValue(true);
          characteristic.lastValueStream.listen((value) {
            final List<String> messages = [...state.messages];

            messages.add("📩 ${String.fromCharCodes(value)}");
            state = state.copyWith(messages: messages);
          });

          return;
        }
      }
    }
  }

  void sendMessage(String message) async {
    if (state.chatCharacteristic != null) {
      await state.chatCharacteristic!.write(
        message.codeUnits,
        withoutResponse: true,
      );
    }
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    scanSubscription.cancel();
    // リソースの解放
    FlutterBluePlus.stopScan();
    super.dispose();
  }
}
