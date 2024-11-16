import 'package:stimuler_task_app/features/home/domain/entities/labels.dart';
import 'package:stimuler_task_app/features/home/domain/repositories/homerepository.dart';

class GetLabelsUseCase {
  final HomeRepository repository;

  GetLabelsUseCase(this.repository);

  Future<List<Label>> call() {
    return repository.fetchLabels();
  }
}
