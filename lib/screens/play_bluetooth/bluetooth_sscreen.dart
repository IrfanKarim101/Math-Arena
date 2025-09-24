import 'package:flutter/material.dart';
import 'package:math_arena/services/bluetooth_service.dart';


class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final BluetoothService btService = BluetoothService();
  String log = "";
  List<String> endpoints = [];
  String? connectedId;

  void appendLog(String msg) {
    setState(() {
      log += "$msg\n";
    });
  }

  @override
  void dispose() {
    btService.stopAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Math Arena - Bluetooth")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              btService.startHosting(
                "HostPlayer",
                (id, name) => appendLog("Request from $name"),
                (id) {
                  connectedId = id;
                  appendLog("Connected: $id");
                },
                (id) => appendLog("Disconnected: $id"),
              );
            },
            child: const Text("Start Hosting"),
          ),
          ElevatedButton(
            onPressed: () {
              btService.startDiscovering("GuestPlayer", (id, name) {
                endpoints.add(id);
                appendLog("Found $name ($id)");
              }, (id) => appendLog("Lost $id"));
            },
            child: const Text("Discover Games"),
          ),
          ElevatedButton(
            onPressed: () {
              if (connectedId != null) {
                btService.sendMessage(connectedId!, "Hello from Player!");
                appendLog("Message sent");
              }
            },
            child: const Text("Send Test Message"),
          ),
          Expanded(child: SingleChildScrollView(child: Text(log))),
        ],
      ),
    );
  }
}
