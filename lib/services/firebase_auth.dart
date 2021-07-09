import 'package:firebase_auth/firebase_auth.dart';

abstract class SignIn {
  Future<UserCredential> signIn();
}

class SignInWithFirebaseAuth implements SignIn {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signIn() async {
    return await _auth.signInAnonymously();
  }
}
