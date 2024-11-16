import 'package:stimuler_task_app/features/home/domain/entities/labels.dart';

abstract class HomeRepository {
  Future<List<Label>> fetchLabels();
}
