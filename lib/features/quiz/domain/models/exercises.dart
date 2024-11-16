import 'package:stimuler_task_app/features/quiz/domain/models/questions.dart';

class Exercise {
  final String title;
  final List<Question> questions;

  Exercise({required this.title, required this.questions});
}
