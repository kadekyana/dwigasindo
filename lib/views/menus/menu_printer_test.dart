import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dwigasindo/providers/provider_qztray.dart';

class MenuPrintScreen extends StatelessWidget {
  const MenuPrintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerQZTray = Provider.of<ProviderQZTray>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("QZ Tray Print")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              providerQZTray.isConnected
                  ? "✅ Connected to QZ Tray"
                  : "❌ Not Connected",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: providerQZTray.connect,
              child: const Text("Connect to QZ Tray"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  providerQZTray.isConnected ? providerQZTray.printZPL : null,
              child: const Text("Print ZPL"),
            ),
          ],
        ),
      ),
    );
  }
}
