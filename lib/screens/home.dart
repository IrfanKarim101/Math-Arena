import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

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
          image: DecorationImage(
            image: AssetImage('assets/images/background_pattern.png'), // Add a subtle pattern
            repeat: ImageRepeat.repeat,
            opacity: 0.1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation for a dynamic touch
            Lottie.asset(
              'assets/animations/math_animation.json', // Replace with your Lottie animation file
              height: 150,
              repeat: true,
              reverse: true,
              animate: true,
            ),
            const SizedBox(height: 30),

            // Title
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.yellowAccent, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
              "Math Arena",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
              ),
            ),
            const SizedBox(height: 50),

            // Buttons
            _buildMenuButton(context, "Play Online", Icons.public, const Color(0xFF4CAF50)), // Green
            const SizedBox(height: 15),
            _buildMenuButton(context, "Play Local", Icons.group, const Color(0xFFFF9800)), // Orange
            const SizedBox(height: 15),
            _buildMenuButton(context, "Play Bluetooth", Icons.bluetooth, const Color(0xFF2196F3)), // Blue
            const SizedBox(height: 15),
            _buildMenuButton(context, "Settings", Icons.settings, const Color(0xFF9E9E9E)), // Grey for settings
            const SizedBox(height: 15),
            _buildMenuButton(context, "Exit", Icons.exit_to_app, const Color(0xFFF44336), exit: true), // Red
            const SizedBox(height: 30),
            const Text(
              "© 2023 Math Arena. All rights reserved.",
              style: TextStyle(color: Colors.white70, fontSize: 12),
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
      width: 280,
      height: 65,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.9),
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
            } else if (text == "Settings") {
              // Navigator.pushNamed(context, '/settings'); // Placeholder for settings screen
            }
          }
        },
        icon: Icon(icon, size: 30, color: Colors.white),
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
