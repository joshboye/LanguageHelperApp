import 'package:stimuler_task_app/features/login/data/repositories/login_repository.dart';

class SaveUsername {
  final LoginRepository repository;

  SaveUsername(this.repository);

  Future<void> call(String username) async {
    await repository.saveUsername(username);
  }
}
