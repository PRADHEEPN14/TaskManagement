import 'dart:convert';

import 'package:bloc_auth/presentation/TaskList/task_list.dart';
import 'package:bloc_auth/services/model/task_request.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../services/Apiservices/ApiService.dart';
import '../../services/model/profile_response.dart';
import '../../services/model/tasklist_response.dart';
import '../widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditTaskPage extends StatefulWidget {
  int? dailyTimeId;
  // List<Data>? AllTask;
  String? startTime;
  String? endTime;
  String? startedDate;
  String? projectlist;
  String? taskList;
  String? taskdescript;
  EditTaskPage({Key? key, this.dailyTimeId, this.startTime, this.endTime, this.startedDate, this.projectlist, this.taskList, this.taskdescript }) : super(key: key);

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
  var Projectvalue;
  var Listvalue;
 
  var selectedValue;
  var selectedValue1;

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

     @override
  void initState() {
    // TODO: implement initState
    // super.initState();
  getAllproject();
  print('xxxxx---${widget.projectlist}');
   print('xxxxx---${widget.taskList}');
    // print('xxxxx---${widget.startedDate}');
  // print()
  setState(() {
   startTimeController.text= widget.startTime!;
  endTimeController.text=widget.endTime!;
  dateInputController.text= widget.startedDate!;
  // selectedValue =widget.projectlist!;
  // selectedValue1=widget.taskList!;
  descriptionController.text=widget.taskdescript!; 
  });
  



  }


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
    // context= newContext;
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
                              labelText: 'Select project',
                              border: OutlineInputBorder(),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white))),
                          isExpanded: true,
                          validator: (Projectvalue) =>
                              Projectvalue == null ? "select Task" : null,
                          autovalidateMode: AutovalidateMode.always,
                          // hint: Text('Slelect Project'),
                          items: Allprojectlist.map((item) {
                            return DropdownMenuItem(
                              value: item["id"].toString(),
                              child: Text(item['name'].toString()),
                            );
                          }).toList(),
                          onChanged: (selectedValue) {
                            print(selectedValue);
                            setState(() {
                              Projectvalue = selectedValue;
                              getAllCategory();
                              print('$Projectvalue');
                              
                            });
                          },
                          value: Projectvalue,
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
                          validator: (Listvalue) =>
                              Listvalue == null ? "select Project" : null,
                          autovalidateMode: AutovalidateMode.always,
                          hint: Text('Select your Task'),
                          items: Alltasklist.map((item) {
                            return DropdownMenuItem(
                              value: item["id"].toString(),
                              child: Text(item['name'].toString()),
                            );
                          }).toList(),
                          onChanged: (selectedValue1) {
                            print(selectedValue1);
                            setState(() {
                              Listvalue = selectedValue1;
                               
                            });
                          },
                          value: Listvalue,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
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
                            labelText: "Description"),
                      ),
                    ),
                  ]),
                ),
                ElevatedButton(
                  onPressed: () {


                    if ((startTime != "") &&
                        (endTime != "") &&
                        (startTime.length > 4) &&
                        (endTime.length > 4) &&
                        (Projectvalue != "" || Projectvalue != null) &&
                        (Listvalue != "" || Listvalue != null) &&
                        (descriptionController.text != "") &&
                        (dateInputController.text != "")) {


                          print("start--$startTime");
                    print("end--$endTime");
                    
                    print("des${descriptionController.text}");
                    print("date${dateInputController.text}");
                    print("project--$Projectvalue");
                    print("list--$Listvalue");
                     
                      showSnackBar(context, "Task updated Sucessfully...!");
                      updatetask(context);

                      print("valid form");

                      // createtask(context);
                    } else {
                      
                      showSnackBar(context, "Please enter all fields.");
                    }
                  },
                  child: const Text("Update Task"),
                )
              ],
            ),
          ),
        ),
      ),
      // drawer: MyDrawer(),
    ));
  }

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
      setState(() {
        Allprojectlist = jsonData;
        // print('project$Allprojectlist') ;
      });
      // getAllCategory();
    }
  }

// ...dropdown AllTask List API here... //

  Future getAllCategory() async {
    var baseUrl =
        "https://api.clockify.me/api/v1/workspaces/5dc44ce28044af3bae2d11f5/projects/${Projectvalue}/tasks";

    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "x-api-key": "M2ZlMWM0Y2YtMjJlMC00YTRiLWJjZGYtM2VjMGNhNDJiMzNi"
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        Alltasklist = jsonData;
        // print("${Alltasklist[0]}");
        // print('${Alltasklist[0]['name']}') ;
      });
    }
  }
  void updatetask(context){
  Task_Req updateTask= Task_Req();
  updateTask.startTime = startTimeController.text;
  updateTask.endTime = endTimeController.text;
  updateTask.startedDate= dateInputController.text;
  updateTask.clockifyProjectId = Projectvalue;
  updateTask.clockifyTaskId = Listvalue ;
  updateTask.taskDescription= descriptionController.text;
  var api = Provider.of<ApiService>(context, listen: false);
   print('update id1--${widget.dailyTimeId}');
  api.updatetask(widget.dailyTimeId!, updateTask).then((response){
    if(response.status==true){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TaskList(),));
    }

  });
  print('update id--${widget.dailyTimeId}');
  
}




}
