import 'package:stimuler_task_app/features/quiz/domain/models/exercises.dart';

class Node {
  final String title;
  final List<Exercise> exercises;

  Node({required this.title, required this.exercises});
}
