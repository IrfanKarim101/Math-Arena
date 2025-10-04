import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Math Arena",
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Math Arena!",
                style: GoogleFonts.pressStart2p(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildMenuButton(
                context,
                "Play Online",
                Icons.public,
                Colors.greenAccent,
                () => Navigator.pushNamed(context, '/play_online_options'),
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                "Play Local",
                Icons.people,
                Colors.blueAccent,
                () => Navigator.pushNamed(context, '/play_local'),
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                "Play Bluetooth",
                Icons.bluetooth,
                Colors.orangeAccent,
                () => Navigator.pushNamed(context, '/play_bluetooth'),
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                context,
                "Exit",
                Icons.exit_to_app,
                Colors.redAccent,
                () => Navigator.of(context).maybePop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        shadowColor: color.withOpacity(0.5),
      ),
    );
  }
}
