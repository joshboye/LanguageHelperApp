import 'package:hive/hive.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/options.dart';

part 'questions.g.dart';

@HiveType(typeId: 1)
class Question {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final List<Option> options;
  @HiveField(2)
  final Option correctOption;

  Question({required this.text, required this.options, required this.correctOption});
}
