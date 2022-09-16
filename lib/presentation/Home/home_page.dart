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
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
//  <<<<<< welcome notes Function here...>>>>>>>

    DateTime now = DateTime.now();
    var timeNow = int.parse(DateFormat('kk').format(now));
    var message = '';

    if (timeNow <= 12) {
      message = 'Good Morning ${user.displayName} Please update Your Task';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      message = 'Good Afernoon ${user.displayName} Please update Your Task';
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Center(
                  child: Container(
                      width: 350,
                      height: 390,
                        decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/skein_logo.png'),
                            fit: BoxFit.none),
                      )),
                ),
                Center(
                  child: Container(
                    width: 350.0,
                    height: 95,
                    decoration: BoxDecoration(
                                // color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                child: TextLiquidFill(
                                  boxHeight: 95.0,
                                  boxWidth: 299,
                                  loadDuration: const Duration(seconds: 6),
                                  text: ' $message',
                                  waveColor: const Color(0xFF023183),
                                  boxBackgroundColor: Colors.redAccent,
                                  textStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Bobbers'),
                                  
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: MyDrawer(), // drawer widget user here...
      ),
    );
  }
}
