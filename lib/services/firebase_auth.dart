import 'package:firebase_auth/firebase_auth.dart';

abstract class SignIn {
  Future<void> signIn();
}

class SignInWithFirebaseAuth implements SignIn {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signIn() async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
