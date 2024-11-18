import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  bool _isLastQuestion = false;

  int? get selectedOptionIndex => _selectedOptionIndex;
  int get correctOptionsCount => _correctOptionsCount;
  bool get isSelectedOptionCorrect => _isSelectedOptionCorrect;
  bool get isAnswered => _isAnswered;
  double get questionProgress => _questionProgress;
  bool get isLastQuestion => _isLastQuestion;

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
  int currentQuestionIndex = 0;

  // Inject QuizRepository
  final QuizRepository _quizRepository;
  QuizProvider(this._quizRepository);

  // Load quiz data
  Future<void> loadQuizData() async {
    try {
      nodes = await _quizRepository.fetchQuizData(); // Fetch data from repository

      if (nodes.isEmpty) {
        // Handle empty data gracefully if needed
        throw Exception("No quiz data found.");
      }

      notifyListeners();
    } catch (e) {
      print("Error loading quiz data: $e");
    }
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

  void getCurrentExcersiseIndex(int exerciseIndex) {
    currentExerciseIndex = exerciseIndex;
    currentQuestionIndex = 0;
    _questionProgress = 0.1;
    notifyListeners();
  }

  // Get the current question
  String get currentQuestion => nodes[currentNodeIndex].exercises[currentExerciseIndex].questions[currentQuestionIndex].text;
  List<Option> get currentOptions => nodes[currentNodeIndex].exercises[currentExerciseIndex].questions[currentQuestionIndex].options;
  Exercise get exercise => nodes[currentNodeIndex].exercises[currentExerciseIndex];

  // Move to next question
  void nextQuestion() {
    if (currentQuestionIndex < nodes[currentNodeIndex].exercises[currentExerciseIndex].questions.length - 1) {
      currentQuestionIndex++;
      print('question index $currentQuestionIndex');
      _isSelectedOptionCorrect = false;
      _questionProgress = currentQuestionIndex / nodes[currentNodeIndex].exercises[currentExerciseIndex].questions.length;
      _isLastQuestion = false;
    } else {
      _questionProgress = 1.0;
      _isLastQuestion = true;
    }
    notifyListeners();
  }

  void isCorrect() {
    _isAnswered = true;
    if (currentOptions[_selectedOptionIndex!].isCorrect) {
      _isSelectedOptionCorrect = true;
    } else {
      _isSelectedOptionCorrect = false;
    }
    notifyListeners();
  }

  void incrementScore() async {
    if (nodes.isNotEmpty && nodes[currentNodeIndex].exercises.isNotEmpty && currentExerciseIndex < nodes[currentNodeIndex].exercises.length) {
      var exercise = nodes[currentNodeIndex].exercises[currentExerciseIndex];
      exercise.score = (exercise.score ?? 0) + 1; // Increment score
      // print('score is ${exercise.score}');

      // Save updated exercise to Hive
      var exerciseBox = await Hive.openBox<Exercise>('exercisesBox');
      await exerciseBox.put(exercise.title, exercise); // Update the exercise in Hive

      notifyListeners();
    }
  }

  void resetScore() async {
    if (nodes.isNotEmpty && nodes[currentNodeIndex].exercises.isNotEmpty && currentExerciseIndex < nodes[currentNodeIndex].exercises.length) {
      var exercise = nodes[currentNodeIndex].exercises[currentExerciseIndex];
      exercise.score = 0; // Reset score to 0
      _isLastQuestion = false;

      // Save updated exercise to Hive
      var exerciseBox = await Hive.openBox<Exercise>('exercisesBox');
      await exerciseBox.put(exercise.title, exercise); // Update the exercise in Hive

      print('done resetting');

      notifyListeners();
    }
  }
}
