import 'package:stimuler_task_app/features/quiz/domain/models/options.dart';

class Question {
  final String text;
  final List<Option> options;
  final Option correctOption;

  Question({required this.text, required this.options, required this.correctOption});
}
