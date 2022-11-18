// ignore_for_file: avoid_print

// import 'dart:html';

import 'dart:ffi';

import 'package:bloc_auth/presentation/widgets/drawer.dart';
import 'package:bloc_auth/presentation/widgets/floatingbutton.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

import 'package:bloc_auth/presentation/Home/home_page.dart';
import 'package:bloc_auth/presentation/SearchPage/searchpage.dart';
import 'package:bloc_auth/presentation/Task/task_page.dart';
import 'package:bloc_auth/presentation/widgets/bottom_navigationbar.dart';
import 'package:bloc_auth/services/model/tasklist_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../EditTaskPage/edittask.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  var ctx;
  bool isLoading = true;
  String? Listtask;
//  late int dailyEntryId;

  TextEditingController firstTime = TextEditingController();

  List<Data>? AllTask = [];
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) => alltask());
    super.initState();

    // alltask();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return TaskList(newContext);
          })),
    );
  }

  TaskList(BuildContext newContext) {
    ctx = newContext;
    print('....................${AllTask!.length}');
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              actions: [
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Searchpage(),));
              }, icon:Icon(Icons.search))
              ],
              title: const Center(child: Text('TaskList')),
              backgroundColor: Colors.deepPurple,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15.0))),
            ),
            body: isLoading
                ? const Center(child: LoadingWidget()
                ): TaskListWidget(),
                drawer: MyDrawer(),
                floatingActionButton: FActionbutton()
                )
              );
  }
 String dateFormatter = 'MMM, dd, y';


// ListViewBuilder Code Here>>>>>>>
  Container TaskListWidget(){
    return Container(
        child: AllTask!.length != 0
            ? ListView.builder(
                itemCount: AllTask!.length,
                itemBuilder: ((context, i) {
                  print('lenth of data............${AllTask!.length}');
                  // Using CARD design...
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
                    child: Column(
                      children: [
                        // Text(date.formatDate(),style:TextStyle(fontSize:20,backgroundColor:Colors.blue,fontWeight:FontWeight.bold)),
                        Carddesign(i, context),
                      ],
                    ),
                  );
              //     bool isSameDate = true;
              // var dateString = AllTask![i].startedDate!;
              // var parsetime = DateTime.parse(dateString);
              // print(dateString);
              //  String formatdate = DateFormat('yyyy-MM-dd').format(parsetime);
              // final DateTime date = DateTime.parse(formatdate) ;
              // final item = AllTask![i];
              // if (i == 0) {
              //   isSameDate = false;
              // } else {
              //   final String prevDateString = AllTask![i - 1].startedDate!;
              //   var parsetime1 = DateTime.parse(prevDateString);
              //   String formatdate1 = DateFormat('yyyy-MM-dd').format(parsetime1);
              //   final DateTime prevDate = DateTime.parse(formatdate1);
              //   isSameDate = date.isSameDate(prevDate);
              // }
              // if (i == 0 || !(isSameDate)) {
              //   return Column(children: [
              //     Text(date.formatDate()),
              //     ListTile(title: Text('item $i'))
              //   ]);
              // } else {
              //   return ListTile(title: Text('item $i'));
              // }
                }
                )
                )
            : Center(
                child: Showmessage(),
              ));
  }


// TaskList Card Design>>>>>>>
  Card Carddesign(int i, BuildContext context) {
    return Card(
                    color: Color(0xFFF3F3F3),
                    elevation: 10,
                    surfaceTintColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shadowColor: Color(0xFF00294B),
                    child: ListTile(
                      onTap: () => viewTask(context, i),
                      trailing: 
                      // popmenu function//
                      PopUpMenu(i, context),
                      title: Text(
                        '${AllTask![i].taskDescription}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                            '${AllTask![i].projectName}|| ${AllTask![i].taskName}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12)),
                      ),
                      leading: Icon(Icons.playlist_add_check_circle_outlined,size: 30,color: Colors.black45,)
                    ),
                  );
  }




// PopUpMenu Button code with function>>>>>>>
  PopupMenuButton<int> PopUpMenu(int i, BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.only(left: 25),
                        onSelected: (value) async {
                          if (value == 1) {
                            await edittask(
                              AllTask![i].dailyEntryId!,
                              AllTask![i].startTime,
                              AllTask![i].endTime,
                              AllTask![i].startedDate,
                              AllTask![i].clockifyProjectId,
                              AllTask![i].clockifyTaskId,
                              AllTask![i].taskDescription,
                            );
                          } else if (value == 2) {
                            deleteTask(context, i);
                          }
                        },
                        itemBuilder: (context) => [
                              const PopupMenuItem(
                                child: Text("Edit"),
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Delete"),
                                value: 2,
                              ),
                            ]);
  }

