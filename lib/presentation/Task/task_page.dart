import 'dart:convert';
import 'dart:ffi';

import 'package:bloc_auth/preference_helper.dart';
import 'package:bloc_auth/presentation/TaskList/task_list.dart';
import 'package:bloc_auth/presentation/widgets/drawer.dart';
import 'package:bloc_auth/services/model/project_list.dart';
import 'package:bloc_auth/services/model/task_request.dart';
// import 'package:bloc_auth/presentation/TaskList/tasklist_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

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
      setState(() {
        Allprojectlist = jsonData;
        // print('project$Allprojectlist') ;
      });
      // getAllCategory();
    }
  }

  Future getAllCategory() async {
    var baseUrl =
        "https://api.clockify.me/api/v1/workspaces/5dc44ce28044af3bae2d11f5/projects/${dropdownvalue}/tasks";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "x-api-key": "M2ZlMWM0Y2YtMjJlMC00YTRiLWJjZGYtM2VjMGNhNDJiMzNi"
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        Alltasklist = jsonData;
        // print('${Alltasklist[0]['name']}') ;
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();

  //     getAllproject();

  // }

  var ctx;
  String task = "";
  String description = "";
  String Project = "";
  String startTime = "";
  String endTime = "";
  String dateInput = "";
  var dropdownvalue;
  var dropdownvalue1;


  var isLoading = true;

  //  var selectedName;
//  List listdata = [];
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController ProjectController = TextEditingController();
  TextEditingController TaskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static GlobalKey<FormFieldState> form_key = GlobalKey<FormFieldState>();

  @override
  void initState() {
    // allprojects();
    // getAllName();
    dateInputController.text = "";
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_)=> TaskPage(context));
    getAllproject();
    // getAllCategory();
  }

  //snackbar style here..
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //end snackbar style here..

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
        child: Scaffold(
      // appBar: AppBar( title: Text("Today Task")),
      appBar: AppBar(
        title: const Center(child: Text('TaskManagement')),
        backgroundColor: Colors.redAccent,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18.0))),
      ),

      body: Container(
        decoration: const BoxDecoration(
            // color: Color(0xFFD9D7D7)
            ),
        key: form_key,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 70,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: startTimeController,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          startTime = value!;
                          if (startTime.isEmpty) {
                            return "enter time";
                          } else if (startTime.length < 5) {
                            return "Invalid time";
                          }
                        },
                        maxLength: 5,
                        maxLines: 1,
                        inputFormatters: [
                          maskFormatter,
                        ],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: "10:00",
                            label: Text("start time")),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 70,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: endTimeController,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          endTime = value!;
                          if (endTime.isEmpty) {
                            return "enter time";
                          } else if (endTime.length < 5) {
                            return "Invalid time";
                          }
                        },
                        maxLength: 5,
                        maxLines: 1,
                        inputFormatters: [
                          maskFormatter,
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: "18:00",
                          labelText: "End time",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    SizedBox(
                      height: 70,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (dateInput) {
                          if (dateInput!.isEmpty) {
                            return "select date";
                          }
                        },
                        controller: dateInputController,
                        //editing controller of this TextField
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          // icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Date",
                          prefixIcon:
                              Icon(Icons.calendar_today), //label text of field
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateInputController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              labelText: 'Task',
                              border: OutlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          isExpanded: true,
                          validator: (selectedValue) =>
                              selectedValue == null ? "select Task" : null,
                          autovalidateMode: AutovalidateMode.always,
                          hint: Text('Tasks'),
                          items: Allprojectlist.map((item) {
                            return DropdownMenuItem(
                              value: item["id"].toString(),
                              child: Text(item['name'].toString()),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              dropdownvalue = newVal;
                              getAllCategory();
                            });
                          },
                          value: dropdownvalue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: 70,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            
                            border: OutlineInputBorder(),
                            // enabled: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                          ),
                          isExpanded: true,
                          validator: (selectedValue) =>
                              selectedValue == null ? "select Project" : null,
                          autovalidateMode: AutovalidateMode.always,
                          hint: Text('Select your Project'),
                          items: Alltasklist.map((item) {
                            return DropdownMenuItem(
                              value: item["id"].toString(),
                              child: Text(item['name'].toString()),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              dropdownvalue1 = newVal;
                            });
                          },
                          value: dropdownvalue1,
                        ),
                      ),
                    ),

                    // DropdownButton(
                    //   isExpanded: true,
                    //   items: listdata.map((item){

                    //   return DropdownMenuItem(
                    //     child: Text(item['project_title'].toString()),
                    //   value: item['project_title'].toString(),);
                    // },).toList(),
                    //  onChanged: (newValue){
                    //   setState(() {
                    //     selectedName == newValue;
                    //     print(selectedName);
                    //   });
                    // },
                    // value: selectedName,
                    // hint:const Text("project"),

                    // ),

                    // ),

                    const SizedBox(
                      height: 18,
                    ),
                    // SizedBox(
                    //   height: 70,
                    //   child: TextFormField(
                    //     textInputAction: TextInputAction.next,
                    //     autovalidateMode: AutovalidateMode.always,
                    //     validator: (value) {
                    //       task = value!;
                    //       if (task.isEmpty) {
                    //         return "please enter field";
                    //       }
                    //     },
                    //     decoration: const InputDecoration(
                    //         border: OutlineInputBorder(
                    //             borderSide: BorderSide(color: Colors.grey)),
                    //         hintText: "Task",
                    //         labelText: "Your Task"),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: 70,
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
                            labelText: "Dfescription"),
                      ),
                    ),
                  ]),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("start--$startTime");
                    print("end--$endTime");
                    // print("project--$Project");
                    // print("stack$task");
                    print("des${descriptionController.text}");
                    print("date${dateInputController.text}");
                    print("list--$dropdownvalue");
                    print("project--$dropdownvalue1");

                    // &&(endTimeController ==null)&&(ProjectController==null)&&(descriptionController==null)&&(TaskController==null))

                    if ((startTime != "") &&
                        (endTime != "") &&
                        (startTime.length > 4) &&
                        (endTime.length > 4) &&
                        (dropdownvalue != "" || dropdownvalue != null) &&
                        (dropdownvalue1 != "" || dropdownvalue1 != null) &&
                        // (task != "") &&
                        (descriptionController.text != "") &&
                        (dateInputController.text != "")) {
                      // ScaffoldMessenger.of(context1).showSnackBar(SnackBar(content: Text("valid form")));
                      showSnackBar(context, "Task updated Sucessfully...!");

                      print("valid form");

                      createtask(context);
                    } else {
                      // ScaffoldMessenger.of(context1).showSnackBar(SnackBar(content: Text("invalid form")));
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
      drawer: MyDrawer(),
    ));
  }
  // void allprojects(){

  //   var api =Provider.of<ApiService>(context,listen: false);
  //   api.allprojects().then((response){
  //     print(response);
  //     if(response.status ==true){
  //       setState(() {
  //         listdata = response.data!;
  //       });
  //     }
  //   });

  // }

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
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => const TaskList()),);
      }
    });
  }
}
