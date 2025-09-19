import 'package:flutter/material.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  List<String> players = ["You"];
  bool canStart = false;

  // Simulate player join (replace with real-time logic)
  void _simulateJoin() {
    if (players.length < 5) {
      setState(() {
        players.add("Player ${players.length + 1}");
        canStart = players.length > 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Waiting Room")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Room Code: ABC123", style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Text(
              "Players (${players.length}/5):",
              style: const TextStyle(fontSize: 18),
            ),
            ...players.map((p) => Text(p)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _simulateJoin,
              child: const Text("Simulate Player Join"),
            ),
            const SizedBox(height: 30),
            if (canStart)
              ElevatedButton(
                onPressed: () {
                  // Start game logic here
                  Navigator.pushReplacementNamed(context, '/game_screen');
                },
                child: const Text("Start Game"),
              ),
          ],
        ),
      ),
    );
  }
}
