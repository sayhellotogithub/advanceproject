// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/01
// Description:
// -------------------------------------------------------------------
import 'dart:io';

import 'package:connectflutter/provider/game/lan_connection_service.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multicast_dns/multicast_dns.dart';

import '../../../component/index.dart';
import '../../../util/index.dart';

class ConnectPage extends ConsumerStatefulWidget {
  const ConnectPage({super.key});

  @override
  ConsumerState<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends ConsumerState<ConnectPage> {
  String? _detectedIp;
  bool _isSearching = false;
  String _localIp = "";
  String _role = 'p2'; // 初期はプレイヤー2（接続者）
  bool _isStartingServer = false;
  bool _isStartedServer = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startMdnsDiscovery();
    _getLocalIp();
  }

  Future<void> _getLocalIp() async {
    ref.read(lanConnectionProvider).getLocalIp().then((value) {
      setState(() {
        _localIp = value;
      });
    });
  }

  Future<void> _startMdnsDiscovery() async {
    setState(() => _isSearching = true);
    final mdns = MDnsClient(
      rawDatagramSocketFactory: (
        dynamic host,
        int port, {
        bool reuseAddress = true,
        bool reusePort = false,
        int ttl = 1,
      }) async {
        return await RawDatagramSocket.bind(
          InternetAddress.anyIPv4,
          port,
          reuseAddress: true,
          reusePort: false,
        );
      },
    );
    try {
      await mdns.start();

      await for (final PtrResourceRecord ptr in mdns.lookup<PtrResourceRecord>(
        ResourceRecordQuery.serverPointer('_shogi._tcp.local'),
      )) {
        await for (final SrvResourceRecord srv in mdns
            .lookup<SrvResourceRecord>(
              ResourceRecordQuery.service(ptr.domainName),
            )) {
          setState(() {
            _detectedIp = srv.target;
            _controller.text = srv.target;
            _isSearching = false;
          });
          mdns.stop(); // ← 忘れずに止める！
          return;
        }
      }
      mdns.stop(); // ✅ 通常終了時も stop
    } catch (e) {
      debugPrint('mDNS エラー: $e');
      mdns.stop(); // エラー時でも stop
    }
    setState(() => _isSearching = false);
  }

  Widget buildServerControlButton() {
    if (_isStartedServer) {
      return buildWidgetButton('サーバーを停止', _toggleServer);
    } else {
      return buildWidgetButton('サーバーを開始', _toggleServer);
    }
  }

  Future<void> _toggleServer() async {
    final connection = ref.read(lanConnectionProvider);
    setState(() {
      _isStartingServer = true;
    });

    if (_isStartedServer) {
      connection.stopServer();
      setState(() {
        _isStartedServer = false;
        _isStartingServer = false;
      });
    } else {
      final success = await connection.startServer();
      setState(() {
        _isStartingServer = false;
        _isStartedServer = success;
      });
      final message = success ? 'サーバーを開始しました' : 'サーバーの開始に失敗しました';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final connection = ref.read(lanConnectionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('接続')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("IP:$_localIp"),
                  SizedBox(width: 30),
                  if (_isStartingServer) const CircularProgressIndicator(),
                  buildServerControlButton(),
                ],
              ),
              if (connection.clients.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("👥 接続中: ${connection.clients.join(', ')}"),
                ),
              SizedBox(height: DimenUtil.height18),
              Row(
                children: [
                  const Text('役割:'),
                  DropdownButton<String>(
                    value: _role,
                    items: const [
                      DropdownMenuItem(value: 'p2', child: Text('プレイヤー2')),
                      DropdownMenuItem(value: 'p1', child: Text('プレイヤー1')),
                      DropdownMenuItem(value: 'spectator', child: Text('観戦者')),
                    ],
                    onChanged: (val) => setState(() => _role = val!),
                  ),
                ],
              ),
              SizedBox(height: DimenUtil.height24),
              Row(
                children: [
                  const Text('1. 自動検出（mDNS）'),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      _startMdnsDiscovery();
                    },
                  ),
                ],
              ),
              if (_isSearching) const CircularProgressIndicator(),
              if (_detectedIp != null) Text('見つかったIP: $_detectedIp'),
              SizedBox(height: DimenUtil.height24),
              const Text('2. IPアドレスを手動入力'),
              CommonInputFieldWidget(
                hintText: "例: 192.168.0.10",
                controller: _controller,
              ),

              SizedBox(height: DimenUtil.height24),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final ip = _controller.text.trim();
                    final success = await connection.connectToHost(ip);
                    if (!success) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ホストに接続できませんでした')),
                        );
                      }
                      return;
                    }
                    if (context.mounted) {
                      context.push(shogiBoardPath, extra: _role);
                    }
                  },
                  child: const Text('接続する'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
