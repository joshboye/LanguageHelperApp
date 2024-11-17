import 'package:shared_preferences/shared_preferences.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/questions.dart';

class Exercise {
  final String title;
  final List<Question> questions;
  int score;

  Exercise({required this.title, required this.questions, this.score = 0});

  // Increment the score
  Future<void> incrementScore() async {
    score++;
    await _saveScore(); // Ensure save happens asynchronously
    print('incremented score is $score');
  }

  // Reset the score
  Future<void> resetExcersiseScore() async {
    score = 0;
    await _saveScore(); // Save the reset score asynchronously
    print('the score is reset to $score');
  }

  // Save the score to SharedPreferences
  Future<void> _saveScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_getScoreKey(), score);
  }

  // Load the score from SharedPreferences
  Future<void> loadScore() async {
    final prefs = await SharedPreferences.getInstance();
    score = prefs.getInt(_getScoreKey()) ?? 0;
    print('Loaded score: $score');
  }

  // Generate a unique key for this exercise's score
  String _getScoreKey() {
    return 'score_$title';
  }
}
