import 'dart:ui';

import 'package:bloc_auth/presentation/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

// BG-color for text:...
static const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];
// animation text size...
static const colorizeTextStyle = TextStyle(
  fontSize: 25.0,
  fontFamily: 'Horizon',
  fontWeight: FontWeight.bold
);


  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
//  <<<<<< welcome notes Function here...>>>>>>>

    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));
    var message = '';

    if (timeNow <= 12) {
      message = '${user.displayName}';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      message = 'Good Afernoon ${user.displayName}';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      message = 'Good Evening ${user.displayName}';
    } else {
      message = 'Good Night ${user.displayName}';
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Center(child: Text('HomePage')),
            backgroundColor: Colors.deepPurple,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(15.0)))),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Padding(
                padding: const EdgeInsets.only(top: 290),
                child: Container(
                    width: 150,
                    height: 100,
                      decoration: const BoxDecoration(
                      
                      image: DecorationImage(
                          image: AssetImage('images/skein_logo.png'),
                          fit: BoxFit.contain),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Container(
                    width: 350.0,
                    height: 95,
                    decoration: BoxDecoration(
                      
                                borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  
                                child:AnimatedTextKit(
                                    animatedTexts: [
                                       
                                    ColorizeAnimatedText(
                                      'HI!!',
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                    ColorizeAnimatedText(
                                      '$message',
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                    ColorizeAnimatedText(
                                      'Please Update Your Task!!!',
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                     ColorizeAnimatedText(
                                      'Go to Task Page',
                                      textStyle: colorizeTextStyle,
                                      colors: colorizeColors,
                                    ),
                                  ],
                                  isRepeatingAnimation: true,
                             )
                                                            
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: MyDrawer(), // drawer widget user here...
      ),
    );
  }
}
