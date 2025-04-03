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
  List<Socket> _clients = [];
  ServerSocket? _server;
  OnMessageReceived? onMessage;
  Socket? _socket;

  bool get isHost => _server != null;

  List<Socket> get clients => _server != null ? _clients : [];

  //サーバーを閉める
  void stopServer() {
    _server?.close();
    _server = null;
    for (final client in _clients) {
      client.close();
    }
    _clients.clear();
  }

  // サーバーとして待機
  Future<bool> startServer({int port = 4040}) async {
    try {
      stopServer();
      _server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
      AppLogger().debug(
        "startServer:${_server?.address?.address},port:${_server?.port}",
      );
      _server!.listen((client) {
        AppLogger().debug("Client:" + client.address.address);
        _clients.add(client);
        client.listen((data) {
          final msg = utf8.decode(data);
          final map = jsonDecode(msg);
          onMessage?.call(map);
        });
      });
      return true;
    } catch (e) {
      AppLogger().debug('起動サーバー失敗: $e');
      return false;
    }
  }

  Future<void> startServerAndClient({int port = 4040}) async {
    await startServer(port: port);
    getLocalIp().then((ip) async {
      AppLogger().debug("startServerAndClient:" + ip);
      if (ip != null) {
        await connectToHost(ip, port: port);
      }
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
      _clients = [_socket!];
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

  void sendToAll(Map<String, dynamic> message) {
    for (final client in _clients) {
      client.write(jsonEncode(message));
    }
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
