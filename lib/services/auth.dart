import 'package:firebase_auth/firebase_auth.dart' as firebase;
import '../models/app_user.dart';

class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  AppUser _userFromFirebaseUser(firebase.User user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser> get user {
    return _auth.authStateChanges().map((firebase.User user) => _userFromFirebaseUser(user));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      firebase.UserCredential result = await _auth.signInAnonymously();
      firebase.User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
