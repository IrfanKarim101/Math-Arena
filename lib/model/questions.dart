import 'dart:math';

class Question {
  final String question;
  final List<int> options;
  final int answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
  });
}




class QuestionGenerator {
  static final _random = Random();

  static Question generate() {
    int a = _random.nextInt(20) + 1; // 1–20
    int b = _random.nextInt(20) + 1;
    String text = "$a + $b";
    int correct = a + b;

    // Add wrong options
    List<int> options = [correct];
    while (options.length < 4) {
      int wrong = correct + _random.nextInt(10) - 5; // close wrong answers
      if (wrong != correct && !options.contains(wrong) && wrong > 0) {
        options.add(wrong);
      }
    }

    options.shuffle();

    return Question(question: text, answer: correct, options: options);
  }
}
