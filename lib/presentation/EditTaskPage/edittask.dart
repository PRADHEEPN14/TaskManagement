// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:ui';

import 'package:bloc_auth/presentation/TaskList/task_list.dart';
import 'package:bloc_auth/services/model/task_request.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../services/Apiservices/ApiService.dart';
import '../../services/model/profile_response.dart';
import '../../services/model/tasklist_response.dart';
import '../widgets/bottom_navigationbar.dart';
import '../widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditTaskPage extends StatefulWidget {
  int? dailyTimeId;
  String? startTime;
  String? endTime;
  String? startedDate;
  String? projectlist;
  String? taskList;
  String? taskdescript;
  EditTaskPage(
      {Key? key,
      this.dailyTimeId,
      this.startTime,
      this.endTime,
      this.startedDate,
      this.projectlist,
      this.taskList,
      this.taskdescript})
      : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  String userId = '';
  String task = "";
  String description = "";
  String Project = "";
  String startTime = "";
  String endTime = "";
  String dateInput = "";
  dynamic Projectvalue;
  dynamic Listvalue;

 

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController ProjectController = TextEditingController();
  TextEditingController TaskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();


 // <<<<<<<<<<<<<<<<<<<<< Text Input formatter function here..>>>>>>>>>>>>>>>>

  var maskFormatter = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

 // <<<<<<<<<<<<<<<<<<<<< end here..>>>>>>>>>>>>>>>>

  @override
  void initState() {
  
    getAllproject();
    print('xxxxx---${widget.projectlist}');
    print('xxxxx---${widget.taskList}');

    // Pass the data from TaskPage to assign current textform fields...
    setState(() {
      startTimeController.text = widget.startTime!;
      endTimeController.text = widget.endTime!;
      dateInputController.text = widget.startedDate!;
      Projectvalue = widget.projectlist!;
      Listvalue = widget.taskList!;
      descriptionController.text = widget.taskdescript!;
    });
  }
 var titleBox= const TextStyle(color: Color.fromARGB(255, 29, 6, 111),fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext context) {
            return EditTaskPage(context);
          }),
        ));
  }

  EditTaskPage(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
        title: const Center(child: Text('TaskManagement')),
        backgroundColor: Colors.deepPurple,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0))),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors:[Color(0xFFF8F8F6),Color(0xFFDD53F6)],
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft)
          //     ),

          child: Padding(padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 70,
                          child: TextFormField(
                            inputFormatters: [maskFormatter],
                            onTap: Timepick,
                            textInputAction: TextInputAction.next,
                            controller: startTimeController,
                            autovalidateMode: AutovalidateMode.always,
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
                              if (startTime.isEmpty) {
                                return "enter time";
                              } else if (startTime.length < 7) {
                                return "Invalid time";
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 70,
                        child: TextFormField(
                          inputFormatters: [maskFormatter],
                          onTap: Timepicker,
                          textInputAction: TextInputAction.next,
                          controller: endTimeController,
                          autovalidateMode: AutovalidateMode.always,
                          maxLength: 8,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                            hintText: "18:00",
                            labelText: "End time",
                            labelStyle: TextStyle(color: Color.fromARGB(255, 29, 6, 111),fontWeight: FontWeight.w500,fontSize: 20)),
                          validator: (value) {
                            endTime = value!;
                            if (endTime.isEmpty) {
                              return "enter time";
                            } else if (endTime.length < 7) {
                              return "Invalid time";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Padding(padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                        height: 70,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.always,
                          controller: dateInputController,
                          //editing controller of this TextField
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                          // icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter Date",
                            labelStyle: TextStyle(color: Color.fromARGB(255, 29, 6, 111),fontWeight: FontWeight.w500,fontSize: 20),
                            prefixIcon:Icon(Icons.calendar_today), //label text of field
                            prefixIconColor: Color.fromARGB(255, 49, 1, 131)),
                            readOnly: true,
                            validator: (dateInput) {
                            if (dateInput!.isEmpty) {
                              return "select date";
                            }
                             },
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));
      
                            if (pickedDate != null) {
                              print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =DateFormat('dd-MM-yyyy').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dateInputController.text =formattedDate; //set output date to TextField value.
                              });
                            } else {}
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 70,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                                labelStyle: TextStyle(color: Color.fromARGB(255, 29, 6, 111),fontWeight: FontWeight.w500,fontSize: 20),
                                labelText: 'Select Project',
                                border: OutlineInputBorder(),
                                disabledBorder: UnderlineInputBorder()),
                                isExpanded: true,
                                // ignore: non_constant_identifier_names
                                validator: (Projectvalue) => Projectvalue == null? "select your Project": null,
                                autovalidateMode: AutovalidateMode.always,
                                hint: const Text('Slelect Project'),
                                borderRadius: BorderRadius.circular(15),
                                items: Allprojectlist.map((item) {
                                return DropdownMenuItem(
                                value: item["id"].toString(),
                                child: Text(item['name'].toString()),
                                );
                                }).toList(),
                                //once the dropdown value change the new value was stored and assign to projectvalue..
                                onChanged: (newVal) {
                              // print(newValue);
                                setState(() {
                                Projectvalue = newVal.toString();//store the value as string...
                                print('$Projectvalue');
                              });
                              getAllCategory(value: Projectvalue);// this function send the current dropdown value to next dropdown...
                            },
                            value: Projectvalue,//dropdown value..
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        height: 78,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Select Task',
                              labelStyle: TextStyle(color: Color.fromARGB(255, 29, 6, 111),fontWeight: FontWeight.w500,fontSize: 20),
                              border: OutlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(),
                              ),
                              isExpanded: true,
                              validator: (Listvalue) =>
                              Listvalue == null ? "select Task" : null,
                              autovalidateMode: AutovalidateMode.always,
                              hint: Text('Select your Task'),
                              borderRadius: BorderRadius.circular(15),
                              items: Alltasklist.map((item) {
                              
                              return DropdownMenuItem(
                                value: item["id"].toString(),//id is stored as value..
                                child: Text(item['name'].toString()),//show the name of select item
                              );}).toList(),
                            style:const TextStyle(fontSize: 18,color: Colors.black),
                            //once the dropdown value change the new value was stored and assign to Listtvalue..
                            onChanged: (newVal) {
                            //set the Listvalue as a string
                              setState(() {
                                Listvalue = newVal.toString();
                              });
                            },
                            value: Listvalue,//dropdown value..
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        height: 78,
                        child: TextFormField(
                          controller: descriptionController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (value) {
                            description = value!;
                            if (description.isEmpty) {
                              return "please enter feild";
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "Task description",
                              labelText: "Description",
                              labelStyle: TextStyle(color: Color.fromARGB(255, 29, 6, 111),fontWeight: FontWeight.w500,fontSize: 20),),
                              
                        ),
                      ),
                    ]),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // is the condition for before Api call..
                      if ((startTime != "") &&
                          (endTime != "") &&
                          (startTime.length < 8) &&
                          (endTime.length < 8) &&
                          (Projectvalue != "" || Projectvalue != null) &&
                          (Listvalue != "" || Listvalue != null) &&
                          (descriptionController.text != "") &&
                          (dateInputController.text != "")
                           &&(startTime != endTime)) {
                        //if print some value what we entered in your text field...
                        print("start--$startTime");
                        print("end--$endTime");
                        print("des${descriptionController.text}");
                        print("date${dateInputController.text}");
                        print("project--$Projectvalue");
                        print("list--$Listvalue");
                        print("valid form");

                        // Update Api function...
                        updatetask(context);

                      }else if((startTime == endTime)){
                                  showSnackBar(context, "Please enter valid time");
                                }
                                  else if(startTime.isEmpty|| endTime.isEmpty){
                                    showSnackBar(context, "Please enter time");
                                  }
                                  else if((startTime == endTime)){
                                    showSnackBar(context, "Please enter valid time");
                                  } 
                                  else if((dateInputController.text.isEmpty)){
                                    showSnackBar(context, "Please select Date");
                                  } 
                                  else if((Projectvalue == null)){
                                    showSnackBar(context, "Please select project");
                                  } 
                                  else if((Listvalue == null)){
                                    showSnackBar(context, "Please select project");
                                  } 
                    
                                   else if((description.isEmpty)){
                                    showSnackBar(context, "Please enter description");
                                  } 
                       else {
                        // showSnackBar(context, "Please enter all fields.");
                      }
                    },
                    child: const Text("Update Task"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      // drawer: MyDrawer(),
    ));
  }

