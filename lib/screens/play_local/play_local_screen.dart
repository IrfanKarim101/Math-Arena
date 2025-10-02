//create a screen for local play options
import 'package:flutter/material.dart'; 

class LocalPlayOptions extends StatelessWidget {
  const LocalPlayOptions({super.key});

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
              "Start Local Game",
              Icons.play_arrow,
              Colors.green,
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              "Back to Home",
              Icons.home,
              Colors.orange,
              exit: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon,
      Color color, {bool exit = false}) {
    return ElevatedButton.icon(
      onPressed: () {
        if (exit) {
          Navigator.pop(context);
        } else {
          // Navigate to local game screen (to be implemented)
        }
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}