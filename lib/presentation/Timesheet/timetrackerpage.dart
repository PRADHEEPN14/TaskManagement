import 'package:bloc_auth/presentation/UsertaskList.dart/usertasklist.dart';
import 'package:bloc_auth/presentation/widgets/floatingbutton.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../preference_helper.dart';
import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';

import '../../services/model/datesearch_response.dart';
import '../../services/model/userlist_response.dart';
import '../TaskList/task_list.dart';
import '../widgets/bottom_navigationbar.dart';
import 'package:intl/intl.dart';

class Timetracker extends StatefulWidget {
  const Timetracker({Key? key}) : super(key: key);

  @override
  State<Timetracker> createState() => _TimetrackerState();
}

class _TimetrackerState extends State<Timetracker> {

 var ctx;
bool isLoading = true;
  List Allusers= [];
  List foundList = [];
  List datefoundList = [];
  List Datefilter = [];
  bool dateSearch = false;
  var endDate;
  var startDate;
  String? firstDate;
  String? lastDate;
  int? userId;
  int? user_roleId;
  bool typesearch = false;

  var _controller = TextEditingController();

  // <<<<<<<<< GetuserId from LoginPage function here...>>>>>>>>
  getUserId() async {
    userId = await PreferenceHelper.getUserId();

    print("useridsearchpage--$userId");
  }
// <<<<<<<<< End here...>>>>>>>>>>
// <<<<<<<<< GetuserId from LoginPage function here...>>>>>>>>
  getUserRoleId() async {
    user_roleId = await PreferenceHelper.getUserRoleId();

    print("user_roleIdD--$user_roleId");
  }
// <<<<<<<<< End here...>>>>>>>>>>

  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) => usernames());
    foundList =Allusers;
    getUserId();
    getUserRoleId();
    super.initState();
  }

  @override
   Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext newContext) {
            return Timetracker(newContext);
          })),
    );
  }
  
  
  
  Timetracker(BuildContext newContext) {
    ctx =newContext;
    return  SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [
              //  dateSearch?  
              //   IconButton(onPressed: (){
              //   setState(() {
              //     datefoundList =Datefilter;
              //   });
              //     print("clicked");
              //   }, icon: Icon(Icons.cancel_outlined)):
              //   IconButton(onPressed: (){
              //    showDaterange(newContext);
              //     print("clicked");
              //   }, icon: Icon(Icons.date_range))

              ],
              title: const Center(child: Text('User List'),),
              centerTitle: true,
              backgroundColor: Colors.deepPurple,
              shape: const RoundedRectangleBorder(
              borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15.0)))),

            // ......body design base by filters.....//
            body: isLoading
                ? const Center(child: LoadingWidget()
                ):UsernamesListWidget(),
                floatingActionButton: FActionbutton()
                //  dateSearch ?  DateListWidget() : TaskListWidget()
                )
              );
  }

// search filter function>>>>>>>>>>>>
void _filtervalue(String searchword){
List result =[];
 if(searchword.isEmpty){
result = Allusers;
print(result);
print("ifff");
 }
 else{
  result = Allusers.where((element) => element.fullName!.toLowerCase().contains(searchword.toLowerCase())).toList();
  print("elseeee");
  print(result);
 }
 setState(() {
   foundList = result;
   typesearch =true;
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
                String formattedDate =DateFormat('dd-MM-yyyy').format(endDate);
                String formattedDate1 =DateFormat('dd-MM-yyyy').format(startDate);
                firstDate = formattedDate1;
                lastDate = formattedDate;
                print(formattedDate1);
                print(formattedDate);
                dateSearch = true;
              });
              // filter();
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
Container UsernamesListWidget() {
  print("-----usernamelistWidget------");
    return Container(
        child: Allusers.length != 0
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
                      suffixIcon:typesearch ? IconButton(icon: Icon(Icons.cancel),onPressed:() {
                        _controller.clear();
                        setState(() {
                          foundList = Allusers;
                          typesearch =false;
                        });
                      } ): IconButton(icon: Icon(Icons.person_search_outlined),onPressed:() {
                        // _controller.clear();
                        // setState(() {
                        //   foundList = Allusers;
                        // });
                      } ),

                    ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child:   ListView.builder(
                      itemCount: typesearch ? foundList.length : Allusers.length,
                      itemBuilder: ((context, i) {
                        print('lenth of searchlist data............${Allusers.length}');
                        // Using CARD design...
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
                          child: Carddesign(i, context),
                        );
                      }))
                      //  : ListView.builder(
                      // itemCount: Allusers!.length,
                      // itemBuilder: ((context, i) {
                      //   print('lenth of searchlist data............${Allusers!.length}');
                      //   // Using CARD design...
                      //   return Padding(
                      //     padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
                      //     child: Carddesign(i, context),
                      //   );
                      // }))
                ),
              ],
            )
            : Center(
                child: Showmessage(),
              )
              );
  }



  //<<<<<<<<<<< Get Alluser API function..>>>>>>>>>>>>>>>
  usernames() {
    print(">>>>>>>>>>>username>>>>>>>>>>>>>");
    final api = Provider.of<ApiService>(ctx!, listen: false);
    api.userlistdetail().then((response) {
      if (response.status == true) {
        if (mounted) {
          setState(() {
            Allusers = response.data!;
            // print('-----------$usernameId');

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
      errshowSnackBar(context, "Please check your connection");
    });
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UsertaskListPage(username_id: typesearch ? foundList[i].userId : Allusers[i].userId,username:typesearch ? foundList[i].fullName : Allusers[i].fullName))),
                      // trailing: 
                      // // popmenu function//
                      // PopUpMenu(i, context),
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          typesearch ?'${foundList[i].fullName}' :'${Allusers[i].fullName}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 10,top: 5),
                        child: Text(
                            typesearch ? '${foundList[i].designation}' : '${Allusers[i].designation}',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 12)),
                      ),
                      leading:Icon(Icons.account_circle,size: 40,color: Colors.deepPurple,),
                      // TextButton(
                      //     onPressed: () {
                      //       // view Task details Fuction
                      //       // viewTask(context, i);
                      //     },
                      //     child: const Icon(
                      //       Icons.remove_red_eye_sharp,
                      //       color: Colors.deepPurple,
                      //       size: 18,
                      //     )),
                    ),
                  );
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

}



