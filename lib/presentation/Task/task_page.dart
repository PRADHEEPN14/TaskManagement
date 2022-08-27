
import 'dart:math';

import 'package:bloc_auth/bloc/auth/auth_bloc.dart';
import 'package:bloc_auth/presentation/TaskList/task_list.dart';
import 'package:bloc_auth/presentation/Information/addinfo.dart';
// import 'package:bloc_auth/presentation/TaskList/tasklist_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

import '../SignIn/sign_in.dart';

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
  String startTime = "";
  String endTime = "";
  String dateInput = "";

  TextEditingController startTimeController =  TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController ProjectController =  TextEditingController();
  TextEditingController TaskController =  TextEditingController();
  TextEditingController descriptionController =  TextEditingController();
  TextEditingController dateInputController = TextEditingController();

  var maskFormatter =  MaskTextInputFormatter(
      mask: '##:##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static GlobalKey<FormFieldState> form_key = GlobalKey<FormFieldState>();
  @override
  void initState() {
    
    //  dateInputController.text = "";
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_)=> TaskPage());
  }


  @override
  Widget build(BuildContext context1) {
  //   return
  //       // Provider(create: (context) => ApiService.create(),
  //       Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     body: Builder(builder: (BuildContext context) {
  //       return TaskPage(context1);
  //     }),
  //   );
        
  // }


  // ignore: non_constant_identifier_names
  // TaskPage(BuildContext context1) {

    final user = FirebaseAuth.instance.currentUser!;
  if(user!=null){
    // print("${user.displayName}");
  }
     //snackbar style here..
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor:const Color(0xFFED4B1E),
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //end snackbar style here..
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar( title: Text("Today Task")),
      appBar: AppBar(
        title:const Center(child:  Text('TaskManagement')),
        backgroundColor: Colors.deepOrange,
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18.0))),
      ),

      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFD9D7D7)
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
                      width: MediaQuery.of(context).size.width*0.4,
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
                        decoration:const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: "18:00",
                          labelText: "End time",
                        ),
                      ),
                    ),
                  ],
                ),
              const  SizedBox(
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
                  const  SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 70,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: ProjectController,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          Project = value!;
                          if (Project.isEmpty) {
                            return "please enter field";
                          }
                        },
                        decoration:const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: "Add Project",
                            labelText: "Projects"),
                      ),
                    ),
                   const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: 70,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          task = value!;
                          if (task.isEmpty) {
                            return "please enter field";
                          }
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: "Task",
                            labelText: "Your Task"),
                      ),
                    ),
                  const  SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: 70,
                      child: TextFormField(
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
                    print("project--$Project");
                    print("stack$task");
                    print("des$description");
                    print("date${dateInputController.text}");
            
            // &&(endTimeController ==null)&&(ProjectController==null)&&(descriptionController==null)&&(TaskController==null))
            
                    if ((startTime != "") &&
                        (endTime != "") &&
                        (startTime.length > 4) &&
                        (endTime.length > 4) &&
                        (Project != "") &&
                        (task != "") &&
                        (description != "") &&
                        (dateInputController.text != "")) {
                      // ScaffoldMessenger.of(context1).showSnackBar(SnackBar(content: Text("valid form")));
                      showSnackBar(context, "Task updated Sucessfully...!");
                     
                      print("valid form");
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const TaskList()));
                    } else {
                      // ScaffoldMessenger.of(context1).showSnackBar(SnackBar(content: Text("invalid form")));
                      // showSnackBar(context, "Please enter all fields.");
            
                    }
                  },
                  child:const Text("Add Task"),
                )
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 20,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(image:  NetworkImage(
                "https://www.itying.com/images/flutter/1.png"),
                fit: BoxFit.cover),
                color:Colors.deepPurple
              ),
              accountName: Text("${user.email}"),
              accountEmail: Text("${user.displayName}"),
              currentAccountPicture: 
              
                Container(
                  decoration:const BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: user.photoURL != null
                      ? Image.network("${user.photoURL}")
                      : Container(),
                ),
              
              // currentAccountPictureSize:const Size.square(85),
            ),
          const  Divider(
              height: 10,
            ),

            ListTile(
              leading:const Icon(
                Icons.supervised_user_circle,
                size: 30,
                color: Color(0xFFF73B02),
              ),
              title:const Text(
                "Profile",
                style: TextStyle(
                    color: Color(0xFF3B3B3C),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) =>const AddInfoPage())),
            ),
           const Divider(
              height: 10,
            ),
            
           const Divider(
              height: 10,
            ),
            SizedBox(
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                    if (state is UnAuthenticated) {
              // Navigate to the sign in screen when the user Signs Out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) =>const SignIn()),
                (route) => false,
              );
            }
            
                  // ignore: todo
                  // TODO: implement listener
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.deepOrange 
                      
                      
                    ),
                    child: const Text('Sign Out'),
                    onPressed: () {
                      showDialog(context: context, builder: (ctx)=>  AlertDialog(
                        content:const  Text("Are you sure want to Exit",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold,fontSize: 18)),
                        actions: [
                          TextButton(onPressed: (){
                           // Signing out the user
                            context.read<AuthBloc>().add(SignOutRequested()); 
                          }, child:const Text("Yes",style: TextStyle(fontSize: 15),)
                          ),

                           TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child:const Text("No",style: TextStyle(fontSize: 15),)),
                        ],
                      )
                      );

                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}


