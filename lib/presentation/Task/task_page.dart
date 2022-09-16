// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc_auth/preference_helper.dart';
import 'package:bloc_auth/presentation/Information/addinfo.dart';
import 'package:bloc_auth/presentation/widgets/drawer.dart';
import 'package:bloc_auth/services/model/task_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../widgets/bottom_navigationbar.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  


  
  var ctx;
  String task = "";
  String description = "";
  String Project = "";
  String? startTime;
  String endTime = "";
  String dateInput = "";
  dynamic dropdownvalue;
  dynamic dropdownvalue1;
  bool isLoading = true;
  int? userId;

  // DateTime s1 = DateTime.parse("10:30:00");
  // DateTime s2 = DateTime.parse("11:47:00");

//<<<<<<<<<<<<<<<<<<<Timepicker Code Here..>>>>>>>>>>>>>>>>>>>>>
  Future<void> Timepick() async {
    TimeOfDay? pickedTime = await showTimePicker(initialTime: TimeOfDay.now(),context: context);
    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime =DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print('time--$parsedTime');
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      print('time2--$formattedTime');

      setState(() {
        startTimeController.text = pickedTime.format(context);
      });
    } else {
      print("Time is not selected");
    }
  }

// <<<<<<<<<<<<<<<<< Second  time picker code here...>>>>>>>>>>>>>>>>>>
  Future<void> Timepicker() async {
    TimeOfDay? pickedTime = await showTimePicker(initialTime: TimeOfDay.now(),context: context);
    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime =DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print('time111---$parsedTime');
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      print('time22--$formattedTime');
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      setState(() {
        endTimeController.text = pickedTime.format(context);
      });
    } else {
      print("Time is not selected");
    }
  }
  // <<<<<<<<<<<<<<<<<<<<< end here..>>>>>>>>>>>>>>>>

  final user = FirebaseAuth.instance.currentUser!;//firebase insatance code its user to know who loged in here..

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController ProjectController = TextEditingController();
  TextEditingController TaskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();

//<<<<<<<<<<<<<input Formatter code here...>>>>>>>>>>>>>>>>
  var maskFormatter = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
// <<<<<<<<<<<<<<<<< End here...>>>>>>>>>>>>>>>>>>

  static GlobalKey<FormFieldState> form_key = GlobalKey<FormFieldState>();

  @override
  void initState() {
    dateInputController.text = "";
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => TaskPage(context));
    getAllproject();
    getUserId();
  }
// <<<<<<<<< GetuserId from LoginPage function here...>>>>>>>>
  getUserId() async {
    userId = await PreferenceHelper.getUserId();

    print("userid--$userId");
  }
