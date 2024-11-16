import 'package:stimuler_task_app/features/home/domain/entities/labels.dart';
import 'package:stimuler_task_app/features/home/domain/repositories/homerepository.dart';

import 'models/label_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<Label>> fetchLabels() {
    return Future.value(const [
      LabelModel("Adverb"),
      LabelModel("Adjective"),
      LabelModel("Conjunction"),
      LabelModel("Prepositions"),
      LabelModel("Tenses"),
      LabelModel("Nouns"),
    ]);
  }
}
