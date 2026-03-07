import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furneture_app/fetures/create_account/data/createaccount_repo.dart';
import 'package:furneture_app/fetures/login/cubit/login_state.dart';
import 'package:furneture_app/fetures/login/data/login_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginRepo _loginRepo = LoginRepo();
  final AuthRepository _createRepo = AuthRepository();

  User? currentUser;

  AuthCubit() : super(AuthInitial());

  /// 🔹 LOGIN
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final user = await _loginRepo.login(email: email, password: password);

      if (user != null) {
        currentUser = user;
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Invalid credentials"));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login failed"));
    }
  }

  /// 🔹 REGISTER
  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthLoading());

    try {
      final user = await _createRepo.register(email: email, password: password);

      currentUser = user;
      emit(AuthAuthenticated(user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Register failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// 🔹 LOGOUT

  /// 🔹 CHECK SESSION (auto login)
  void checkAuth() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      currentUser = user;
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
