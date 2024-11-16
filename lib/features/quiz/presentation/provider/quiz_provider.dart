import 'package:flutter/material.dart';
import 'package:stimuler_task_app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/node.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/options.dart';

class QuizProvider with ChangeNotifier {
  int? _selectedOptionIndex;
  int _correctOptionsCount = 0;
  int? _questionNumber = 1;

  int? get selectedOptionIndex => _selectedOptionIndex;
  int get correctOptionsCount => _correctOptionsCount;
  int? get questionNumber => _questionNumber;

  void selectOption(int index) {
    if (_selectedOptionIndex == index) {
      _selectedOptionIndex = null;
    } else {
      _selectedOptionIndex = index;
    }
    notifyListeners();
  }

  List<Node> nodes = [];
  int currentNodeIndex = 0;
  int currentExerciseIndex = 0;
  int currentQuestionIndex = 1;

  void loadQuizData() {
    QuizRepository repository = QuizRepository();
    nodes = repository.fetchQuizData();
    print(nodes[0]);
    notifyListeners();
  }

  // Get the current question
  String get currentQuestion => nodes[currentNodeIndex].exercises[currentExerciseIndex].questions[currentQuestionIndex].text;
  List<Option> get currentOptions => nodes[currentNodeIndex].exercises[currentExerciseIndex].questions[currentQuestionIndex].options;

  // Move to next question
  void nextQuestion() {
    if (currentQuestionIndex < nodes[currentNodeIndex].exercises[currentExerciseIndex].questions.length - 1) {
      currentQuestionIndex++;
    }
    notifyListeners();
  }

  void isCorrect(int index) {
    if (currentOptions[index].isCorrect) {
      _correctOptionsCount++;
    }
  }

  void nextExercise() {
    if (currentExerciseIndex < nodes[currentNodeIndex].exercises.length - 1) {
      currentExerciseIndex++;
      currentQuestionIndex = 0;
    }
    notifyListeners();
  }

  void nextNode() {
    if (currentNodeIndex < nodes.length - 1) {
      currentNodeIndex++;
      currentExerciseIndex = 0;
      currentQuestionIndex = 0;
    }
    notifyListeners();
  }
}
