import 'dart:ui';

import 'package:bloc_auth/bloc/auth/auth_bloc.dart';
// import 'package:bloc_auth/bloc/bloc/auth_bloc.dart';
import 'package:bloc_auth/presentation/Dashboard/dashboard.dart';
import 'package:bloc_auth/presentation/SignUp/sign_up.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Navigating to the dashboard screen if the user is authenticated
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            }
            if (state is AuthError) {
              // Showing the error message if the user has entered invalid credentials
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is Loading) {
                // Showing the loading indicator while the user is signing in
                return const Center(
                  child: CircularProgressIndicator(),
                  
                );
              }
              if (state is UnAuthenticated) {
                // Showing the sign in form if the user is not authenticated
                return Container(width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF2A94EA),
                  Color(0xFF1649A2),
                  Color(0xFF13AEF5),
                ],
                begin: Alignment.topRight,
                end:Alignment.bottomLeft )
              ),
                  child: Center(
                    
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Container(
                            
                            
                            width: 250,
                            height: 120,
                            decoration: BoxDecoration(
                              
                              color: const Color(0xFFFBFCFC),
                              borderRadius:const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: const Color(0xFFF8F8F9)),
                              // gradient: LinearGradient(colors:[Color(0xFFD755EE),Color(0xFFE2DFDE),Color(0xFF0E85E6)],begin: Alignment.topRight,end: Alignment.bottomLeft),
                              image:const DecorationImage(image: 
                              AssetImage('images/skein_logo.png'),
                              fit: BoxFit.none
                              
                              // AssetImage('images/skein_logo.png'),fit: BoxFit.contain
                              )
                            ),
                           ),
                            const SizedBox(
                              height: 18,
                            ),
                           
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: SignInButton(  
                              Buttons.GoogleDark,
                               onPressed: () {
                                _authenticateWithGoogle(context);
                               },
                               ),
                            ),
                            
                    
                              
                           
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  // void _authenticateWithEmailAndPassword(context) {
  //   if (_formKey.currentState!.validate()) {
  //     BlocProvider.of<AuthBloc>(context).add(
  //       SignInRequested(_emailController.text, _passwordController.text),
  //     );
  //   }
  // }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
