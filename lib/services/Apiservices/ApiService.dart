// ignore: file_names
// import 'package:bloc_auth/services/model/update_profile_req.dart';
import 'package:bloc_auth/services/model/task_request.dart';
import 'package:bloc_auth/services/model/task_response.dart';
import 'package:bloc_auth/services/model/tasklist_response.dart';
import 'package:bloc_auth/services/model/update_profile_res.dart';
import 'package:dio/dio.dart';



import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile_request.dart';
import '../model/profile_response.dart';
import '../model/project_list.dart';
import '../model/update_profile.dart';

part 'ApiService.g.dart';

// Run this code in termial to generate ApiService.g.dart file
//flutter packages pub run build_runner watch --delete-conflicting-outputs

// @RestApi(baseUrl: 'http://192.168.1.133/daytodaytask/')
@RestApi(baseUrl: 'http://43.204.221.33:8080/daytodaytask/')

abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  
  @POST("app/register")
  Future<GoogleLogin_Res>googlelogin(@Body() GoogleLogin_Req body);

 
  
  @POST('timeEntry/createTimeentry')
  Future<Task_Res>createtask(@Body() Task_Req body);

  @GET("timeEntry/getAlltimeentries")
  Future<GetallTask_Res>alltask();
 

  @PUT("app/updateUser/{userId}")
  Future<GoogleLogin_Res>updateuser(@Path("userId") int userId, @Body() Update_Req body);
  

  @PUT("timeEntry/updateTimeentries?daily_entry_id={dailyTimeId}")
   Future<Task_Res>updatetask(@Path("dailyTimeId") int dailyTimeId, @Body() Task_Req body);


  
  @DELETE("timeEntry/deleteTimeentries?daily_entry_id={dailyTimeId}")
   Future<Task_Res>deletetask(@Path("dailyTimeId") int dailyTimeId);
 


  



  


  

  // @POST("loginUser")
  // Future<LoginRes> login(@Body() LoginReq body);

  // @POST("createUser")
  // Future<RegisterRes>register(@Body() RegisterReq body);

  // @GET("getallUser")
  // Future<AllUser>alluser();

  // @GET("getUser/")
  // Future<LoginRes>aboutme(@Body() body);
  // @DELETE("/posts/{id}")
  // Future<void> deletePost(@Path("id") int postId);

  // @PUT("/posts/{id}")
  // Future<void> UpdatePost(@Path("id") int postId);


  /////////////////////////////////////
////////////////////////////////////////////////////////
  /// Request and Response Body
//////////////////////////////////////////////////////////////////////////////////////////

  static ApiService create() {
    final dio = Dio();
  
     Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('token');
    if (value!.isEmpty) {
      return null;
    } else {
      return value;
    }
    
  }
   
    try {
      print("check");
      dio.interceptors.add(PrettyDioLogger());
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers["Content-Type"] = "application/json";
// "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxNTksImZ1bGxfbmFtZSI6IlNhbWVlbmEgQmVndW0gUyIsImVtYWlsIjoic2FtZWVuYWJlZ3VtLnNAc2tlaW50ZWNoLmNvbSIsImZjbV90b2tlbiI6bnVsbCwiaWF0IjoxNjYyMTE1NjgyLCJleHAiOjE2Njk4OTE2ODIsImlzcyI6Imh0dHBzOi8vd3d3LnNrZWludGVjaC5jb20ifQ.ouyppxsFAQ2ccGeAqdTOlpQHa3IXqZqAtZi1uIpqNOg";
        options.headers["Cookie"] = "x-access-token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxNTksImZ1bGxfbmFtZSI6IlNhbWVlbmEgQmVndW0gUyIsImVtYWlsIjoic2FtZWVuYWJlZ3VtLnNAc2tlaW50ZWNoLmNvbSIsImZjbV90b2tlbiI6bnVsbCwiaWF0IjoxNjYyMTE3NzkwLCJleHAiOjE2Njk4OTM3OTAsImlzcyI6Imh0dHBzOi8vd3d3LnNrZWludGVjaC5jb20ifQ.UoLqptbLbo5pUGbOZ62joLNe-B0bPmP8i5dpW1IfxX4";

        options.followRedirects = false;
        options.validateStatus = (status) {
          return status! < 500;
        };
        return handler.next(options);
      }));

      return ApiService(dio);
    } on DioError catch (error) {
      print("DioError");
      print(error);
      print(error.error);
      return ApiService(dio);
    }
  }
}