// <<<<<<<<< End here...>>>>>>>>>>


  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext context) {
            return TaskPage(context);
          }),
        ));
  }

  TaskPage(BuildContext context) {
    return SafeArea(
        child: isLoading
            ? const Center(
                child: SizedBox(
                width: 65,
                height: 40,
                // <<<<<<<<<<<<<<<<< Loading widget style here...>>>>>>>>>>>>>>>>>>
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
              // <<<<<<<<<<<<<<<<< End here...>>>>>>>>>>>>>>>>>>
            : Scaffold(
                appBar: AppBar(
                  title: const Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Text('TodayTask',textAlign: TextAlign.left),
                  ),
                  backgroundColor: Colors.deepPurple,
                  shape: const RoundedRectangleBorder(
                  borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(18.0))),
                ),

                body: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    // decoration: const BoxDecoration(
                    //     gradient: LinearGradient(colors: [
                    //   Color(0xFFF8F8F6),
                    //   Color(0xFFDD53F6),
                    // ], begin: Alignment.topRight, end: Alignment.bottomCenter)),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width:MediaQuery.of(context).size.width * 0.4,
                                    height: 70,
                                    child: TextFormField(
                                      inputFormatters: [maskFormatter],
                            onTap: Timepick,
                            textInputAction: TextInputAction.next,
                            controller: startTimeController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            maxLength: 8,
                            maxLines: 1,
                            decoration: const InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                              hintText: "10:00",
                              label: Text("Start time"),
                              labelStyle: TextStyle(color: Color.fromARGB(255, 29, 6, 111),fontWeight: FontWeight.w500,fontSize: 20),
                              ),
                      
                            validator: (value) {
                              startTime = value!;
                              if (startTime!.isEmpty) {
                                return "enter time";
                              } else if (startTime!.length < 5) {
                                return "Invalid time";
                              }
                            },
                          ),
                                  ),
                                ),
                                Container(
                                  width:MediaQuery.of(context).size.width * 0.4,
                                  height: 70,
                                    child: TextFormField(
                                      inputFormatters: [maskFormatter],
                                      textInputAction: TextInputAction.next,
                                      controller: endTimeController,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                      endTime = value!;
                                      if (endTime.isEmpty) {
                                        return "enter time";
                                      } else if (endTime.length < 5) {
                                        return "Invalid time";
                                      }
                                    },
                                    maxLength: 8,
                                    maxLines: 1,
                                    onTap: Timepicker,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                        borderSide:BorderSide(color: Colors.blue)),
                                        hintText: "18:00",
                                        labelText: "End time",
                                        labelStyle: TextStyle(
                                            color:Color.fromARGB(255, 29, 6, 111),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18,),
                            Padding(padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                SizedBox(
                                  height: 70,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (dateInput) =>dateInputController.text.isEmpty||dateInputController.text==null?'enter valid date':null,
                                    controller: dateInputController,
                                    //editing controller of this TextField
                                      decoration: const InputDecoration(
                                      border: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey)),
                                      prefixIcon: Icon(Icons.calendar_today),
                                      labelText: "Enter Date",
                                      labelStyle: TextStyle(color:Color.fromARGB(255, 29, 6, 111),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                      
                                    ),
                                    readOnly: true,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          //DateTime.now() - not to allow to choose before today.
                                          lastDate: DateTime(2100));

                                      if (pickedDate != null) {
                                        print(pickedDate); //pickedDate output format => 2021-03-10
                                        String formattedDate =DateFormat('dd-MM-yyyy').format(pickedDate);
                                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                        setState(() {
                                          dateInputController.text =formattedDate; //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                  ),
                                ),
                                
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 78,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        labelText: 'Project',
                                        labelStyle: TextStyle(
                                            color:
                                                Color.fromARGB(255, 29, 6, 111),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                        border: OutlineInputBorder(),
                                        disabledBorder: UnderlineInputBorder(),
                                      ),
                                      isExpanded: true,
                                      validator: (selectedValue) =>selectedValue == null? "select project": null,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      hint:const Text('Project'),
                                      borderRadius: BorderRadius.circular(15),
                                      items: Allprojectlist.map((item) {
                                        return DropdownMenuItem(
                                          value: item["id"].toString(),
                                          child: Text(item['name'].toString()),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {

                                        setState(() {
                                          dropdownvalue = newVal.toString();
                                        });

                                        getAllCategory(value: dropdownvalue);
                                      },
                                      value: dropdownvalue,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 28,
                                ),
                                SizedBox(
                                  height: 78,
                                    child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Task List',
                                        labelStyle: TextStyle(color:Color.fromARGB(255, 29, 6, 111),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20),
                                      ),
                                      isExpanded: true,
                                      validator: (selectedValue) =>selectedValue == null? "Select Task": null,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      hint:const Text('Select your Task'),
                                      borderRadius: BorderRadius.circular(15),
                                      items: Alltasklist.map((item) {
                                        return DropdownMenuItem(
                                          value: item["id"].toString(),
                                          child: Text(item['name'].toString()),
                                          );
                                          }).toList(),
                                          onChanged: (newVal) {
                                          setState(() {
                                          dropdownvalue1 = newVal.toString();
                                          });
                                      },
                                      value: dropdownvalue1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18,),
                                SizedBox(
                                  height: 70,
                                    child: TextFormField(
                                    controller: descriptionController,
                                    textInputAction: TextInputAction.next,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      description = value!;
                                      if (description.isEmpty) {
                                        return "please enter feild";
                                      }
                                    },
                                    decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                            borderSide:BorderSide(color: Colors.grey)),
                                            hintText: "Task description",
                                            labelText: "Description",
                                            labelStyle: TextStyle(
                                            color:
                                                Color.fromARGB(255, 29, 6, 111),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20)),
                                  ),
                                ),
                              ]),
                            ),
                              SizedBox(height: 70,),
                            ElevatedButton(
                              onPressed: () {
                               

                                if ((startTimeController.text !=""||startTimeController.text != null) &&
                                    (endTimeController.text != ""||endTimeController.text != null) &&
                                    (startTimeController.text.length < 9) &&
                                    (endTimeController.text.length < 9) &&
                                    (dropdownvalue != "" ||
                                        dropdownvalue != null) &&
                                    (dropdownvalue1 != "" ||
                                        dropdownvalue1 != null) &&
                                    (descriptionController.text != "") &&
                                    (dateInputController.text != "")
                                    &&(startTimeController.text != endTimeController.text)) {
                                  print("valid form");
                                   print("start--${startTimeController.text}");
                                print("end--${endTimeController.text}");
                                print("des${descriptionController.text}");
                                print("date${dateInputController.text}");
                                print("list--$dropdownvalue");
                                print("project--$dropdownvalue1");

                                  //API function.... here...
                                  createtask(context);
                                }else if((startTime == endTime)){
                                  showSnackBar(context, "Please enter valid time");
                                }
                                 else {
                                  print('hi');
                                  showSnackBar(context, "Please enter all fields.");
                                }
                              },
                              child: const Text("Add Task"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                drawer: MyDrawer(),
              ));
  }



