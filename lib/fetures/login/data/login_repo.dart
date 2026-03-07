import 'package:firebase_auth/firebase_auth.dart';
import 'package:furneture_app/fetures/login/data/login_service.dart';

class LoginRepo {
  final LoginService _loginService = LoginService();

  Future<User?> login({required String email, required String password}) async {
    final res = _loginService.login(email: email, password: password);

    return res;
  }
}