// Delete Dialogbox code...... 
  Future<dynamic> deleteTask(BuildContext context, int i) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              content: const Text("Are you sure want to Delete",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              actions: [
                TextButton(
                    onPressed: () {
                      deletetask(AllTask![i].dailyEntryId!);
                      setState(() {
                        alltask();
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(fontSize: 15),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(fontSize: 15),
                    )),
              ],
            ));
  }

// View Task from Tasklist
  Future<dynamic> viewTask(BuildContext context, int i) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.all(10),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: SingleChildScrollView(
                child: Container(
                  width: 500,
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                            height: 25,
                            child: Center(
                              child: Text(
                                "Task Details",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText: 'Start Time:  ${AllTask![i].startTime}',
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText: 'End Time:  ${AllTask![i].endTime}',
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        TextField(
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              hintText: 'Date:  ${AllTask![i].startedDate}',
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            enabled: false),
                        SizedBox(height: 10),
                        TextField(
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(),
                              hintText: 'Project:   ${AllTask![i].projectName}',
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            enabled: false),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText: 'Task:  ${AllTask![i].taskName}',
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          enabled: false,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(),
                            hintText:
                                'Description:  ${AllTask![i].taskDescription}',
                            hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                            hintMaxLines: 5,
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

//<<<<<<<<<<< send the data from this file to Edit Page function here..>>>>>>>>>>>>>>>
  edittask(int dailyTimeId, startTime, endtime, startdate, projectlist,tasklist, taskdecript) {
    Navigator.of(context).push(PageTransition(
        child: EditTaskPage(
          dailyTimeId: dailyTimeId,
          startTime: startTime,
          endTime: endtime,
          startedDate: startdate,
          projectlist: projectlist,
          taskList: tasklist,
          taskdescript: taskdecript,
        ),
        type: PageTransitionType.scale,
        duration: Duration(seconds: 2),
        childCurrent: this.widget,
        alignment: Alignment.bottomRight));
  }

//<<<<<<<<<<< End here..>>>>>>>>>>>>>>>

//<<<<<<<<<<< Get AllTask API function..>>>>>>>>>>>>>>>
  alltask() {
    print(">>>>>>>>>>>>>>>>>>>>>>>>");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.alltask().then((response) {
      if (response.status == true) {
        if (mounted) {
          setState(() {
            AllTask = response.data!;
            print('-----------$AllTask');
            isLoading = false;
          });
        }
      } else {
        errshowSnackBar(context, "${response.message}");
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
    });
  }

  //<<<<<<<<<<< End here..>>>>>>>>>>>>>>>

  //<<<<<<<<<<< DELETE Task API function..>>>>>>>>>>>>>>>

  void deletetask(int dailyEntryId) {
    var api = Provider.of<ApiService>(ctx!, listen: false);
    //  print('update id1-'$dailyEntryId);
    api.deletetask(dailyEntryId).then((response) {
      if (response.status == true) {
        showSnackBar(context, "${response.message}");
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomNaviagate(screenindex: 0,),));
      } else {
        print("...deleted1111..."); 
        errshowSnackBar(context, "${response.message}");
      }

    });
    print('delete id--$dailyEntryId');
  }

//<<<<<<<<<<< Snackbar style ..>>>>>>>>>>>>>>>
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
    void errshowSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// Show message on no data found after API Call..
  AlertDialog Showmessage() {
    return AlertDialog(
      elevation: 10,
      contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 1),
      content: const Text(
        "No Data List Found",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
      actionsPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(PageTransition(
                  child: BottomNaviagate(screenindex: 1),
                  type: PageTransitionType.leftToRightWithFade,
                  duration: Duration(seconds: 1),
                  alignment: Alignment.topCenter,
                  childCurrent: this.widget));
            },
            child: const Text(
              "OK",
              style: TextStyle(fontSize: 15, color: Colors.red),
            ))
      ],
    );
  }
}

extension DateHelper on DateTime {
  
   String formatDate() {
     String? dateFormatter;
     final formatter = DateFormat(dateFormatter);
      return formatter.format(this);
  }
  bool isSameDate(DateTime other) {
    return this.day == other.day &&
    this.month == other.month &&
    this.year == other.year ;
        
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
// Loading Widget class>>>>>>>
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 33,
      child:
          LoadingIndicator(
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
    );
  }
}
