import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user.dart';

class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  AppUser _userFromFirebaseUser(firebase.User user) {
    return user != null ? AppUser(uid: user.uid, email: user.email) : null;
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

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      firebase.UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebase.User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          print('sign in');
          return signInWithEmailAndPassword(email, password);
        }
      } else {}
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      firebase.UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(result);
      firebase.User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
