// ignore_for_file: avoid_print

import 'package:bloc_auth/presentation/Home/home_page.dart';
import 'package:bloc_auth/presentation/Task/task_page.dart';
import 'package:bloc_auth/services/model/tasklist_response.dart';
import 'package:flutter/material.dart';

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
//  late int dailyEntryId;

  List<Data>? AllTask;
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
    return SafeArea(
      child: isLoading
          ? const Center(
              child: SizedBox(
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
            ))
          : Scaffold(
              appBar: AppBar(
                title: const Center(child: Text('TaskList')),
                backgroundColor: Colors.deepPurple,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15.0))),
              ),
              body: ListView.builder(
                  itemCount: AllTask!.length,
                  itemBuilder: ((context, i) {
                    // Using CARD design...
                    return Card(
                      elevation: 3,
                      surfaceTintColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      shadowColor: Color.fromARGB(255, 122, 168, 206),
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
                                deletetask(AllTask![i].dailyEntryId!);
                                 setState(() {
                              alltask();
                              }); 
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
                        subtitle: Text('${AllTask![i].createdAt}',
                            style: const TextStyle(color: Color.fromARGB(255,139,139,138,),
                                fontSize: 13)),
                                leading: TextButton(onPressed: (){
                                  
                              showDialog(context: context, builder: (BuildContext context){
                              return   Dialog(
                                
                                shape: RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(20.0)),
                                child:Center(
                                  child: Column(
                                    children: const [
                                      Text('data'),
                                      Text('data'),
                                      Text('data'),
                                      Text('data'),
                                      Text('data'),
                                      Text('data'),
                                      Text('data'),
                                
                                    ],
                                  ),
                                ),
                                );
                            });
                              },
                         child:const Icon(Icons.remove_red_eye_sharp,
                         color: Colors.purple,)),
                      ),
                    );
                  })),
              // drawer: MyDrawer(),
            ),
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
        print('unmount');

        if (mounted) {
          print('not mount');
          setState(() {
            AllTask = response.data!;
            isLoading = false;
          });
        }
      } else {
        showSnackBar(context, "${response.message}");
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
         alltask();
        setState(() {
         
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
