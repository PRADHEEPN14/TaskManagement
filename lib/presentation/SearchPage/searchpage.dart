import 'package:bloc_auth/main.dart';
import 'package:bloc_auth/presentation/widgets/floatingbutton.dart';
import 'package:bloc_auth/services/model/datesearch_response.dart';
import 'package:bloc_auth/services/model/tasklist_response.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_transition/page_transition.dart';

import '../../preference_helper.dart';
import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../EditTaskPage/edittask.dart';
import '../TaskList/task_list.dart';
import '../widgets/bottom_navigationbar.dart';
// import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {


  var ctx;
  bool isLoading = true;
  bool typeSearch= false;
  String? Listtask;
  TextEditingController firstTime = TextEditingController();
  List AllTask = [];
  List foundList = [];
  List datefoundList = [];
  List Datefilter = [];
  bool dateSearch = false;
  var endDate;
  var startDate;
  String? firstDate;
  String? lastDate;
  int? userId;
  var _controller = TextEditingController();


// <<<<<<<<< GetuserId from LoginPage function here...>>>>>>>>
  getUserId() async {
    userId = await PreferenceHelper.getUserId();

    print("useridsearchpage--$userId");
  }
// <<<<<<<<< End here...>>>>>>>>>>

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => alltask());
    foundList =AllTask;
    getUserId();
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return Searchpage(newContext);
          })),
    );
  }
    Searchpage(BuildContext newContext) {
    ctx = newContext;
    print('....................${AllTask.length}');
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
               dateSearch?  
                IconButton(onPressed: (){
                setState(() {
                  datefoundList = AllTask;
                  dateSearch = false;
                });
                  print("clicked");
                }, icon: Icon(Icons.cancel_outlined)):
                IconButton(onPressed: (){
                 showDaterange(newContext);
                  print("clicked");
                }, icon: Icon(Icons.date_range))

              ],
              title: const Center(child: Text('Search List'),),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
              shape: const RoundedRectangleBorder(
              borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15.0)))),

            // ......body design base by filters.....//
            body: isLoading
                ? const Center(child: LoadingWidget()
                )
                : dateSearch ?  DateListWidget() : TaskListWidget(),
                floatingActionButton: FActionbutton()
                )
              );
              // : Container();
  }



// date range picker function....
showDaterange(newContext){
    showCustomDateRangePicker(
            newContext,
            dismissible: true,
            minimumDate: DateTime(2022),
            maximumDate: DateTime.now().add(const Duration(days: 30)),
            endDate: endDate,
            startDate: startDate,
            onApplyClick: (start, end) async{
              setState(() {
                endDate = end;
                startDate = start; 
                String formattedDate =DateFormat('yyyy-MM-dd').format(endDate);
                String formattedDate1 =DateFormat('yyyy-MM-dd').format(startDate);
                firstDate = formattedDate1;
                lastDate = formattedDate;
                print(formattedDate1);
                print(formattedDate);
                dateSearch = true;
              });
              filter();
            //  usernames();
            },
            onCancelClick: () {
              setState(() {
                endDate = null;
                startDate = null;
              });
            },
          );

}

// List the all task from User>>>>>>>>
Container TaskListWidget() {
  print("-----tasklistWidget------");
    return Container(
        child: AllTask.length != 0
            ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10,10,10,0),
                  child: SizedBox(
                    child: TextField(
                      onChanged: ((value) => _filtervalue(value)),
                      controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Search",
                      suffixIcon:typeSearch ? IconButton(icon: Icon(Icons.cancel_outlined),onPressed: (){
                        _controller.clear();
                        setState((){
                          foundList =AllTask;
                          typeSearch =false;
                        });
                      },):IconButton(icon: Icon(Icons.content_paste_search_rounded),onPressed: (){
                        // _controller.clear();
                        // setState((){
                        //   foundList =AllTask;
                        // });
                      },),
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                      itemCount: typeSearch? foundList.length : AllTask.length,
                      itemBuilder: ((context, i) {
                        print('lenth of searchlist data............${foundList.length}');
                        // Using CARD design...
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
                          child: Carddesign(i, context),
                        );
                      }))
                ),
              ],
            )
            : Center(
                child: Showmessage(),
              )
              );
  }

