import 'package:stimuler_task_app/features/login/data/repositories/login_repository.dart';

class GetUsername {
  final LoginRepository repository;

  GetUsername(this.repository);

  Future<String?> call() async {
    return await repository.getUsername();
  }
}
