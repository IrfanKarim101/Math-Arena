import 'package:flutter/material.dart';
import 'package:math_arena/services/api_service.dart';
import 'package:math_arena/services/websocket_service.dart';

class GameScreen extends StatefulWidget {
  final String gameId;
  final String player;

  const GameScreen({super.key, required this.gameId, required this.player});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ApiService api = ApiService();
  final WebSocketService ws = WebSocketService();

  int correct = 0;
  int wrong = 0;
  String opponentUpdate = "";

  @override
  void initState() {
    super.initState();
    ws.connect(widget.player);
    ws.stream.listen((msg) {
      setState(() {
        opponentUpdate = msg;
      });
    });
  }

  void updateScore(bool isCorrect) async {
    if (isCorrect) {
      correct++;
    } else {
      wrong++;
    }
    await api.updateScore(widget.gameId, widget.player, correct, wrong);
    ws.sendMessage("Score Update → C:$correct W:$wrong");
  }

  @override
  void dispose() {
    ws.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Math Arena - ${widget.player}")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("✅ Correct: $correct", style: TextStyle(fontSize: 20)),
          Text("❌ Wrong: $wrong", style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          Text("Opponent Update: $opponentUpdate"),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => updateScore(true),
            child: Text("Answer Correct"),
          ),
          ElevatedButton(
            onPressed: () => updateScore(false),
            child: Text("Answer Wrong"),
          ),
        ],
      ),
    );
  }
}