// date filter function and datefilter list widget code here>>>>>>>>>>>
  Container DateListWidget() {
    print("------datelist------");
    return Container(
        child: Datefilter.length !=0 
            ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10,10,10,0),
                  child: SizedBox(
                    child: TextField(
                      controller: _controller,
                      onChanged: ((value) => _datefiltervalue(value)),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Search",
                      suffixIcon:dateSearch ? IconButton(icon: Icon(Icons.cancel_outlined),onPressed: (){
                        _controller.clear();
                        setState((){
                          datefoundList = Datefilter;
                          dateSearch =false;
                        });
                      },):IconButton(icon: Icon(Icons.timer_outlined),onPressed: (){}),
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                      itemCount:  datefoundList.length,
                      itemBuilder: ((context, i) {
                        print('lenth of datefilter data............${datefoundList.length}');
                        // Using CARD design...
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
                          child: DatefiltercardDisign(i, context),
                        );
                      }))
                ),
              ],
            ):Center(child: Showmessage(),
              ));
  }


// list view card design widget code>>>>>>>>>>>>>>>>>>

    Card Carddesign(int i, BuildContext context) {
    return Card(
                    color: Color(0xFFF3F3F3),
                    elevation: 10,
                    surfaceTintColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shadowColor: Color(0xFF00294B),
                    child: ListTile(
                      onTap: () => viewTaskbyfilter(context, i),
                      trailing: 
                      // popmenu function//
                      PopUpMenu(i, context),
                      title: Text(
                        typeSearch ? '${foundList[i].taskDescription}':'${AllTask[i].taskDescription}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                            typeSearch ? '${foundList[i].projectName}|| ${foundList[i].taskName}':'${AllTask[i].projectName}|| ${AllTask[i].taskName}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12)),
                      ),
                      leading: Icon(Icons.playlist_add_check_circle_outlined,size: 30,color: Colors.black45,)
                    ),
                  );
  }

