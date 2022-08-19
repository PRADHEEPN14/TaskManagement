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
        // appBar: AppBar(
        //   title: Center(child: const Text("SignIn")),
        // ),
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
                decoration: BoxDecoration(
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
                              
                              color: Color(0xFFFBFCFC),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: Color(0xFFF8F8F9)),
                              // gradient: LinearGradient(colors:[Color(0xFFD755EE),Color(0xFFE2DFDE),Color(0xFF0E85E6)],begin: Alignment.topRight,end: Alignment.bottomLeft),
                              image: DecorationImage(image: 
                              AssetImage('images/skein_logo.png'),
                              fit: BoxFit.none
                              
                              // AssetImage('images/skein_logo.png'),fit: BoxFit.contain
                              )
                            ),
                           ),
                            const SizedBox(
                              height: 18,
                            ),
                            // Center(
                            //   child: Form(
                            //     key: _formKey,
                            //     child: Column(
                            //       children: [
                            //         TextFormField(
                            //           keyboardType: TextInputType.emailAddress,
                            //           controller: _emailController,
                            //           decoration: const InputDecoration(
                            //             hintText: "Email",
                            //             border: OutlineInputBorder(),
                            //           ),
                            //           autovalidateMode:
                            //               AutovalidateMode.onUserInteraction,
                            //           validator: (value) {
                            //             return value != null &&
                            //                     !EmailValidator.validate(value)
                            //                 ? 'Enter a valid email'
                            //                 : null;
                            //           },
                            //         ),
                            //         const SizedBox(
                            //           height: 10,
                            //         ),
                            //         TextFormField(
                            //           keyboardType: TextInputType.text,
                            //           controller: _passwordController,
                            //           decoration: const InputDecoration(
                            //             hintText: "Password",
                            //             border: OutlineInputBorder(),
                            //           ),
                            //           autovalidateMode:
                            //               AutovalidateMode.onUserInteraction,
                            //           validator: (value) {
                            //             return value != null && value.length < 6
                            //                 ? "Enter min. 6 characters"
                            //                 : null;
                            //           },
                            //         ),
                            //         const SizedBox(
                            //           height: 12,
                            //         ),
                            //         SizedBox(
                            //           width:
                            //               MediaQuery.of(context).size.width * 0.7,
                            //           child: ElevatedButton(
                            //             onPressed: () {
                            //               _authenticateWithEmailAndPassword(
                            //                   context);
                            //             },
                            //             child: const Text('Sign In'),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: SignInButton(  
                              Buttons.GoogleDark,
                               onPressed: () {
                                _authenticateWithGoogle(context);
                               },
                               ),
                            ),
                            
                    
                              
                            // IconButton(
                            //   onPressed: () {
                            //    _authenticateWithGoogle(context); 
                            //   },
                            //   icon: Image.network(
                            //     "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
                            //     height: 30,
                            //     width: 30,
                            //   ),
                            // ),
                            // const Text("Don't have an account?"),
                            // OutlinedButton(
                            //   onPressed: () {
                            //     Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => const SignUp()),
                            //     );
                            //   },
                            //   child: const Text("Sign Up"),
                            // )
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

  void _authenticateWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignInRequested(_emailController.text, _passwordController.text),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(
      GoogleSignInRequested(),
    );
  }
}
