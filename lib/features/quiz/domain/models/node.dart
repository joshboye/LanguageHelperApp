import 'package:hive/hive.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/exercises.dart';

part 'node.g.dart';

@HiveType(typeId: 3)
class Node {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<Exercise> exercises;

  Node({required this.title, required this.exercises});
}