// same code but if use for date filter card design >>>>>>>>>>
   Card DatefiltercardDisign(int i, BuildContext context) {
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
                        '${datefoundList[i].taskDescription}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          '${datefoundList[i].projectName}|| ${datefoundList[i].taskName}',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12)),
                      leading: TextButton(
                          onPressed: () {
                            // view Task details Fuction
                            // viewTask(context, i);
                          },
                          child: const Icon(Icons.history_toggle_off_outlined,size: 30,color: Colors.black45,)),
                    ),
                  );
  }



  // PopUpMenu Button code with function>>>>>>>
  PopupMenuButton<int> PopUpMenu(int i, BuildContext context) {
    return PopupMenuButton(
      splashRadius: 25,
      padding: EdgeInsets.only(left: 29),
                        onSelected: (value) async {
                          if (value == 1) {
                            await edittask(
                              AllTask[i].dailyEntryId!,
                              AllTask[i].startTime,
                              AllTask[i].endTime,
                              AllTask[i].startedDate,
                              AllTask[i].clockifyProjectId,
                              AllTask[i].clockifyTaskId,
                              AllTask[i].taskDescription,
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
// ......-Designs coding End Here-.....//


//typing search filter function>>>>>>>>>>>>
void _filtervalue(String searchword){
List result =[];
 if(searchword.isEmpty){
result = AllTask;
print(result);
print("ifff");
 }
 else{
  result = AllTask.where((element) => element.projectName!.toLowerCase().contains(searchword.toLowerCase())).toList();
  print("elseeee");
  print(result);
 }
 setState(() {
   foundList = result;
   typeSearch =true;
 });
}

//date search filter function>>>>>>>>>>>>
void _datefiltervalue(String searchword){
List results =[];
 if(searchword.isEmpty){
results = Datefilter;
print(results);
print("ifff");
 }
 else{
  results = Datefilter.where((element) => element.projectName!.toLowerCase().contains(searchword.toLowerCase())).toList();
  print("elseeee");
  print(results);
 }
 setState(() {
   datefoundList = results;
   dateSearch =true;
 });
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
                      deletetask(AllTask[i].dailyEntryId!);
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

  // view the task details when user click the card design>>>>>>>>>>>>
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
                            hintText: dateSearch ? 'Start Time:  ${datefoundList[i].startTime}' : 'Start Time:  ${AllTask[i].startTime}',
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
                            hintText: dateSearch ? 'End Time:  ${datefoundList[i].endTime}' :'End Time:  ${AllTask[i].endTime}',
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
                              hintText: dateSearch ? 'Date:  ${datefoundList[i].startedDate}': 'Date:  ${AllTask[i].startedDate}',
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
                              hintText: dateSearch ? 'Project:   ${datefoundList[i].projectName}':'Project:   ${AllTask[i].projectName}',
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
                            hintText: dateSearch ? 'Task:  ${datefoundList[i].taskName}':'Task:  ${AllTask[i].taskName}',
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
                                dateSearch ? 'Description:  ${datefoundList[i].taskDescription}': 'Description:  ${AllTask[i].taskDescription}',
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
// view the task details in datefilter when user click the card design>>>>>>>>>>>>
  Future<dynamic> viewTaskbyfilter(BuildContext context, int i) {
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
                            hintText: typeSearch ? 'Start Time:  ${foundList[i].startTime}' : 'Start Time:  ${AllTask[i].startTime}',
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
                            hintText: typeSearch ? 'End Time:  ${foundList[i].endTime}' :'End Time:  ${AllTask[i].endTime}',
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
                              hintText: typeSearch ? 'Date:  ${foundList[i].startedDate}': 'Date:  ${AllTask[i].startedDate}',
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
                              hintText: typeSearch ? 'Project:   ${foundList[i].projectName}':'Project:   ${AllTask[i].projectName}',
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
                            hintText: typeSearch ? 'Task:  ${foundList[i].taskName}':'Task:  ${AllTask[i].taskName}',
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
                                typeSearch ? 'Description:  ${foundList[i].taskDescription}': 'Description:  ${AllTask[i].taskDescription}',
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
  // err message code >>>>>>>>>>>>>
    void errshowSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 3),
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
        
        
        // *********Api functions********//

  //<<<<<<<<<<< DELETE Task API function..>>>>>>>>>>>//

  void deletetask(int dailyEntryId) {
    var api = Provider.of<ApiService>(ctx!, listen: false);
    //  print('update id1-'$dailyEntryId);
    api.deletetask(dailyEntryId).then((response) {
      if (response.status == true) {
        showSnackBar(context, "${response.message}");
         Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomNaviagate(screenindex: 2,),));
        setState(() {
          alltask();
        });
      } else {
        errshowSnackBar(context, "${response.message}");
      }
    });
    print('delete id--$dailyEntryId');
  }


// Date wise filter the list API function code>>>>>>>>>>>>

 filter(){
    final api= Provider.of<ApiService>(ctx!, listen: false);
    print(">>>>>>>>>>>>>>>>>.");
    api.datfilter(firstDate!,lastDate!,userId!).then((response){
      print(">>>>:$response");
      if(response.status == true){
        setState(() {
          Datefilter =response.data!;
          datefoundList = Datefilter;
          //dateSearch = true;
        });
        print(datefoundList);
        print(Datefilter.runtimeType);
        print(response.data!.length);
        
        showSnackBar(context, "${response.message}");

      }else{
        errshowSnackBar(context, "${response.message}");
        setState(() {
           dateSearch = false;
        });
      }
      
    });
}


//<<<<<<<<<<< Get Alluser API function..>>>>>>>>>>>>>>>
  usernames() {
    print(">>>>>>>>>>>username>>>>>>>>>>>>>");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.userlistdetail().then((response) {
      if (response.status == true) {
        if (mounted) {
          setState(() {
            // AllTask = response.data!;
            // print('-----------$AllTask');
            // isLoading = false;
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

//<<<<<<<<<<< Get Allusername API function..>>>>>>>>>>>>>>>
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

  
}