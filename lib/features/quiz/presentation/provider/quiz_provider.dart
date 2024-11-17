import 'package:flutter/material.dart';
import 'package:stimuler_task_app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/exercises.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/node.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/options.dart';

class QuizProvider with ChangeNotifier {
  int? _selectedOptionIndex;
  int _correctOptionsCount = 0;
  bool _isSelectedOptionCorrect = false;
  bool _isAnswered = false;
  double _questionProgress = 0.1;

  int? get selectedOptionIndex => _selectedOptionIndex;
  int get correctOptionsCount => _correctOptionsCount;
  bool get isSelectedOptionCorrect => _isSelectedOptionCorrect;
  bool get isAnswered => _isAnswered;
  double get questionProgress => _questionProgress;

  void selectOption(int index) {
    if (_selectedOptionIndex == index) {
      _selectedOptionIndex = null;
    } else {
      _selectedOptionIndex = index;
      print(selectedOptionIndex);
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
    notifyListeners();
  }

  void intitaliseExcersiseFunctions() {
    excersise.loadScore();
    notifyListeners();
  }

  void getCurrentNodeIndex(int nodeIndex) {
    currentNodeIndex = nodeIndex - 1;
    notifyListeners();
  }

  void resetSelection() {
    _selectedOptionIndex = null;
    _isSelectedOptionCorrect = false;
    _isAnswered = false;
    notifyListeners();
  }

  void getCurrentExcersiseIndex(int exceriseIndex) {
    currentExerciseIndex = exceriseIndex;
    currentQuestionIndex = 0;
    _questionProgress = 0.1;
    notifyListeners();
  }

  // Get the current question
  String get currentQuestion => nodes[currentNodeIndex].exercises[currentExerciseIndex].questions[currentQuestionIndex].text;
  List<Option> get currentOptions => nodes[currentNodeIndex].exercises[currentExerciseIndex].questions[currentQuestionIndex].options;
  Exercise get excersise => nodes[currentNodeIndex].exercises[currentExerciseIndex];
  // Move to next question
  void nextQuestion() {
    if (currentQuestionIndex < nodes[currentNodeIndex].exercises[currentExerciseIndex].questions.length - 1) {
      currentQuestionIndex++;
      _isSelectedOptionCorrect = false;
      _questionProgress = currentQuestionIndex / nodes[currentNodeIndex].exercises[currentExerciseIndex].questions.length;
    } else {
      _questionProgress = 1.0;
    }
    notifyListeners();
  }

  void resetScore() {
    print('in here');
    excersise.resetExcersiseScore();
    notifyListeners();
  }

  void isCorrect() {
    _isAnswered = true;
    if (currentOptions[_selectedOptionIndex!].isCorrect) {
      excersise.incrementScore();
      int te = excersise.score;
      // print('score is $te');
      _isSelectedOptionCorrect = true;
    } else {
      _isSelectedOptionCorrect = false;
    }
    notifyListeners();
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
