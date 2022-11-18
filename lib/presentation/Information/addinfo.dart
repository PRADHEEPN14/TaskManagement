// import 'package:email_validator/email_validator.dart';

// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print


// import 'package:bloc_auth/utils/preference_helper.dart';
import 'package:bloc_auth/presentation/widgets/bottom_navigationbar.dart';
import 'package:bloc_auth/presentation/widgets/floatingbutton.dart';
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
  var ctx;

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
    print('hello');
    WidgetsBinding.instance.addPostFrameCallback((_) => updatedetail1());
    getUserId();
    print("checkk$userId");
    setState((){
      // mobilenumController.text= mobilenum!;
      // userRoleController.text= userRole!;
      // ApikeyController.text=Apikey!;
    });
  }

// user id function here....get from sharedpreferense..
  getUserId() async {
    userId = await PreferenceHelper.getUserId();
    // print("userid--$userId");
  }
// token function here.... get from sharedpreferense..
  getToken() async {
    userToken = await PreferenceHelper.getToken();
    // print('userToken');
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => ApiService.create(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Builder(builder: (context) {
            return AddInfoPage(context);
          }),
        ));
  }

  AddInfoPage(BuildContext context) {
    ctx =context;
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
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.all(28.0),
                  child: Column(
                    children: [
                      // DropdownButtonHideUnderline(
                      //   child: DropdownButtonFormField(
                      //     decoration: const InputDecoration(
                      //       border: OutlineInputBorder(),
                      //       disabledBorder: UnderlineInputBorder(),
                      //       labelText: 'Your Role',
                      //       labelStyle: TextStyle(
                      //           color: Color.fromARGB(255, 29, 6, 111),
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: 20),
                      //     ),
                      //     hint: const Text("Select Your role"),
                      //     borderRadius: BorderRadius.circular(10),
                      //     validator: (selectedValue) =>selectedValue == null ? "select Role" : null,
                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                      //     isExpanded: true,
                      //     // value: selectedValue,
                      //     items: dropdownItems,
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         selectedValue = newValue!;
                      //       });
                      //       //  print(selectedValue);
                      //     },
                      //   ),
                      // ),
                      // const Divider(height: 35),
                      Padding(
                        padding: const EdgeInsets.only(right: 280,top: 10),
                        child: SizedBox(child: Text("Mobile No:",textAlign: TextAlign.left)),
                      ),
                      SizedBox(
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLength: 10,
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                          controller: mobilenumController,
                          validator: (value) =>mobilenumController.text.length < 10? "enter valid number": null,
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
                      // SizedBox(height: 48,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 290),
                      //     child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                            
                      //       children:[ IconButton(onPressed: ()
                      //     {
                      //       showDialog(context: context, builder: (BuildContext context){
                      //             return    AlertDialog(
                      //             backgroundColor: Colors.white,
                      //             elevation: 80,
                      //             title: Text('Clockify API Key',textAlign: TextAlign.center,style: TextStyle(wordSpacing: 2,fontSize: 18,color: Colors.blue),),
                      //             content: Padding(
                      //               padding: const EdgeInsets.only(top: 10),
                      //               child: Text("Go to >>  Clockify website >> Profile settings >>  Generate API then Copy paste that field",
                      //               style: TextStyle(wordSpacing: 3,color: Colors.grey,fontSize: 14)),
                      //             ),
                      //             );
                      //     });
                      //     },
                      //      icon: const Icon(Icons.help_rounded,color: Colors.grey,),
                      //      iconSize: 18),]),
                      //   ),
                      // ),
                      SizedBox(child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("API Key:",textAlign: TextAlign.left),
                            IconButton(onPressed: ()
                          {
                            showDialog(context: context, builder: (BuildContext context){
                                  return    AlertDialog(
                                  backgroundColor: Colors.white,
                                  elevation: 80,
                                  title: Text('Clockify API Key',textAlign: TextAlign.center,style: TextStyle(wordSpacing: 2,fontSize: 18,color: Colors.blue),),
                                  content: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("Go to >>  Clockify website >> Profile settings >>  Generate API then Copy paste that field",
                                    style: TextStyle(wordSpacing: 3,color: Colors.grey,fontSize: 14)),
                                  ),
                                  );
                          });
                          },
                           icon: const Icon(Icons.help_rounded,color: Colors.grey,),
                           iconSize: 18)
                      
                          ],
                        ),
                      )),
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
                         await showDialog(context: context, builder: (BuildContext context){
                                  return  AlertDialog(
                                    actions: [
                                      TextButton(onPressed: (){
                                        _launchURL('app.clockify.me');
                                        Navigator.of(context).pop();
                                      }, child: Text("OK"))
                                    ],
                                  backgroundColor: Colors.black87,
                                  elevation: 20,
                                  title: Text('Clockify API Key',textAlign: TextAlign.center,style: TextStyle(wordSpacing: 2,fontSize: 18,color: Colors.blue)),
                                  content: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text("Go to -->  Clockify website --> Profile settings -->  Generate API then Copy Paste that field",
                                    style: TextStyle(wordSpacing: 5,color: Colors.white,fontSize: 14)),
                                  )
                                  );
                          });
                         },
                        child:  const Text('Get API Here..'),
                      ),
                      const Divider(height: 25),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            print("pressed the button");
                            updatedetail1();
                            // print("Role--$selectedValue");
                            // print("number--${mobilenumController.text.length}");
                            // print("APIKEY--${ApikeyController.text}");
                            print("userID--$userId");
                            if ((ApikeyController.text != '') &&
                                (mobilenumController.text.length == 10)) {
                            //update user function here...
                              updateuser(context);
                            } else {
                              errshowSnackBar(
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
        floatingActionButton: FActionbutton()
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
      if (response.status == true) {
        //  print(upRole);
        //  print(upmobilenum);
        //  print(upApikey);
        showSnackBar(context, "${response.message}");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => BottomNaviagate(screenindex: 1),));
        // mobile= response.data.
      }else{
        errshowSnackBar(context, "${response.message}");
      }
      //  print(object)
    });
  }

  void updatedetail1(){
    print('worked');
    print("apiiiiiiiii**$userId");
    var api= Provider.of<ApiService>(ctx!, listen: false);
      print('-----before date-----');
    api.updatedetail(userId!).then((response){
      print('Api called');
      print("apiiiiiiiii$userId");
      if(response.status == true){
      userRole  = response.data!.designation!;
      mobilenum = response.data!.mobileNo!;
      Apikey = response.data!.clockifyApiKey!;
      print('-----after date-----');
      print(userRole);
      print(mobilenum);
      print(Apikey);
      }
      

    });
  }
  
  
  // dropdown list function here...
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("HR",selectionColor: Colors.black,),
          value: "HR"),
          const DropdownMenuItem(child: Text("Manager"), value: "Manager"),
          const DropdownMenuItem(
          child: Text("Employee"), value: "Employee"),
          // const DropdownMenuItem(child: Text("Tester"), value: "Tester"),
          // const DropdownMenuItem(child: Text("React"), value: "React"),
        ];
    return menuItems;
  }

// snackbar style here....
  void errshowSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Color(0xFFED4B1E),
      behavior: SnackBarBehavior.floating,
      width: 330,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