// List the all task from User>>>>>>>>
// Container TaskListWidget() {
//   print("-----tasklistWidget------");
//     return Container(
//         child: Allusers!.length != 0
//             ? Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10,10,10,0),
//                   child: SizedBox(
//                     child: TextField(
//                       // onChanged: ((value) => _filtervalue(value)),
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: "Search",
//                       suffixIcon: IconButton(icon: Icon(Icons.manage_search_sharp),onPressed: (){
//                       },),
//                     ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount: foundList!.length,
//                       itemBuilder: ((context, i) {
//                         print('lenth of searchlist data............${Allusers!.length}');
//                         // Using CARD design...
//                         return Padding(
//                           padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
//                           child: Carddesign(i, context),
//                         );
//                       }))
//                 ),
//               ],
//             )
//             : Center(
//                 child: Showmessage(),
//               )
//               );
//   }


// // date filter function and datefilter list widget code here>>>>>>>>>>>
//   Container DateListWidget() {
//     print("------datelist------");
//     return Container(
//         child: Datefilter!.length !=0 
//             ? Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(10,10,10,0),
//                   child: SizedBox(
//                     child: TextField(
//                       // onChanged: ((value) => _datefiltervalue(value)),
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: "Search",
//                       suffixIcon: IconButton(icon: Icon(Icons.date_range),onPressed: (){},),
//                     ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10,),
//                 Expanded(
//                   child: ListView.builder(
//                       itemCount: datefoundList!.length,
//                       itemBuilder: ((context, i) {
//                         print('lenth of datefilter data............${datefoundList!.length}');
//                         // Using CARD design...
//                         return Padding(
//                           padding: const EdgeInsets.only(left: 8, right: 8, top: 3),
//                           child: Carddesign(i, context),
//                         );
//                       }))
//                 ),
//               ],
//             ):Center(child: Showmessage(),
//               ));
//   }



// // same code but if use for date filter card design >>>>>>>>>>
//    Card Carddesign1(int i, BuildContext context) {
//     return Card(
//                     color: Color(0xFFF3F3F3),
//                     elevation: 10,
//                     surfaceTintColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     shadowColor: Color(0xFF00294B),
//                     child: ListTile(
//                       // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => UsertaskListPage(),)),
//                       // trailing: 
//                       // // popmenu function//
//                       // PopUpMenu(i, context),
//                       title: Text(
//                         '${Allusers![i].fullName}',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(
//                           '${Allusers![i].fullName}|| ${Allusers![i].designation}',
//                           style: const TextStyle(
//                               color: Colors.black, fontSize: 12)),
//                       leading: TextButton(
//                           onPressed: () {
//                             // view Task details Fuction
//                             viewTask(context, i);
//                           },
//                           child: const Icon(
//                             Icons.remove_red_eye_sharp,
//                             color: Colors.deepPurple,
//                             size: 18,
//                           )),
//                     ),
//                   );
//   }


// // view the task details when user click the card design>>>>>>>>>>>>
//   Future<dynamic> viewTask(BuildContext context, int i) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             insetPadding: EdgeInsets.all(10),
//             backgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0)),
//             child: Padding(
//               padding: const EdgeInsets.all(21.0),
//               child: SingleChildScrollView(
//                 child: Container(
//                   width: 500,
//                   height: 400,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                             height: 25,
//                             child: Center(
//                               child: Text(
//                                 "Task Details",
//                                 style: TextStyle(
//                                     color: Colors.deepPurple,
//                                     fontSize: 23,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             )),
//                         SizedBox(height: 10),
//                         TextField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             // hintText: 'Start Time:  ${AllTask![i].startTime}',
//                             hintStyle: TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           enabled: false,
//                         ),
//                         SizedBox(height: 10),
//                         TextField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             // hintText: 'End Time:  ${AllTask![i].endTime}',
//                             hintStyle: TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           enabled: false,
//                         ),
//                         SizedBox(height: 10),
//                         TextField(
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               // hintText: 'Date:  ${AllTask![i].startedDate}',
//                               hintStyle: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             enabled: false),
//                         SizedBox(height: 10),
//                         TextField(
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               // hintText: 'Project:   ${AllTask![i].projectName}',
//                               hintStyle: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             enabled: false),
//                         SizedBox(height: 10),
//                         TextField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             // hintText: 'Task:  ${AllTask![i].taskName}',
//                             hintStyle: TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                           enabled: false,
//                         ),
//                         SizedBox(height: 10),
//                         TextField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             // hintText:
//                                 // 'Description:  ${AllTask![i].taskDescription}',
//                             hintStyle: TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500),
//                             hintMaxLines: 5,
//                             enabled: false,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         });
//   }
