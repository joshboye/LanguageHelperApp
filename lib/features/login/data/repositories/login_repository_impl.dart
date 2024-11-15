import 'package:shared_preferences/shared_preferences.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  static const String _keyUsername = 'username';

  @override
  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  @override
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }
}