//<<<<<<<<<<<< Time picker function....>>>>>>>>>>>>>>>>>
 
   Future<void> Timepick() async {
    TimeOfDay? pickedTime = await showTimePicker(initialTime: TimeOfDay.now(),context: context );
    if (pickedTime != null) {
      print(pickedTime.format(context));
      DateTime parsedTime =DateFormat.jm().parse(pickedTime.format(context).toString());
      //converting to DateTime so that we can further format on different pattern.
      print(parsedTime);
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      print(formattedTime);

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
      print(parsedTime);
      String formattedTime = DateFormat('HH:mm').format(parsedTime);
      print(formattedTime);
      //DateFormat() is from intl package, you can format the time on any pattern you need.
      setState(() {
        endTimeController.text = pickedTime.format(context);
      });
    } else {
      print("Time is not selected");
    }
  }
  // <<<<<<<<<<<<<<<<<<<<< end here..>>>>>>>>>>>>>>>>


  // <<<<<<<<<<<<<<<<<<<<< SnackBar design..>>>>>>>>>>>>>>>>

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

  // <<<<<<<<<<<<<<<<<<<<< SnackBar design..>>>>>>>>>>>>>>>> 

//  ...dropdown AllProject List API here...   //

  List Allprojectlist = [];
  List Alltasklist = [];

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
        // print('project$Allprojectlist') ;
      });
      // getAllCategory();
    }
  }

