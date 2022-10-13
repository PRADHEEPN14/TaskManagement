// import 'package:email_validator/email_validator.dart';

// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print


// import 'package:bloc_auth/utils/preference_helper.dart';
import 'package:bloc_auth/presentation/widgets/bottom_navigationbar.dart';
// import 'package:bloc_auth/services/model/update_profile_req.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../preference_helper.dart';
import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';

import '../../services/model/update_profile.dart';

class AddInfoPage extends StatefulWidget {
  const AddInfoPage({Key? key}) : super(key: key);

  @override
  State<AddInfoPage> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfoPage> {

  var email;
  var Apikey;
  var userRole;
  var mobilenum;

  var upemail;
  String? upApikey;
  String? upRole;
  String? upmobilenum;

  String? selectedValue;

  TextEditingController emailController = TextEditingController();
  TextEditingController userRoleController = TextEditingController();
  TextEditingController mobilenumController = TextEditingController();
  TextEditingController ApikeyController = TextEditingController();
  int? userId;
  String? userToken;



  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  final _dropdownFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getUserId();
    print('role---$upRole');
         print('num--$upmobilenum');
         print('key---$upApikey');
        //  setState(() {
        //    update_value();
        //  });

    // selectedValue =upRole;
    // mobilenumController.text =upmobilenum!;
    // ApikeyController.text =upApikey!;
  }

  update_value(){
    if(upRole !=null && upApikey !=null && upApikey !=0){
    selectedValue =upRole;
    mobilenumController.text =upmobilenum!;
    ApikeyController.text =upApikey!;
    }
  }

// user id function here....get from sharedpreferense..
  getUserId() async {
    userId = await PreferenceHelper.getUserId();
    print("userid--$userId");
  }
// token function here.... get from sharedpreferense..
  getToken() async {
    userToken = await PreferenceHelper.getToken();
    print('userToken');
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (BuildContext context) {
            return AddInfoPage(context);
          }),
        ));
  }

  AddInfoPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Additional Infomation')),
          backgroundColor: Colors.deepPurple,
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(15.0))),
        ),
        body: Form(
          key: _dropdownFormKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // decoration: const BoxDecoration(
              //           gradient: LinearGradient(colors: [Color(0xFFF8F8F6),Color(0xFFDF60F6)],
              //           begin: Alignment.topRight, end: Alignment.bottomCenter)),
                child: SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            disabledBorder: UnderlineInputBorder(),
                            labelText: 'Your Role',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 29, 6, 111),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          hint: const Text("Select Your role"),
                          borderRadius: BorderRadius.circular(10),
                          validator: (selectedValue) =>selectedValue == null ? "select Role" : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          isExpanded: true,
                          // value: selectedValue,
                          items: dropdownItems,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                            //  print(selectedValue);
                          },
                        ),
                      ),
                      const Divider(height: 35),
                      SizedBox(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLength: 10,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                          controller: mobilenumController,
                          validator: (value) =>mobilenumController.text.length < 10? "enter valid num": null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'Mobile',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 29, 6, 111),
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                            border: OutlineInputBorder(),
                            hintText: 'Mobile',
                          ),
                        ),
                      ),
                      // const Divider(height: 25),
                      SizedBox(height: 48,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 300),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                            
                            children:[ IconButton(onPressed: ()
                          {
                            showDialog(context: context, builder: (BuildContext context){
                                  return   const AlertDialog(
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                  title: Text('Clockify API Key',textAlign: TextAlign.center,style: TextStyle(wordSpacing: 2,fontSize: 18),),
                                  content: Text("Go to ->  Clockify website --> Profile settings -->  Generate API then Copy paste that field",
                                  style: TextStyle(wordSpacing: 2,color: Colors.grey,fontSize: 14)),
                                  );
                                    
                        
                          });
                          },
                           icon: const Icon(Icons.question_mark_sharp,color: Colors.grey,),
                           iconSize: 16),]),
                        ),
                      ),
                      SizedBox(
                        child: TextFormField(
                          // inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          controller: ApikeyController,
                          validator: (value)=> ApikeyController.text.isEmpty||ApikeyController.text==null||ApikeyController.text.length<10? 'Please enter Valid Api key': null,
                          decoration: const InputDecoration(
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 29, 6, 111),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                              border: OutlineInputBorder(),
                              hintText: "API key",
                              labelText: "Key"
                              ),
                        ),
                      ),
                      const Divider(height: 45),
                      ElevatedButton(
                        onPressed: () async {
                           _launchURL('app.clockify.me');
                         },
                        child:  const Text('Get API Here..'),
                      ),
                      const Divider(height: 25),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            print("Role--$selectedValue");
                            print("number--${mobilenumController.text.length}");
                            print("APIKEY--${ApikeyController.text}");
                            print("userID--$userId");
                            if ((ApikeyController.text != '') &&
                                (mobilenumController.text.length == 10) &&
                                (selectedValue != null)) {
                            //update user function here...
                              updateuser(context);
                            } else {
                              showSnackBar(
                                  context, "Please enter the all fields..");                           
                            }
                          },
                          child: const Text('Submit'),
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.redAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


 //<<<<<<< updateUser API function here...>>>>

  void updateuser(context) {
    print(userId);
    Update_Req updateData = Update_Req();
    updateData.mobileNo = mobilenumController.text;
    updateData.designation = selectedValue;
    updateData.clockifyApiKey = ApikeyController.text;
    var api = Provider.of<ApiService>(context, listen: false);
    api.updateuser(userId!, updateData).then((response) {
      print(response);
      if (response.status == true) {
         upmobilenum = response.data!.mobileNo;
         upRole = response.data!.designation;
         upApikey= response.data!.clockifyApiKey;
         print(upRole);
         print(upmobilenum);
         print(upApikey);
        showSnackBar(context, "${response.message}");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNaviagate(screenindex: 1),));
        // mobile= response.data.
      }
      //  print(object)
    });
  }
  
  
  // dropdown list function here...
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("Angular",selectionColor: Colors.black,),
          value: "Angular"),
          const DropdownMenuItem(child: Text("Flutter"), value: "Flutter"),
          const DropdownMenuItem(
          child: Text("Backend-devloper"), value: "Backend-devloper"),
          const DropdownMenuItem(child: Text("Tester"), value: "Tester"),
          const DropdownMenuItem(child: Text("React"), value: "React"),
        ];
    return menuItems;
  }

// snackbar style here....
  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Color(0xFFED4B1E),
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
// snackbar style end here....



// <<<<<<<<<< _launchURL function here... >>>>>>>

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not launch url";
    }
  }
}