// <<<<<<<<<<<<<<<<< GetAll Project API from Clockify code here...>>>>>>>>>>>>>>>>>>
// ignore: non_constant_identifier_names
List Allprojectlist = [];

  Future getAllproject() async {
    var baseUrl =
        "https://api.clockify.me/api/v1/workspaces/5dc44ce28044af3bae2d11f5/projects";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "x-api-key": "M2ZlMWM0Y2YtMjJlMC00YTRiLWJjZGYtM2VjMGNhNDJiMzNi"
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Allprojectlist = jsonData;
      setState(() {
        isLoading = false;
      });
    }
  }


// <<<<<<<<<<<<<<<<< Task List API here...>>>>>>>>>>>>>>>>>>
List Alltasklist = [];

  Future getAllCategory({String? value}) async {
    var baseUrl =
        "https://api.clockify.me/api/v1/workspaces/5dc44ce28044af3bae2d11f5/projects/$dropdownvalue/tasks";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "x-api-key": "M2ZlMWM0Y2YtMjJlMC00YTRiLWJjZGYtM2VjMGNhNDJiMzNi"
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Alltasklist = jsonData;
      if (Alltasklist != null && Alltasklist.length > 0) {
        dropdownvalue1 = Alltasklist[0]["id"];
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  // <<<<<<<<<<<<<<<<< Clockify API End here...>>>>>>>>>>>>>>>>>>

//<<<<<<<<<<< snackbar style here..>>>>>>>>>>>>>>>
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
//<<<<<<<<<end snackbar style here..>>>>>>>>>>>>>>>>


//>>>>>>>>>>>>>>>>>>>>>>API code Here...>>>>>>>>>>>>>>>>>>>>
  void createtask(context) {
    var api = Provider.of<ApiService>(context, listen: false);
    Task_Req TaskData = Task_Req();
    TaskData.clockifyProjectId = dropdownvalue;
    TaskData.clockifyTaskId = dropdownvalue1;
    TaskData.startTime = startTimeController.text;
    TaskData.taskDescription = descriptionController.text;
    TaskData.startedDate = dateInputController.text;
    TaskData.endTime = endTimeController.text;
    api.createtask(TaskData).then((response) {
      if (response.status == true) {
        print(response.status);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => BottomNaviagate(screenindex: 2)),
        );
        print(response.message);
        showSnackBar(context, '${response.message}');
      } else if(response.message== "Internal server error. Please try again later !"){
        //  Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //       builder: (context) => BottomNaviagate(screenindex: 0,)),
        // );
        showSnackBar(context, 'Entered time not valid please check!');
       
      }
      else {
        showSnackBar(context, '${response.message}');
         Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) =>const AddInfoPage()),
        );

      }
    });
  }
}