//  ...dropdown AllTask List API here...   //

  Future getAllCategory({String? value}) async {
    var baseUrl =
        "https://api.clockify.me/api/v1/workspaces/5dc44ce28044af3bae2d11f5/projects/${Projectvalue}/tasks";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "x-api-key": "M2ZlMWM0Y2YtMjJlMC00YTRiLWJjZGYtM2VjMGNhNDJiMzNi"
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      Alltasklist = jsonData;
      if (Alltasklist != null && Alltasklist.length > 0) {
        Listvalue = Alltasklist[0]["id"];
      }
      setState(() {
        // print('${Alltasklist[0]['name']}') ;
      });
    }
  }

//  <<<<<< UPDATE API Function here...>>>>>>>   //

  void updatetask(context) {
    Task_Req updateTask = Task_Req();
    updateTask.startTime = startTimeController.text;
    updateTask.endTime = endTimeController.text;
    updateTask.startedDate = dateInputController.text;
    updateTask.clockifyProjectId = Projectvalue;
    updateTask.clockifyTaskId = Listvalue;
    updateTask.taskDescription = descriptionController.text;
    var api = Provider.of<ApiService>(context, listen: false);
    print('update id1--${widget.dailyTimeId}');
    api.updatetask(widget.dailyTimeId!, updateTask).then((response) {
      if (response.status == true) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BottomNaviagate(screenindex: 2)),
        );

        showSnackBar(context, "${response.message}");
      } else {
        showSnackBar(context, "${response.message}");
      }
    });
    print('update id--${widget.dailyTimeId}');
  }
//  <<<<<< UPDATE API Function end here...>>>>>>>   
}
