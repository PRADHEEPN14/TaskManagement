import 'package:bloc/bloc.dart';
import 'package:bloc_auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../preference_helper.dart';
// import '../../utils/preference_helper.dart';
import '../../services/Apiservices/ApiService.dart';
import '../../services/model/profile_request.dart';
import 'package:provider/provider.dart';

import '../../services/model/profile_response.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // When User Presses the SignIn Button, we will send the SignInRequested Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // When User Presses the SignUp Button, we will send the SignUpRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // When User Presses the Google Login Button, we will send the GoogleSignInRequest Event to the AuthBloc to handle it and emit the Authenticated State if the user is authenticated
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
       authRepository.signOut();
        GoogleSignInAccount? googleUser = await authRepository.signInWithGoogle(event.context!);
       final data = await  googlelogin(event.context, googleUser,emit);

       if(data.status!)
       {
        print(data.status);
            emit(Authenticated());
            // print(data);
       }
       else{
        print(data.status);
        emit(UnAuthenticated());
        authRepository.signOut();
        GoogleSignIn().signOut();
       }
        
      //  emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });


    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await PreferenceHelper.clearStorage();
      await authRepository.signOut();

      emit(UnAuthenticated());
    });
  }


 // <<<<<<<<<<<<<<<<<<<<< Google login function here..>>>>>>>>>>>>>>>>

     Future<GoogleLogin_Res> googlelogin(BuildContext? context,GoogleSignInAccount? googleUser,Emitter<AuthState> emit) async{
                FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    _firebaseMessaging.getToken().then((token){
      print("token is $token");
  });
    GoogleLogin_Req UserData = GoogleLogin_Req();
    GoogleLogin_Res result = GoogleLogin_Res();
    UserData.email= googleUser!.email;
    UserData.fullName=googleUser!.displayName;
    // UserData.email= _firebaseMessaging.;
    var api = Provider.of<ApiService>(context!, listen: false);
    print(UserData.email);
    print(UserData.fullName);
    await api.googlelogin(UserData).then((response)async{
      print("response123 ${response}");
      result = response;
     if(response.status !=false && response.token!=null) {
      await PreferenceHelper.saveToken(response.token!);
      
      await PreferenceHelper.saveUserId(response.data!.user_id!);

      await PreferenceHelper.saveUserRoleId(response.data!.role_id!);
      
      print("userid-222${response.data!.user_id!}");
      print("userid-00${response.token!}");
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${response.message}'),backgroundColor: Colors.green,));     
      // emit(Authenticated()); 
     }else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${response.message}'),backgroundColor: Colors.red,));
      // emit(UnAuthenticated());
     }

    });

    print("printiing result ${result.message}");

    return result;

  }
 // <<<<<<<<<<<<<<<<<<<<< end here..>>>>>>>>>>>>>>>>

}
