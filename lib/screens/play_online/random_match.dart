import 'package:flutter/material.dart';

class RandomPlayScreen extends StatefulWidget {
  const RandomPlayScreen({super.key});

  @override
  State<RandomPlayScreen> createState() => _RandomPlayScreenState();
}

class _RandomPlayScreenState extends State<RandomPlayScreen> {
  bool matched = false;

  void _simulateMatch() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      matched = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, '/game_screen');
  }

  @override
  void initState() {
    super.initState();
    _simulateMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Random Matchmaking")),
      body: Center(
        child: matched
            ? const Text(
                "Matched! Starting game...",
                style: TextStyle(fontSize: 22),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
