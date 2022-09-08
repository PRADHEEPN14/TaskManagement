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
    //    return Scaffold(
    //   backgroundColor: Color(0xff388E3C),
    //   body: SafeArea(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Padding(
    //           padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
    //           child: Text(
    //             message,
    //             style: TextStyle(
    //                 fontSize: 30.0,
    //                 color: Colors.white,
    //                 fontFamily: 'Brush font'),
    //           ),
    //         ),
            
    //       ],
    //     ),
    //   ),
    
    //   drawer: MyDrawer(),
      
    // );
return SafeArea(
  child:   Scaffold(
    appBar: AppBar(
              title:const Center(child:  Text('HomePage')),
              backgroundColor: Colors.redAccent,
              shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0))),
              
            ),
    body:Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          Center(
            child: Container(
              width: 350,
              height: 390,
              decoration:const BoxDecoration(
                
                image:  DecorationImage(image:  AssetImage('images/skein_logo.png'),fit: BoxFit.none) ,
                                    
              )
            ),
          ),
          Center(
            child: Container(
              
              
              decoration: BoxDecoration(
                color: Colors.redAccent,
                
                borderRadius: BorderRadius.circular(20)
              ),
              
              width: 350.0,
              height: 95,
              child: Center(
                child: TextLiquidFill(
                  loadDuration: Duration(seconds: 6),
                  text: ' $message',
                  waveColor: Color(0xFF023183),
                  boxBackgroundColor: Colors.redAccent,
                  textStyle:const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bobbers'
                  ),
                  boxHeight: 85.0,
                  boxWidth: 299,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    drawer: MyDrawer(),
  ),
);
  }
}