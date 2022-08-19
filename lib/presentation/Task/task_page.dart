


// import 'package:flutter/material.dart';

// class TaskPage extends StatelessWidget {
//   final String text;

//   TaskPage({required this.text}) : super();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('My text is: $text'),
//       ),
//     );
//   }
// }
import 'package:bloc_auth/presentation/TaskList/tasklist_page.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class Aboutme extends StatefulWidget {
  const Aboutme({Key? key}) : super(key: key);

  @override
  State<Aboutme> createState() => _AboutmeState();
}

class _AboutmeState extends State<Aboutme> {

  var ctx;
  String task="";
  String description ="";
  String Project="";
  String startTime="";
  String endTime="";
  String  dateInput="";

  TextEditingController startTimeController = new TextEditingController();
  TextEditingController endTimeController = new TextEditingController();
  TextEditingController ProjectController = new TextEditingController();
  TextEditingController TaskController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  


  var maskFormatter = new MaskTextInputFormatter(
  mask: '##:##', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
);

static GlobalKey<FormFieldState> form_key= GlobalKey<FormFieldState>();
@override
void initState() {
    // TODO: implement initState
    //  dateInputController.text = ""; 
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_)=> aboutme());
  }

void showSnackBar(BuildContext context,String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Color(0xFFED4B1E),
      behavior: SnackBarBehavior.floating,
      width: 330,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return 
    // Provider(create: (context) => ApiService.create(),
     Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (BuildContext newContext){
        return aboutme(newContext);
      }),
    );
  }
   aboutme(BuildContext newContext){
    return SafeArea(child: Scaffold(
      // appBar: AppBar( title: Text("Today Task")),


      body: Container(
        key: form_key,
        width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child:SingleChildScrollView (
            child: Column(
              
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: MediaQuery.of(context).size.width*0.4,
                      child: TextFormField(
                        controller: startTimeController,
                        autovalidateMode: AutovalidateMode.always,
                       validator: (value) {
                        startTime = value!;
                         if(startTime.isEmpty){
                          return "enter time";
                         }
                         else if(startTime.length<5){
                          return "Invalid time";
                        }
                       },
                        
                        
                        maxLength: 5,
                        maxLines: 1,
                        inputFormatters: [
                          maskFormatter,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                          
                          hintText: "10:00",
                          label: Text("start time")
                          
                        ),
                      ),
                    ),
                     Container(width: MediaQuery.of(context).size.width*0.4,
                      child: TextFormField(
                        controller: endTimeController,
                        autovalidateMode: AutovalidateMode.always,
                       validator: (value) {
                        endTime = value!;
                         if(endTime.isEmpty){
                          return "enter time";
                         }
                         else if(endTime.length<5){
                          return "Invalid time";
                        }
                       },
                        maxLength: 5,
                        maxLines: 1,
                        inputFormatters: [
                          maskFormatter,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          
          
                          hintText: "18:00",
                          labelText: "End time",
                          
                          
                        ),
                      ),
                    ),
                    
                    
                    
                  ],
                ),
                SizedBox(height: 10,),
          
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                   children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      validator: (dateInput) {
                        if(dateInput!.isEmpty){
                          return "select date";
                        }
                        
                      },
              controller: dateInputController,
              //editing controller of this TextField
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  // icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date" ,
                  prefixIcon:Icon(Icons.calendar_today), //label text of field
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
                    SizedBox(height: 20,),
                    
                    TextFormField(
                      controller: ProjectController,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (value){
                        Project =value!;
                        if(Project.isEmpty){
                          return "please enter field";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                        hintText: "Add Project",
                        labelText: "Projects"
          
                      ),
                    ),
                    SizedBox(height: 18,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    validator:(value) {
                      task = value!;
                          if(task.isEmpty){
                            return "please enter field";
                          }
          
                          
                        },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Task",
                      labelText: "Your Task"
          
                    ),
                  ),
          
                          SizedBox(height: 18,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    validator:(value) {
                      description =value!;
                          if(description.isEmpty){
                            return "please enter feild";
                          }
          
                          
                        },
                    decoration: InputDecoration(
                      
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Task description",
                      labelText: "Dfescription"
          
                    ),
                  ),
          
                   ]
                  ),
                ),
                          
                  ElevatedButton(onPressed: (){
                    print("start--$startTime");
                    print("end--$endTime");
                    print("project--$Project");
                    print("stack$task");
                    print("des$description");
                    print("date${dateInputController.text}");
                    
                    
// &&(endTimeController ==null)&&(ProjectController==null)&&(descriptionController==null)&&(TaskController==null))

                    
                       if((startTime!="")&& (endTime!="")&&(startTime.length>4)&&(endTime.length>4) &&(Project!="")&&(task!="")&&(description!="")&&(dateInputController.text!="")) {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("valid form")));
                      showSnackBar(context, "Task updated Sucessfully...!");
                      print("$startTime");
                      print("$endTime");
                      print("valid form");
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TaskListPage(text: 'text',),));
          
                       }else {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("invalid form")));
                      showSnackBar(context, "Please enter all fields.");

                       }; 
                  },
                  child: Text("Add"),)
                 ], 
                ),
          )
            ,
          
          
        ),
        
        
        
        
      ),
      
    )
    );





  }

  
  
}