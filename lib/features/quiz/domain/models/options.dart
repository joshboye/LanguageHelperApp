import 'package:hive/hive.dart';

part 'options.g.dart';

@HiveType(typeId: 0)
class Option {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final bool isCorrect;

  Option({required this.text, required this.isCorrect});
}
