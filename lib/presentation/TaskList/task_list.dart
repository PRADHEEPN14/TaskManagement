import 'package:bloc_auth/presentation/widgets/drawer.dart';
import 'package:bloc_auth/services/model/tasklist_response.dart';
import 'package:flutter/material.dart';

import '../../services/Apiservices/ApiService.dart';
import 'package:provider/provider.dart';

import '../EditTaskPage/edittask.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  var ctx;
//  late int dailyEntryId;
 

  List<Data>? AllTask;
   void initState() {
    // TODO: implement initState
    super.initState();
    // alltask();
    WidgetsBinding.instance.addPostFrameCallback((_)=> alltask());
  }

  @override
  Widget build(BuildContext context) {
     return Provider<ApiService>(create: (context) => ApiService.create(),
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (BuildContext newContext){
        return TaskList(newContext);
      })
    ),);
  }
  TaskList(BuildContext newContext) {
    ctx = newContext;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Center(child:  Text('TaskList')),
            backgroundColor: Colors.redAccent,
            shape:const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0))),
            
          ),
        body:ListView.builder(
        
        itemCount: AllTask!.length,
        itemBuilder: ((context, i) {  

         
          // Using CARD design...
          return Card(elevation: 3,
          surfaceTintColor: Colors.blue,
          
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
            shadowColor: Color.fromARGB(255, 122, 168, 206),
            child: ListTile(
              trailing: PopupMenuButton(
                onSelected: (value)async{
                if(value ==1){
                   await edittask(AllTask![i].dailyEntryId!, AllTask![i].startTime,AllTask![i].endTime,AllTask![i].startedDate,AllTask![i].clockifyProjectId,AllTask![i].clockifyTaskId,AllTask![i].taskDescription, );
                  }
                  else if(value ==2){
                    deletetask(AllTask![i].dailyEntryId!);
                  }
                  
                },

                itemBuilder:(context) => [
                const  PopupMenuItem(
                    child: Text("Edit"),
                    value: 1,
                    
                  ),
                 const PopupMenuItem(
                  
                    child: Text("Delete"),
                    value: 2,
                  ),
               
                ]
                
            ),
            // trailing: IconButton(onPressed: (){},
            // icon: Icon(Icons.more_vert)),
            title: Text('${AllTask![i].taskDescription}',style:const TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text('${AllTask![i].createdAt}',style:const TextStyle(color: Color.fromARGB(255, 139, 139, 138,),fontSize: 13)),
            leading: Text('${i}'),
            ),
            );
        }
        )
      ),
        // drawer: MyDrawer(),
      ),
    );
      

    
  }

  edittask(int dailyTimeId,startTime,  endtime,startdate, projectlist, tasklist,taskdecript){
    print('cdcdcd$AllTask');
    print("kndvfv--$dailyTimeId");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditTaskPage(dailyTimeId: dailyTimeId, startTime: startTime, endTime: endtime,startedDate: startdate,projectlist: projectlist,taskList: tasklist,taskdescript: taskdecript,)));
  }

   alltask(){
    final api = Provider.of<ApiService>(ctx! , listen: false);
    api.alltask().then((response){
      
      if(response.status == true){
        
        if(mounted){
           setState(() {
          AllTask = response.data!;
          
        });
        
       
        }
      }
    }).catchError((onError){
      print(onError.toString());
    });
  }

  void deletetask(int dailyEntryId){ 
  var api = Provider.of<ApiService>(ctx!, listen: false);
  //  print('update id1-'$dailyEntryId);
  api.deletetask(dailyEntryId).then((response){
 });
  print('delete id--$dailyEntryId');
}

}