import 'package:flutter/material.dart';

class OnlinePlayOptions extends StatelessWidget {
  const OnlinePlayOptions({super.key});

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
              "Create Room",
              Icons.public,
              Colors.green,
            ),
            const SizedBox(height: 20),
            _buildMenuButton(context, "Play Local", Icons.group, Colors.orange),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              "Join Room",
              Icons.bluetooth,
              Colors.blue,
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              "Play Random",
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
            if (text == "Create Room") {
            Navigator.pushNamed(context, '/create_room');
          } else if (text == "Join Room") {
            Navigator.pushNamed(context, '/join_room');
          } else if (text == "Play Random") {
            Navigator.pushNamed(context, '/random_play');
          } else if (exit) {
            Future.delayed(const Duration(milliseconds: 100), () {
              Navigator.of(context).pop();
            });
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
