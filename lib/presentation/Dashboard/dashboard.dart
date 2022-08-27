// import 'package:bloc_auth/bloc/bloc/auth_bloc.dart';
// import 'package:bloc_auth/bloc/auth/bottom_navigation_bloc/bloc/bottom_navigation_bloc.dart';
// import 'package:bloc_auth/bloc/auth/bottom_navigation_bloc/bloc/bottom_navigation_event.dart';
// import 'package:bloc_auth/bloc/auth/bottom_navigation_bloc/bloc/bottom_navigation_state.dart';
import 'package:bloc_auth/presentation/widgets/bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Getting the user from the FirebaseAuth Instance
    // final user = FirebaseAuth.instance.currentUser!;
    return const SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNaviagate(),
        
        ),
        );
  }
}






































































































































  // body:
        //  BlocListener<AuthBloc, AuthState>(
          
        //   listener: (context, state) {
        //     if (state is UnAuthenticated) {
        //       // Navigate to the sign in screen when the user Signs Out
        //       Navigator.of(context).pushAndRemoveUntil(
        //         MaterialPageRoute(builder: (context) => SignIn()),
        //         (route) => false,
        //       );
        //     }
           
        //   },
        //   child: Container(),
        //   //   
        // ),
        
        
        // BlocBuilder<BottomNavigationBloc,BottomNavigationState>(
        //   builder: (BuildContext context, BottomNavigationState state){
        //     if (state is PageLoading){
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     if(state is TaskPageLoaded){
        //         return TaskPage(text: state.toString());
        //     }
        //     if(state is TaskListPageLoaded){
        //       return TaskListPage(text: state.toString());
        //     }
        //                return Container();
        //   }
        //   ),



        
          
          
          // child: Container(),
        // child: Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         'Email: \n ${user.email}',
          //         style: const TextStyle(fontSize: 24),
          //         textAlign: TextAlign.center,
          //       ),
          //       user.photoURL != null
          //           ? Image.network("${user.photoURL}")
          //           : Container(),
          //       user.displayName != null
          //           ? Text("${user.displayName}")
          //           : Container(),
          //       const SizedBox(height: 16),
                
                
              
          //     ],
          //   ),
            
          // ),
          
         
        
       
        // // bottomNavigationBar: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        // //   builder:(BuildContext context,BottomNavigationState state) {
        // //     return BottomNavigationBar(
        // //       currentIndex: context.select((BottomNavigationBloc bloc)=> bloc.currentIndex),
        // //       items: const<BottomNavigationBarItem>[
        // //          BottomNavigationBarItem(
        // //       icon: Icon(Icons.home, color: Colors.black),
        // //       label: 'First',
        // //     ),
        // //     BottomNavigationBarItem(
        // //       icon: Icon(Icons.all_inclusive, color: Colors.black),
        // //       label: 'Second',
        // //     ),
        // //     ],
        // //     // onTap: (index)=> context.read<BottomNavigationBloc>().add(PageLoading()),
        // //     );
        // //   }
        //   ),


         // drawer: Drawer(
        //   child: Column(
          
        //     children: [
        //       UserAccountsDrawerHeader(accountName: Text("${user.email}"), accountEmail: Text("${user.displayName}"),
        //       otherAccountsPictures: [
        //         user.photoURL != null
        //         ? Image.network("${user.photoURL}")
        //         :Container(),

                
        //         ],
        //       otherAccountsPicturesSize: Size.square(85),
              
        //       ),
        //       Divider(height: 10,),
               
        //       ListTile(
        //         leading: Icon(Icons.supervised_user_circle,size: 30,color: Color(0xFF040BCB),),
        //         title: Text("Profile",style: TextStyle(color: Color(0xFF212121),fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 18),),
        //         onTap:() =>  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>AddInfoPage() ,)),
        //       ),
        //       Divider(height: 10,),
        //       // ListTile(
        //       //   leading: Icon(Icons.list_sharp,size: 30,color: Color(0xFF040BCB),),
        //       //   title: Text("Task List",style: TextStyle(color: Color(0xFF212121),fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,fontSize: 18),),
                
        //       // ),
        //       Divider(height: 10,),
        //       SizedBox(
        //          child: Padding(
        //            padding: const EdgeInsets.only(left: 5),
        //            child: ElevatedButton(
        //               child: const Text('Sign Out'),
        //               onPressed: () {
        //                // Signing out the user
        //                  context.read<AuthBloc>().add(SignOutRequested());
        //             },
        //             ),
        //          ),
        //        ),

        //     ],
        //         ),
        //   ),
