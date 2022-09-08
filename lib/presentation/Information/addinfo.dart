// import 'package:email_validator/email_validator.dart';
import 'package:bloc_auth/preference_helper.dart';
// import 'package:bloc_auth/services/model/update_profile_req.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';

import '../../services/model/update_profile.dart';



class AddInfoPage extends StatefulWidget {
  const AddInfoPage({Key? key}) : super(key: key);

  @override
  State<AddInfoPage> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfoPage> {
  List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Angular",selectionColor: Colors.black,),value: "Angular"),
    const DropdownMenuItem(child: Text("Flutter"),value: "Flutter"),
    const DropdownMenuItem(child: Text("Backend-devloper"),value: "Backend-devloper"),
    const DropdownMenuItem(child: Text("Tester"),value: "Tester"),
    const DropdownMenuItem(child: Text("React"),value: "React"),


  ];
  return menuItems;
}

  var email;
  var Apikey;
  var userRole;
  var mobilenum;


String? selectedValue;

  TextEditingController emailController = TextEditingController();
  TextEditingController userRoleController = TextEditingController();
  TextEditingController mobilenumController = TextEditingController();
  TextEditingController ApikeyController = TextEditingController();
  int? userId;
  String? userToken;


  void showSnackBar(BuildContext context,String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Color(0xFFED4B1E),
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  final _dropdownFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();    
  }

  getUserId()async{
    
        userId = await PreferenceHelper.getUserId();  
  print("userid--$userId");
  
  }
  getToken()async{
    userToken = await PreferenceHelper.getToken();
    print('userToken');
  }
  
  @override
  Widget build(BuildContext context) {

     return Provider(create: (context) => ApiService.create(),
    child: Scaffold(
    resizeToAvoidBottomInset: false,
      body: Builder(builder: (BuildContext context) {
        return AddInfoPage(context);
      }),
         )
       );
        
  }
   AddInfoPage (BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title:const Center(child:  Text('Update profile')),
            backgroundColor: Colors.redAccent,
            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0))),
            
          ),
          body:Form(
            key: _dropdownFormKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
             
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      
                    
                     DropdownButtonHideUnderline(
                       child: DropdownButtonFormField(
                        
                         
                         decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                           enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                         ),
                         hint: const Text("Select Your role"),
                         borderRadius: BorderRadius.circular(10),
                           validator:(selectedValue)=>selectedValue == null? "select Role":null,
                           autovalidateMode: AutovalidateMode.always,
                           
                           
                           isExpanded: true,
                           // value: selectedValue,
                           items: dropdownItems, 
                           onChanged: (String? newValue){
                           setState(() {
                         selectedValue = newValue!;
                         });
                        //  print(selectedValue);
                     },),
                      ),
                  const Divider(height: 25),
                      SizedBox(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLength: 10,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                          controller: mobilenumController,
                          validator: (value) => mobilenumController.text.length<10 ?"enter valid num":null,
                          autovalidateMode: AutovalidateMode.always,
                          
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Mobile',
                            
                          ),
                        ),
                      ),
                     const Divider(height: 25),
                      SizedBox(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: ApikeyController,
                          validator: (value) => Apikey,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "API key",
                            labelText: "Key",
                            fillColor: Colors.yellowAccent
                          ),
                        ),
                      ),
                      const Divider(height: 25),
                      RichText(textAlign: TextAlign.left,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: "Get API key  "
                                  ),
                                   TextSpan(
                                    style:const  TextStyle(color: Color(0xFF0010F7),
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                                     text: "Click here",
                                      recognizer: TapGestureRecognizer()..onTap =  () async{
                      var url = "https://app.clockify.me/user/settings";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                                      }
                                  ),
                                ]
                            )),
                      const Divider(height: 25),
                      SizedBox(
                        child: ElevatedButton(onPressed: (){
                          
                            
                        
                          // ignore: avoid_print
                          // print(emailController.text);
                          print("End--${selectedValue}");
                          print("num1--${mobilenumController.text.length}");
                          print("userID--$userId");
                            
                            if((ApikeyController.text!='')&&(mobilenumController.text.length==10)&&(selectedValue !=null)){
                            showSnackBar(context, "Task updated Sucessfully...!");
                            updateuser(context);
                            print("num-3-${mobilenumController.text.length}");
                          }
                          //  else if(mobilenumController.text.length<10){
                          //   print("num-2-${mobilenumController.text.length}");
                          //   showSnackBar(context, "mobile num not valid");
                          // }                       
                          else{
                            showSnackBar(context, "Please enter the all fields..");
                            print("num4--${mobilenumController.text.length}");
                          }
                          
                        }, child: const Text('Submit'),
                        style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.redAccent),),
                      ),
                     
                    ],
                  ),
                ),
              ),
            ),
            
          ),
      
    
      ),
    );
    
  }

  void updateuser(context){
    print(userId);
    Update_Req updateData = Update_Req();
     updateData.mobileNo = mobilenumController.text;
     updateData.designation = selectedValue;
     updateData.clockifyApiKey = ApikeyController.text;
    var api = Provider.of<ApiService>(context, listen: false);
    api.updateuser(userId!,updateData).then((response){
     print(response);
    //  print(object)
    }
    );
  }
 

}