import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ProviderQZTray extends ChangeNotifier {
  WebSocketChannel? _channel;
  bool isConnected = false;

  // Fungsi untuk menghubungkan ke QZ Tray
  void connect() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse("ws://localhost:8182/"));
      isConnected = true;
      log("✅ Connected to QZ Tray");
      notifyListeners();
    } catch (e) {
      log("❌ Error connecting to QZ Tray: $e");
      isConnected = false;
    }
  }

  // Fungsi cetak data ZPL ke QZ Tray
  void printZPL() {
    if (!isConnected || _channel == null) {
      log("⚠️ Not connected to QZ Tray");
      return;
    }

    const zplData = '''
      ^XA
      ^FO50,50^A0N,50,50^FDHello, QZ Tray!^FS
      ^FO50,120^B3N,N,100,Y,N^FD1234567890^FS
      ^XZ
    ''';

    final printCommand = {
      "call": "qz.print",
      "params": [
        {
          "type": "raw",
          "format": "base64",
          "data": base64Encode(utf8.encode(zplData))
        }
      ]
    };

    _channel!.sink.add(jsonEncode(printCommand));
    log("🖨️ Sent ZPL print command to QZ Tray");
  }

  // Tutup koneksi saat tidak digunakan
  void disconnect() {
    _channel?.sink.close();
    isConnected = false;
    notifyListeners();
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
