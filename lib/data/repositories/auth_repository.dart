import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../preference_helper.dart';
// import '../../utils/preference_helper.dart';
import '../../services/Apiservices/ApiService.dart';
import '../../services/model/profile_request.dart';
import 'package:provider/provider.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  
  var Usertoken;

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

  Future<GoogleSignInAccount> signInWithGoogle(BuildContext? context) async {
    
    try {
     
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      //GoogleLogin(googleUser!.email,googleUser.displayName);
       if(googleUser != null){
      print('${googleUser}');
      print('NAME==${googleUser!.displayName}');
      print('EMAIL==${googleUser.email}');
     // googlelogin(context!,googleUser);
       }
      
      
      
      await FirebaseAuth.instance.signInWithCredential(credential);

      return googleUser!;
    } catch (e) {
      throw Exception(e.toString());
    }



    
  }

 // <<<<<<<<<<<<<<<<<<<<< google login repository code here..>>>>>>>>>>>>>>>>

  void googlelogin(BuildContext? context,GoogleSignInAccount? googleUser){
    GoogleLogin_Req UserData = GoogleLogin_Req();
    UserData.email= googleUser!.email;
    UserData.fullName=googleUser!.displayName;
    var api = Provider.of<ApiService>(context!, listen: false);
    api.googlelogin(UserData).then((response)async{
     if(response != null && response.token!=null) {
       
       await PreferenceHelper.saveToken(response.token!);
        await PreferenceHelper.saveUserId(response.data!.user_id!);
        print(response.data!.user_id!);
       print('ttttt${response.token!}');
      
      print(response);
     }
    });

  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
  
// <<<<<<<<<<<<<<<<<<<<< end here..>>>>>>>>>>>>>>>>

  
}
