import 'package:firebase_auth/firebase_auth.dart';
import 'package:furneture_app/fetures/create_account/data/createAccount_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  Future<User> register({
    required String email,
    required String password,
  }) async {
    try {
      // 1️⃣ تسجيل في Firebase Auth
      final userCredential = await _authService.register(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // 2️⃣ إنشاء document في Firestore
      await _userService.createUser(uid: uid, email: email);

      return userCredential.user!;
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }
}
