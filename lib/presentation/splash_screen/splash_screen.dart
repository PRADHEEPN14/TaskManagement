import 'dart:async';

import 'package:bloc_auth/presentation/SignIn/sign_in.dart';
import 'package:flutter/material.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}


class _SplashscreenState extends State<Splashscreen> {

@override
void initState(){
  super.initState();
  Future.delayed(Duration (seconds: 6),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));

  });
    

  
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
         decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF0360AC),
                  Color(0xFF2370F5),
                  Color(0xFF03A7F3),
                ],
                begin: Alignment.topRight,
                end:Alignment.bottomLeft )
              ),
        child: Center(
          child: Column(
            children: [
              Center(
                child: Image.asset('images/skein_logo.png',height: 500,width: 500,color: Color(0xFFFAF9F9)),
                
                
                ),
              CircularProgressIndicator(
                backgroundColor: Colors.blueGrey,
                color: Color(0xFF020D78),
                semanticsLabel: "Welcome",
              ),
            ],
          ),
        ),
      ),
    );
  }
}