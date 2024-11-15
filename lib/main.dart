import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stimuler_task_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:stimuler_task_app/features/login/domain/usecases/get_user.dart';
import 'package:stimuler_task_app/features/login/domain/usecases/save_username.dart';
import 'package:stimuler_task_app/routes.dart';
import 'features/login/presentation/providers/login_provider.dart';

void main() {
  final repository = LoginRepositoryImpl();
  final saveUsernameUseCase = SaveUsername(repository);
  final getUsernameUseCase = GetUsername(repository);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            saveUsername: saveUsernameUseCase,
            getUsername: getUsernameUseCase,
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
