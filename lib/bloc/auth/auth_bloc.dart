import 'package:bloc/bloc.dart';
import 'package:bloc_auth/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../preference_helper.dart';
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
        GoogleSignInAccount? googleUser = await authRepository.signInWithGoogle(event.context!);
       GoogleLogin_Res data = await  googlelogin(event.context, googleUser,emit);

       if(data != null){
            emit(Authenticated());
       }
        
       // emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // When User Presses the SignOut Button, we will send the SignOutRequested Event to the AuthBloc to handle it and emit the UnAuthenticated State
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }

     Future<GoogleLogin_Res> googlelogin(BuildContext? context,GoogleSignInAccount? googleUser,Emitter<AuthState> emit) async{
    GoogleLogin_Req UserData = GoogleLogin_Req();
    GoogleLogin_Res result = GoogleLogin_Res();
    UserData.email= googleUser!.email;
    UserData.fullName=googleUser!.displayName;
    var api = Provider.of<ApiService>(context!, listen: false);
    await api.googlelogin(UserData).then((response)async{
      
     if(response != null && response.token!=null) {
      await PreferenceHelper.saveToken(response.token!);
      
      await PreferenceHelper.saveUserId(response.data!.user_id!);
      
      print("userid-222${response.data!.user_id!}");
      print("userid-00${response.token}");
      
      // emit(Authenticated()); 
     }else{
      //emit(UnAuthenticated());
     }

    });

    return result;

  }

}
