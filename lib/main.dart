import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stimuler_task_app/core/providers/node_provider.dart';
import 'package:stimuler_task_app/features/home/data/home_repository_impl.dart';
import 'package:stimuler_task_app/features/home/domain/usecases/get_labels_usecase.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/homeprovider.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/sheetprovider.dart';
import 'package:stimuler_task_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:stimuler_task_app/features/login/domain/usecases/get_user.dart';
import 'package:stimuler_task_app/features/login/domain/usecases/save_username.dart';
import 'package:stimuler_task_app/routes.dart';
import 'features/login/presentation/providers/login_provider.dart';

void main() {
  final loginRepository = LoginRepositoryImpl();
  final homeRepository = HomeRepositoryImpl();

  final saveUsernameUseCase = SaveUsername(loginRepository);
  final getUsernameUseCase = GetUsername(loginRepository);
  final getLabelsUseCase = GetLabelsUseCase(homeRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            saveUsername: saveUsernameUseCase,
            getUsername: getUsernameUseCase,
          ),
        ),
        ChangeNotifierProvider(create: (_) => SheetProvider()),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(
            getLabelsUseCase: getLabelsUseCase,
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
