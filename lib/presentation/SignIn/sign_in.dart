import 'dart:ui';

import 'package:bloc_auth/bloc/auth/auth_bloc.dart';
// import 'package:bloc_auth/bloc/bloc/auth_bloc.dart';
import 'package:bloc_auth/presentation/Dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../services/Apiservices/ApiService.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
// final user = FirebaseAuth.instance.currentUser!;
  var ctx;
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
    return Provider<ApiService>(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(
            builder: (BuildContext newContext) {
              return SignIn(newContext);
            },
          ),
        ));
  }

  SignIn(BuildContext context) {
    ctx = context;
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          }
          if (state is AuthError) {
            // Showing the error message if the user has entered invalid credentials //state.error//
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Something went wrong try Again..')));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Loading) {
              // Showing the loading indicator while the user is signing in
              return const Center(
                  child:SizedBox(
                    width: 65,
                    height: 40,
                    child: LoadingIndicator(
                    indicatorType: Indicator.lineScalePulseOutRapid,
                    colors: [
                      Colors.yellow,
                      Colors.black,
                      Colors.blue,
                      Colors.deepPurple,
                      Colors.pink
                    ],
                    strokeWidth: 10,
                    pathBackgroundColor: Color.fromARGB(255, 251, 2, 2)),
              ));
            }
            if (state is UnAuthenticated) {
              // Showing the sign in form if the user is not authenticated
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xFF2A94EA),
                  Color(0xFF1649A2),
                  Color(0xFF13AEF5),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                border:
                                    Border.all(color: const Color(0xFFF8F8F9)),
                                image: const DecorationImage(
                                    image: AssetImage('images/skein_logo.png'),
                                    fit: BoxFit.none
                                    )),
                          ),
                          const SizedBox(height: 18),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: SignInButton(
                              Buttons.GoogleDark,
                              onPressed: () {
                                // google signin function..
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
      GoogleSignInRequested(context!),
    );
  }

}
