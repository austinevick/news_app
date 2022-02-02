import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();

  static Stream<User?> get authCurrentState => _auth.authStateChanges();
  static User? get user => _auth.currentUser;
  static Future<UserCredential> signIn(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<UserCredential> signUp(String email, String password) async {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  static Future<void> logOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }

  static Future googleSignOut() async {
    await googleSignIn.signOut();
  }

  static Future<User?> signInWithGoogle() async {
    User? user;
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        throw e;
      }

      return user;
    }
  }
}
