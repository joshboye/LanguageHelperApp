import 'package:hive/hive.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/questions.dart';

part 'exercises.g.dart';

@HiveType(typeId: 2)
class Exercise {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<Question> questions;
  @HiveField(2)
  int? score; // Added score field

  Exercise({required this.title, required this.questions, this.score});
}
