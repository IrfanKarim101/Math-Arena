import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnlinePlayOptions extends StatelessWidget {
  const OnlinePlayOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Math Arena - Online",
          style: GoogleFonts.pressStart2p(fontSize: 18, color: Colors.white),
        ),
        automaticallyImplyLeading: false,

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
                "Choose Online Mode",
                style: GoogleFonts.pressStart2p(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildActionButton(
                context,
                "Create Room",
                Icons.group_add,
                Colors.greenAccent,
                () => Navigator.pushNamed(context, '/create_room'),
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                context,
                "Join Room",
                Icons.meeting_room,
                Colors.blueAccent,
                () => Navigator.pushNamed(context, '/join_room'),
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                context,
                "Play Random",
                Icons.shuffle,
                Colors.orangeAccent,
                () => Navigator.pushNamed(context, '/random_play'),
              ),
              const SizedBox(height: 16),
              _buildActionButton(
                context,
                "Back",
                Icons.arrow_back,
                Colors.redAccent,
                () => Navigator.of(context).pop(),
              ),
              const Spacer(),
              Text(
                "Create or join a room, or play with a random opponent!",
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
        minimumSize: const Size.fromHeight(
          50,
        ), // Ensures uniform height and expands width
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8,
        shadowColor: color.withOpacity(0.5),
      ),
    );
  }
}
