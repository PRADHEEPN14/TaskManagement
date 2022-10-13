// ignore_for_file: avoid_print

// import 'dart:html';

import 'package:bloc_auth/presentation/Home/home_page.dart';
import 'package:bloc_auth/presentation/Task/task_page.dart';
import 'package:bloc_auth/presentation/widgets/bottom_navigationbar.dart';
import 'package:bloc_auth/services/model/tasklist_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

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

TextEditingController firstTime =   TextEditingController();

  List<Data>? AllTask =[];
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
                title: const Center(child: Text('TaskList')),
                backgroundColor: Colors.deepPurple,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15.0))),
                        ),
              body:isLoading ? const Center(
              child: SizedBox(
              width: 60,
              height: 33,
              child:
              //  Text('No Task data found',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
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
            )
            ): Container(
              child: AllTask!.length !=0 ? 
              ListView.builder(
                    itemCount: AllTask!.length,
                    itemBuilder: ((context, i) {
                      print('lenth of data............${AllTask!.length}');
                      // Using CARD design...
                      return Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 3),
                        child: Card(
                          color: Color(0xFFF3F3F3),
                          elevation: 10,
                          surfaceTintColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: Color(0xFF00294B),
                          child: ListTile(
                            trailing: PopupMenuButton(
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
                                    // setState(() {
                                    //   alltask();
                                    // });
                                  } else if (value == 2) {
                                       showDialog(
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
                                      child: const Text("Yes",style: TextStyle(fontSize: 15),
                                      )
                                      ),
                                      TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("No",style: TextStyle(fontSize: 15),
                                      )
                                      ),
                                ],
                              ));
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
                                    ]),
                            // trailing: IconButton(onPressed: (){},
                            // icon: Icon(Icons.more_vert)),
                            title: Text(
                              '${AllTask![i].taskDescription}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${AllTask![i].projectName}|| ${AllTask![i].taskName}',
                                style: const TextStyle(color: Colors.black,
                                    fontSize: 12)),
                                    leading: TextButton(onPressed: (){
                                      
                                  showDialog(context: context, builder: (BuildContext context){
                                  return   Dialog(
                                    insetPadding: EdgeInsets.all(10),
                                    backgroundColor: Colors.white,
                                    
                                    shape: RoundedRectangleBorder(
                                          borderRadius:BorderRadius.circular(15.0)),
                                    child:Padding(
                                      padding: const EdgeInsets.all(21.0),
                                      child: SingleChildScrollView(
                                        child: Container(
                                          width: 500,height:400,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 25,
                                                  child: Center(
                                                    child: Text("Task Details",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
                                                  )
                                                ),
                                                SizedBox(height: 10),
                                                 TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Start Time:  ${AllTask![i].startTime}',
                                                    hintStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                                                    ),
                                                    enabled: false,
                                                    ),
                                            SizedBox(height: 10),
                                            TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'End Time:  ${AllTask![i].endTime}',
                                                    hintStyle:TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                                                    ),
                                                    enabled: false,),
                                            SizedBox(height: 10),
                                            TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Date:  ${AllTask![i].startedDate}',
                                                    hintStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                                                    ),
                                                    enabled: false),
                                            SizedBox(height: 10),
                                            TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Project:   ${AllTask![i].projectName}',
                                                    hintStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                                                    ),
                                                    enabled: false),
                                                                             SizedBox(height: 10),
                                            TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Task:  ${AllTask![i].taskName}',
                                                    hintStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                                                    ),
                                                    enabled: false,),
                                            SizedBox(height: 10),
                                            TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Description:  ${AllTask![i].taskDescription}',
                                                    hintStyle: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
                                                    hintMaxLines: 5,
                                                    enabled: false,),
                                                  ),
                                                             
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    );
                                });
                                  },
                             child:const Icon(Icons.remove_red_eye_sharp,
                             color: Colors.deepPurple,
                             size: 18,)),
                          ),
                        ),
                      );
                    })):Center(
                      child: AlertDialog(
                          content: const Text("No Data List Found",
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                                  actions: [
                                  TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNaviagate(screenindex: 1),));
                                  },
                                  child: const Text("OK",style: TextStyle(fontSize: 15,color: Colors.red),
                            )
                          )
                        ],
                          
                      ),
                    // child: Text('No Data Found',style: TextStyle(fontSize: 20,color: Colors.red,fontFamily: 'TimesNewRoman'),)
                     )
            )
            // :Center(
            //         child: Text('nodata found'),
            //       )
              // drawer: MyDrawer(),
            )
            
    );
  }

//<<<<<<<<<<< send the data from this file to Edit Page function here..>>>>>>>>>>>>>>>
  edittask(int dailyTimeId, startTime, endtime, startdate, projectlist,
      tasklist, taskdecript) {
    print('cdcdcd$AllTask');
    print("kndvfv--$dailyTimeId");
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditTaskPage(
              dailyTimeId: dailyTimeId,
              startTime: startTime,
              endTime: endtime,
              startedDate: startdate,
              projectlist: projectlist,
              taskList: tasklist,
              taskdescript: taskdecript,
            )));
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
        showSnackBar(context, "${response.message}");
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
         
        setState(() {
         alltask();
        });
      } else {
        showSnackBar(context, "${response.message}");
      }
    });
    print('delete id--$dailyEntryId');
  }
//<<<<<<<<<<< Snackbar style ..>>>>>>>>>>>>>>>
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
}
