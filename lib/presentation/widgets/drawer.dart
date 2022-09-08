import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../Information/addinfo.dart';
import '../SignIn/sign_in.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return  Drawer(
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
      );
    
  }
}