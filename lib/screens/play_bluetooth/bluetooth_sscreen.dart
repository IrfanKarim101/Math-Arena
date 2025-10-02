import 'package:flutter/material.dart';
import 'package:math_arena/services/bluetooth_service.dart';
import 'package:google_fonts/google_fonts.dart';


class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final BluetoothService btService = BluetoothService();
  String log = "";
  Map<String, String> discoveredEndpoints = {}; // Store id and name
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
  void initState() {
    super.initState();
    btService.requestBluetoothPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Math Arena - Bluetooth",
          style: GoogleFonts.pressStart2p(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildActionButton(
                context,
                "Start Hosting",
                Icons.wifi_tethering,
                Colors.greenAccent,
                () {
                  try {
                    btService.startHosting(
                      "HostPlayer",
                      (id, name) => appendLog("Request from $name"),
                      (id) {
                        connectedId = id;
                        appendLog("Connected: $id");
                      },
                      (id) => appendLog("Disconnected: $id"),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Bluetooth is off or permissions not granted")),
                    );
                    appendLog("Error starting hosting: $e");
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                context,
                "Discover Games",
                Icons.search,
                Colors.blueAccent,
                () {
                  try {
                    btService.startDiscovering("GuestPlayer", (id, name) {
                      setState(() {
                        discoveredEndpoints[id] = name;
                      });
                      appendLog("Found $name ($id)");
                    }, (id) {
                      setState(() {
                        discoveredEndpoints.remove(id);
                      });
                      appendLog("Lost $id");
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Bluetooth is off or permissions not granted")),
                    );
                    appendLog("Error starting discovery: $e");
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                context,
                "Send Test Message",
                Icons.send,
                Colors.orangeAccent,
                () {
                  if (connectedId != null) {
                    btService.sendMessage(connectedId!, "Hello from Player!");
                    appendLog("Message sent");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Not connected to any device")),
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              Text(
                "Discovered Devices:",
                style: GoogleFonts.pressStart2p(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    itemCount: discoveredEndpoints.length,
                    itemBuilder: (context, index) {
                      final entry = discoveredEndpoints.entries.elementAt(index);
                      return _buildDiscoveredDeviceTile(entry.value, entry.key);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Activity Log:",
                style: GoogleFonts.pressStart2p(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      log,
                      style: GoogleFonts.pressStart2p(fontSize: 10, color: Colors.lightGreenAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String text, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        shadowColor: color.withOpacity(0.5),
      ),
    );
  }

  Widget _buildDiscoveredDeviceTile(String name, String id) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.white.withOpacity(0.3)),
      ),
      child: ListTile(
        leading: const Icon(Icons.bluetooth, color: Colors.white70),
        title: Text(
          name,
          style: GoogleFonts.pressStart2p(fontSize: 12, color: Colors.white),
        ),
        subtitle: Text(
          id,
          style: const TextStyle(fontSize: 10, color: Colors.white54),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // TODO: Implement connection logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrangeAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Connect",
            style: GoogleFonts.pressStart2p(fontSize: 10, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
