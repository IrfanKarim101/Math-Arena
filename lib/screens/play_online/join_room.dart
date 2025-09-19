import 'package:flutter/material.dart';

class JoinRoomScreen extends StatelessWidget {
  const JoinRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated room list
    final rooms = [
      {"code": "ABC123", "players": 2},
      {"code": "XYZ789", "players": 4},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Join a Room")),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return ListTile(
            title: Text("Room ${room['code']}"),
            subtitle: Text("${room['players']} players"),
            trailing: ElevatedButton(
              onPressed: () {
                // Join logic here
                Navigator.pushReplacementNamed(context, '/game_screen');
              },
              child: const Text("Join"),
            ),
          );
        },
      ),
    );
  }
}
