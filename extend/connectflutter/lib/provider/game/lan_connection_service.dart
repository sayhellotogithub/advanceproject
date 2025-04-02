// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:
// -------------------------------------------------------------------
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectflutter/util/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef OnMessageReceived = void Function(Map<String, dynamic> message);

class LanConnectionService {
  Socket? _socket;
  ServerSocket? _server;
  OnMessageReceived? onMessage;

  // サーバーとして待機
  Future<void> startServer({int port = 4040}) async {
    _server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    AppLogger().debug(
      "startServer:${_server?.address?.address},port:${_server?.port}",
    );
    _server!.listen((client) {
      AppLogger().debug("Client:" + client.address.address);
      _socket = client;
      _socket!.listen((data) {
        final msg = utf8.decode(data);
        final map = jsonDecode(msg);
        onMessage?.call(map);
      });
    });
  }

  // クライアントとして接続
  Future<bool> connectToHost(String ip, {int port = 4040}) async {
    try {
      AppLogger().debug("connectToHost Client:" + ip);
      _socket = await Socket.connect(
        ip,
        port,
      ).timeout(const Duration(seconds: 3));
      _socket!.listen(_handleData);
      return true;
    } catch (e) {
      AppLogger().debug('接続失敗: $e');
      return false;
    }
  }

  void _handleData(Uint8List data) {
    final msg = utf8.decode(data);
    final map = jsonDecode(msg);
    AppLogger().debug("connectToHost Client:" + msg);
    onMessage?.call(map);
  }

  // メッセージ送信
  void send(Map<String, dynamic> message) {
    _socket?.write(jsonEncode(message));
  }

  Future<String> getLocalIp() async {
    final interfaces = await NetworkInterface.list(
      type: InternetAddressType.IPv4,
    );
    for (final interface in interfaces) {
      for (final addr in interface.addresses) {
        if (!addr.isLoopback && addr.address.startsWith('192.')) {
          return addr.address;
        }
      }
    }
    return '不明';
  }

  void dispose() {
    _socket?.close();
    _server?.close();
  }
}

final lanConnectionProvider = Provider<LanConnectionService>((ref) {
  final service = LanConnectionService();
  ref.onDispose(() => service.dispose());
  return service;
});
