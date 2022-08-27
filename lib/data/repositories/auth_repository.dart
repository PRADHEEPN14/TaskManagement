import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    
    try {
     
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // GoogleLogin(googleUser!.email,googleUser.displayName);
       
      print('${googleUser}');
      print('NAME==${googleUser!.displayName}');
      print('EMAIL==${googleUser.email}');
      
      
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }

    // await GoogleSignIn().signOut();
    // try {
    //   GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    //   if (googleSignInAccount != null) {
    //     GoogleSignInAuthentication googleAuth =
    //         await googleSignInAccount.authentication;
    //         print("user:${googleSignInAccount.email}");
    //     // GoogleSignIn(
    //     //     googleSignInAccount.email, googleSignInAccount.displayName);
    //   }

    //   print("4");
    // } catch (error) {
    //   print("5:$error");
    //   // ignore: avoid_returning_null_for_void
    //   return null;
    // }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
