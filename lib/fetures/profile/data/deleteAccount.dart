// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> deleteAccount(String password) async {
    final user = _auth.currentUser!;
    final email = user.email!;

    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
    await user.delete();
  }
}
