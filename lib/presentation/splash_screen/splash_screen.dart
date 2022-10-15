import 'dart:async';
import 'dart:math';

import 'package:bloc_auth/presentation/SignIn/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
      setState(() {
        Future.delayed(const Duration(seconds: 4), () {
          if(mounted){
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignIn(),
              ));
            }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFF0360AC),
          Color(0xFF2370F5),
          Color(0xFF03A7F3),
        ], 
        begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: Center(
          child: Column(
            children: [
              Center(
                child: Image.asset('images/skein_logo.png',
                    height: 500, width: 500, color: const Color(0xFFFAF9F9)),
              ),
              const SizedBox(
                width: 65,
                height: 60,
                child: LoadingIndicator(//loading design ...
                    indicatorType: Indicator.ballSpinFadeLoader,
                    colors: [
                      Colors.white, 
                    ],
                    strokeWidth: 10,
                    pathBackgroundColor: Color.fromARGB(255, 251, 2, 2)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
