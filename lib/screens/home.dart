import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1e3c72), Color(0xFF2a5298)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            const Text(
              "Math Arena",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 60),

            // Buttons
            _buildMenuButton(
              context,
              "Play Online",
              Icons.public,
              Colors.green,
            ),
            const SizedBox(height: 20),
            _buildMenuButton(context, "Play Local", Icons.group, Colors.orange),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              "Play Bluetooth",
              Icons.bluetooth,
              Colors.blue,
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              "Exit",
              Icons.exit_to_app,
              Colors.red,
              exit: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color, {
    bool exit = false,
  }) {
    return SizedBox(
      width: 250,
      height: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.black54,
          elevation: 10,
        ),
        onPressed: () {
          if (exit) {
            // Exit app
            Future.delayed(const Duration(milliseconds: 100), () {
              //exit application
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');

            });
          } else {
            // Navigate to respective screens later
            if (text == "Play Online") {
              Navigator.pushNamed(context, '/play_online_options');
            } else if (text == "Play Local") {
               Navigator.pushNamed(context, '/play_local'); // Placeholder
            } else if (text == "Play Bluetooth") {
             Navigator.pushNamed(context, '/play_bluetooth'); // Placeholder
            }
          }
        },
        icon: Icon(icon, size: 28, color: Colors.white),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
