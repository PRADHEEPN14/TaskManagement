import 'package:bloc_auth/presentation/widgets/floatingbutton.dart';
import 'package:bloc_auth/services/model/datesearch_response.dart';
import 'package:bloc_auth/services/model/userlist_response.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';

import '../../services/model/usertasklist_response.dart';
import '../TaskList/task_list.dart';
import 'package:intl/intl.dart';

import '../widgets/bottom_navigationbar.dart';

class UsertaskListPage extends StatefulWidget {
  int? username_id;
  String? username;
  UsertaskListPage({Key? key, this.username_id,this.username}) : super(key: key);

  @override
  State<UsertaskListPage> createState() => _UsertaskListPageState();
}

class _UsertaskListPageState extends State<UsertaskListPage> {

final user = FirebaseAuth.instance.currentUser!;

  var ctx;
  bool isLoading = true;
  bool dateSearch = false;
  bool typesearch = false;
  var endDate;
  var startDate;
  String? firstDate;
  String? lastDate;
  int? usernameId;
  List userstasklist=[];
  List foundList = [];
  List datefoundList = [];
  List Datefilter = [];
  var _controller = TextEditingController();
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => timentrybyID());
    print(widget.username_id);
    usernameId = widget.username_id;
    print('>>>>>>>>>>>>>>>>>>$usernameId<<<<<<<<<<<<<<<');
    foundList =userstasklist;
    // timentrybyID();
  }
  @override
   Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return UsertaskListpage(newContext);
          })),
    );
  }
  
  
  
  UsertaskListpage(BuildContext newContext) {
    ctx =newContext;
    return  SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
               dateSearch?  
                IconButton(onPressed: (){
                setState(() {
                  datefoundList = userstasklist;
                  dateSearch =false;
                });
                  print("clicked");
                }, icon: Icon(Icons.cancel_outlined)):
                IconButton(onPressed: (){
                 showDaterange(newContext);
                  print("clicked");
                }, icon: Icon(Icons.date_range))
              ],
              title:  Center(child: Text(widget.username!),),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
              shape: const RoundedRectangleBorder(
              borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15.0)))),

            // ......body design base by filters.....//
            body: isLoading
                ? const Center(child: LoadingWidget()
                ): dateSearch ?
                DateFilterListWidget():UsertaskListWidget() ,
                floatingActionButton: FActionbutton()
                //  dateSearch ?  DateListWidget() : TaskListWidget()
                )
              );
  }


  Container UsertaskListWidget() {
  print("-----tasklistWidget------");
    return Container(
        child: userstasklist.length != 0
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
                      suffixIcon: typesearch ? IconButton(icon: Icon(Icons.cancel_outlined),onPressed: (){
                        _controller.clear();
                        setState(() {
                          foundList = userstasklist; 
                          typesearch = false;
                        });
                      },):IconButton(icon: Icon(Icons.person_search_outlined),onPressed: (){}),
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                      itemCount: typesearch ? foundList.length : userstasklist.length ,
                      itemBuilder: ((context, i) {
                        print('lenth of usertasksearchlist data............${userstasklist.length}');
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
  Container DateFilterListWidget() {
  print("-----datefilterlistWidget------");
    return Container(
        child: userstasklist.length != 0
            ? Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10,10,10,0),
                  child: SizedBox(
                    child: TextField(
                      onChanged: ((value) => _datefiltervalue(value)),
                      controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      labelText: "Search",
                      suffixIcon: dateSearch ? IconButton(icon: Icon(Icons.manage_search_sharp),onPressed: (){
                        _controller.clear();
                        setState(() {
                          datefoundList = Datefilter; 
                          dateSearch = false;
                        });
                      },):IconButton(icon: Icon(Icons.cancel),onPressed: (){}),
                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView.builder(
                      itemCount: dateSearch ? datefoundList.length : Datefilter.length,
                      itemBuilder: ((context, i) {
                        print('lenth of usertasksearchlist data............${Datefilter.length}');
                        // Using CARD design...
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
                          child: Carddesign1(i, context),
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


  // search filter function>>>>>>>>>>>>
void _filtervalue(String searchword){
List result =[];
 if(searchword.isEmpty){
result = userstasklist;
print(result);
print("ifff");
 }
 else{
  result = userstasklist.where((element) => element.projectName!.toLowerCase().contains(searchword.toLowerCase())).toList();
  print("elseeee");
  print(result);
 }
 setState(() {
   foundList = result;
   typesearch =true;
 });
}

// search filter function>>>>>>>>>>>>
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


// Date wise filter the list API function code>>>>>>>>>>>>

 filter(){
    final api= Provider.of<ApiService>(ctx!, listen: false);
    print(">>>>>>>>>>>>>>>>>.");
    api.datfilter(firstDate!,lastDate!,usernameId!).then((response){
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


 //<<<<<<<<<<< Get Alluser API function..>>>>>>>>>>>>>>>
  timentrybyID() {
    print(">>>>>>>>>>>username>>>>>>>>>>>>>");

    final api = Provider.of<ApiService>(ctx!, listen: false);
    print(">>>>>>>>>>>username$usernameId>>>>>>>>>>>>>");
    api.usertasklist(widget.username_id).then((response) {
      if (response.status == true) {
        if (mounted) {
          setState(() {
            userstasklist = response.data!;
            // print('-----------$usernameId');
           isLoading = false; 
          });
          showSnackBar(context, "${response.message}");
        }
      } else {
        errshowSnackBar(context, "${response.message}");
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      print(onError.toString());
      showSnackBar(context, "${onError.toString()}");
    });
  }

// >>>>>>>>Time Difference function>>>>>>>>>>
void worktime() {
  
    final startTime = DateTime(2022,11,10,09,50);
    final currentTime = DateTime(2022,11,10,10,50);
  
    final diff_dy = currentTime.difference(startTime).inDays;
    final diff_hr = currentTime.difference(startTime).inHours;
    final diff_mn = currentTime.difference(startTime).inMinutes;
    final diff_sc = currentTime.difference(startTime).inSeconds;
  
    print(diff_dy);
    print(diff_hr);
    print(diff_mn);
    print(diff_sc);
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
                      onTap: () => viewTask(context, i),
                      trailing: SizedBox(width: 80,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4,left: 15),
                              child: Text(typesearch ? '${foundList[i].startedDate}':'${userstasklist[i].startedDate}',style: TextStyle(fontSize: 12),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15,left: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.timer_outlined,size: 13,color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Text(typesearch ? "${foundList[i].workingHours}"+ " hr":"${userstasklist[i].workingHours!}"+ " hr"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   child: Column(
                      //     children: [
                      //       Text(typesearch ? '${foundList![i].StartedDate}':'${userstasklist![i].StartedDate}'),
                      //       Text(typesearch ? '${foundList![i].StartedDate}':'${userstasklist![i].StartedDate}'),
                      //     ],
                      //   ),
                      // ),
                      // // popmenu function//
                      // PopUpMenu(i, context),
                      title: Text(
                        typesearch ? '${foundList[i].taskDescription}':'${userstasklist[i].taskDescription}' ,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                            typesearch ? '${foundList[i].projectName}|| ${foundList[i].taskName}':'${userstasklist[i].projectName}|| ${userstasklist[i].taskName}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12)),
                      ),
                      leading:Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child:Icon(Icons.view_timeline_outlined,size: 25,color: Colors.blue,)
                      // TextButton(
                      //     onPressed: () {
                      //       // view Task details Fuction
                      //       viewTask(context, i);
                      //     },
                      //     child: const Icon(
                      //       Icons.remove_red_eye_sharp,
                      //       color: Colors.deepPurple,
                      //       size: 18,
                      //     )),
                    )),
                  );
  }
// same code but if use for date filter card design >>>>>>>>>>
   Card Carddesign1(int i, BuildContext context) {
    return Card(
                    color: Color(0xFFF3F3F3),
                    elevation: 10,
                    surfaceTintColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shadowColor: Color(0xFF00294B),
                    child: ListTile(
                      onTap: () => viewTaskbyfilter(context, i),
                      trailing: SizedBox(width: 80,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4,left: 15),
                              child: Text(dateSearch ? '${datefoundList[i].startedDate}':'${Datefilter[i].startedDate}',style: TextStyle(fontSize: 12),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15,left: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.timer_outlined,size: 13,color: Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Text(dateSearch ? "${datefoundList[i].workingHours}"+ " hr":"${Datefilter[i].workingHours!}"+ " hr"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // popmenu function//
                      // PopUpMenu(i, context),
                      title: Text(
                        dateSearch ?'${datefoundList[i].taskDescription}':'${Datefilter[i].taskDescription}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                            dateSearch ?'${datefoundList[i].projectName}|| ${datefoundList[i].taskName}':'${Datefilter[i].projectName}|| ${Datefilter[i].taskName}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12)),
                      ),
                      leading: Icon(Icons.av_timer
                      // TextButton(
                      //     onPressed: () {
                      //       // view Task details Fuction
                      //       viewTaskbyfilter(context, i);
                      //     },
                      //     child: const Icon(
                      //       Icons.remove_red_eye_sharp,
                      //       color: Colors.deepPurple,
                      //       size: 18,
                      //     )),
                    ),
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
                            hintText: typesearch ? 'Start Time:  ${foundList[i].startTime}':'Start Time:  ${userstasklist[i].startTime}',
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
                            hintText: typesearch? 'End Time: ${foundList[i].endTime}':'End Time: ${userstasklist[i].endTime}',
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
                              hintText:typesearch ? 'Date:  ${foundList[i].startedDate}':'Date:  ${userstasklist[i].startedDate}',
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
                              hintText:typesearch ? 'Project:   ${foundList[i].projectName}':'Project:   ${userstasklist[i].projectName}',
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
                            hintText:typesearch ? 'Task:  ${foundList[i].taskName}':'Task:  ${userstasklist[i].taskName}',
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
                                typesearch? 'Description:  ${foundList[i].taskDescription}':'Description:  ${userstasklist[i].taskDescription}',
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

  // view the task details when user click the card design>>>>>>>>>>>>
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
                            hintText: dateSearch ? 'Start Time:  ${datefoundList[i].startTime}':'Start Time:  ${Datefilter[i].startTime}',
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
                            hintText: dateSearch? 'End Time: ${datefoundList[i].endTime}':'End Time: ${Datefilter[i].endTime}',
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
                              hintText:dateSearch ? 'Date:  ${datefoundList[i].startedDate}':'Date:  ${Datefilter[i].startedDate}',
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
                              hintText:dateSearch ? 'Project:   ${datefoundList[i].projectName}':'Project:   ${Datefilter[i].projectName}',
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
                            hintText:dateSearch ? 'Task:  ${datefoundList[i].taskName}':'Task:  ${Datefilter[i].taskName}',
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
                                dateSearch? 'Description:  ${datefoundList[i].taskDescription}':'Description:  ${Datefilter[i].taskDescription}',
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



}