// ignore: file_names
// import 'package:bloc_auth/services/model/update_profile_req.dart';
// ignore_for_file: avoid_print, unused_import

// import 'package:bloc_auth/utils/preference_helper.dart';
import 'package:bloc_auth/services/model/task_request.dart';
import 'package:bloc_auth/services/model/task_response.dart';
import 'package:bloc_auth/services/model/tasklist_response.dart';
import 'package:bloc_auth/services/model/update_profile_res.dart';
import 'package:bloc_auth/utils/utils.dart';
import 'package:dio/dio.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../preference_helper.dart';
import '../model/getupdate_detail_res.dart';
import '../model/profile_request.dart';
import '../model/profile_response.dart';
import '../model/project_list.dart';
import '../model/update_profile.dart';

part 'ApiService.g.dart';

// Run this code in termial to generate ApiService.g.dart file
//flutter packages pub run build_runner watch --delete-conflicting-outputs

// @RestApi(baseUrl: 'http://192.168.1.133/daytodaytask/')
@RestApi(baseUrl: 'http://demo.emeetify.com:8080/daytodaytask/')

abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST("app/register")
  Future<GoogleLogin_Res> googlelogin(@Body() GoogleLogin_Req body);


  @POST('timeEntry/createTimeentry')
  Future<Task_Res> createtask(@Body() Task_Req body);


  @GET("timeEntry/getAlltimeentries")
  Future<GetallTask_Res> alltask();


  @PUT("app/updateUser/{userId}")
  Future<Update_Res> updateuser(
      @Path("userId") int userId, @Body() Update_Req body);


  @PUT("timeEntry/updateTimeentries?daily_entry_id={dailyTimeId}")
  Future<Task_Res> updatetask(
    @Path("dailyTimeId") int dailyTimeId, @Body() Task_Req body);


  @DELETE("timeEntry/deleteTimeentries?daily_entry_id={dailyTimeId}")
  Future<Task_Res> deletetask(@Path("dailyTimeId") int dailyTimeId);

  @GET("app/getUserUpdate/{userId}")
  Future<Userupdate_Res> updatedetail(@Path("userId") int userId);


////////////////////////////////////////////////////////
  /// Request and Response Body
//////////////////////////////////////////////////////////////////////////////////////////

  static ApiService create() {
    final dio = Dio();

    try {
      print("check");
      dio.interceptors.add(PrettyDioLogger());
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        String? token = await PreferenceHelper.getToken();
        
        options.headers["Content-Type"] = "application/json";
        if (token != null) {
          print('yuhjkk------$token');
          options.headers["Cookie"] = "x-access-token=$token";
        
        }
        

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
