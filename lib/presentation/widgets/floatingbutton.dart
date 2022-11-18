import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../TaskList/task_list.dart';
import 'bottom_navigationbar.dart';

class FActionbutton extends StatelessWidget {
  const FActionbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
                  tooltip: "Task Page",
                  elevation: 20,
                  backgroundColor: Colors.deepPurple,
                  onPressed: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNaviagate(screenindex: 1,),)),
                  child: Icon(Icons.library_add));
  }
}