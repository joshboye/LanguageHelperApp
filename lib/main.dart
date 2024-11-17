import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stimuler_task_app/core/providers/node_provider.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/sheetprovider.dart';
import 'package:stimuler_task_app/features/quiz/data/repositories/quiz_repository.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/exercises.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/node.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/options.dart';
import 'package:stimuler_task_app/features/quiz/domain/models/questions.dart';
import 'package:stimuler_task_app/features/quiz/presentation/provider/quiz_provider.dart';
import 'package:stimuler_task_app/features/home/data/home_repository_impl.dart';
import 'package:stimuler_task_app/features/home/domain/usecases/get_labels_usecase.dart';
import 'package:stimuler_task_app/features/home/presentation/providers/homeprovider.dart';
import 'package:stimuler_task_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:stimuler_task_app/features/login/domain/usecases/get_user.dart';
import 'package:stimuler_task_app/features/login/domain/usecases/save_username.dart';
import 'package:stimuler_task_app/routes.dart';
import 'features/login/presentation/providers/login_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register type adapters
  Hive.registerAdapter(NodeAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(OptionAdapter());

  // Open a box
  await Hive.openBox<Node>('nodesBox');
  final exercise = await Hive.openBox<Exercise>('exercisesBox');
  await Hive.openBox<Question>('questionsBox');
  await Hive.openBox<Option>('optionsBox');

  print("Existing scores:");
  for (var exercise in exercise.values) {
    print("Exercise: ${exercise.title}, Score: ${exercise.score}");
  }

  // Initialize repositories
  final quizRepository = QuizRepository();
  final loginRepository = LoginRepositoryImpl();
  final homeRepository = HomeRepositoryImpl();

  final saveUsernameUseCase = SaveUsername(loginRepository);
  final getUsernameUseCase = GetUsername(loginRepository);
  final getLabelsUseCase = GetLabelsUseCase(homeRepository);

  await quizRepository.initializeQuizData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginProvider(
            saveUsername: saveUsernameUseCase,
            getUsername: getUsernameUseCase,
          ),
        ),
        ChangeNotifierProvider(create: (_) => NodeProvider()),
        ChangeNotifierProvider(create: (_) => SheetProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider(quizRepository)), // Pass QuizRepository to QuizProvider
        ChangeNotifierProvider(create: (_) => HomeProvider(getLabelsUseCase: getLabelsUseCase)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
