import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://0.0.0.0:8000"; // change for device/IP

  Future<void> createGame(String gameId) async {
    final response = await http.post(Uri.parse("$baseUrl/create_game/$gameId"));
    if (response.statusCode != 200) {
      throw Exception("Failed to create game");
    }
  }

  Future<void> joinGame(String gameId, String player) async {
    final response = await http.post(Uri.parse("$baseUrl/join_game/$gameId?player=$player"));
    if (response.statusCode != 200) {
      throw Exception("Failed to join game");
    }
  }

  Future<void> updateScore(String gameId, String player, int correct, int wrong) async {
    final response = await http.post(
      Uri.parse("$baseUrl/update_score/$gameId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "player": player,
        "correct": correct,
        "wrong": wrong,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update score");
    }
  }

  Future<Map<String, dynamic>> getScores(String gameId) async {
    final response = await http.get(Uri.parse("$baseUrl/get_scores/$gameId"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch scores");
    }
  }
}
