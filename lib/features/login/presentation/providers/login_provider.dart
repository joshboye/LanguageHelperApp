import 'package:flutter/material.dart';
import 'package:stimuler_task_app/features/login/domain/usecases/get_user.dart';
import 'package:stimuler_task_app/features/login/domain/usecases/save_username.dart';

class LoginProvider with ChangeNotifier {
  final SaveUsername saveUsername;
  final GetUsername getUsername;

  LoginProvider({
    required this.saveUsername,
    required this.getUsername,
  });

  String _username = '';
  String get username => _username;

  Future<void> login(String username) async {
    if (username.isNotEmpty) {
      await saveUsername(username);
      _username = username;
      notifyListeners();
    }
  }

  Future<void> loadUsername() async {
    final savedUsername = await getUsername();
    if (savedUsername != null) {
      _username = savedUsername;
      notifyListeners();
    }
  }
}
