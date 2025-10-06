import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocalPlayOptions extends StatelessWidget {
  const LocalPlayOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Math Arena - Local",
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
              const SizedBox(height: 40),
              Text(
                "Local Play Options",
                style: GoogleFonts.pressStart2p(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildActionButton(
                context,
                "Start Local Game",
                Icons.play_arrow,
                Colors.greenAccent,
                () {
                  // TODO: Navigate to local game screen
                },
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                context,
                "Back to Home",
                Icons.home,
                Colors.orangeAccent,
                () {
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              Text(
                "Play with friends on the same device!",
                style: GoogleFonts.pressStart2p(
                  fontSize: 12,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
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
}