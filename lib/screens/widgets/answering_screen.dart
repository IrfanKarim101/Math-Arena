import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnsweringScreen extends StatelessWidget {
  final String playerName;
  final int playerScore;
  final String opponentName;
  final int opponentScore;
  final String question;
  final List<String> answers;
  final Function(int) onAnswerSelected;

  const AnsweringScreen({
    super.key,
    required this.playerName,
    required this.playerScore,
    required this.opponentName,
    required this.opponentScore,
    required this.question,
    required this.answers,
    required this.onAnswerSelected,
  });

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Player name and score
              _buildPlayerInfo(opponentName, opponentScore, false),
              const SizedBox(height: 30),
              // Question
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Text(
                  question,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              // Answers
              Expanded(
                child: ListView.builder(
                  itemCount: answers.length,
                  itemBuilder: (context, index) {
                    return _buildAnswerBlock(
                      answers[index],
                      () => onAnswerSelected(index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Player name and score
              _buildPlayerInfo(playerName, playerScore, true),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerInfo(String name, int score, bool isYou) {
    return Column(
      crossAxisAlignment: isYou
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          isYou ? "You" : "Opponent",
          style: GoogleFonts.pressStart2p(fontSize: 12, color: Colors.white70),
        ),
        Text(
          name,
          style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.white),
        ),
        Text(
          "Score: $score",
          style: GoogleFonts.pressStart2p(
            fontSize: 12,
            color: Colors.greenAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerBlock(String answer, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            answer,
            style: GoogleFonts.pressStart2p(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
