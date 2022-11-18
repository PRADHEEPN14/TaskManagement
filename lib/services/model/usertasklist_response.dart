import 'package:bloc_auth/services/model/datesearch_response.dart';

class UsertaskList_Res {
  bool? status;
  String? message;
  List<UserData>? data;

  UsertaskList_Res({this.status, this.message, this.data});

  UsertaskList_Res.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserData>[];
      json['data'].forEach((v) {
        data!.add(new UserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  int? dailyEntryId;
  int? userId;
  String? clockifyUserId;
  String? clockifyProjectId;
  String? clockifyTaskId;
  String? clockifyTimeentryId;
  String? clockifyWorkspaceId;
  int? clockifyTagId;
  String? startTime;
  String? taskDescription;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  String? startedDate;
  String? mobileNo;
  String? projectName;
  String? taskName;
  String? workingHours;

  UserData(
      {this.dailyEntryId,
      this.userId,
      this.clockifyUserId,
      this.clockifyProjectId,
      this.clockifyTaskId,
      this.clockifyTimeentryId,
      this.clockifyWorkspaceId,
      this.clockifyTagId,
      this.startTime,
      this.taskDescription,
      this.endTime,
      this.createdAt,
      this.updatedAt,
      this.startedDate,
      this.mobileNo,
      this.projectName,
      this.taskName,
      this.workingHours});

  UserData.fromJson(Map<String, dynamic> json) {
    dailyEntryId = json['daily_entry_id'];
    userId = json['user_id'];
    clockifyUserId = json['clockify_user_id'];
    clockifyProjectId = json['clockify_project_id'];
    clockifyTaskId = json['clockify_task_id'];
    clockifyTimeentryId = json['clockify_timeentry_id'];
    clockifyWorkspaceId = json['clockify_workspace_id'];
    clockifyTagId = json['clockify_tag_id'];
    startTime = json['start_time'];
    taskDescription = json['task_description'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    startedDate = json['started_date'];
    mobileNo = json['mobile_no'];
    projectName = json['project_name'];
    taskName = json['task_name'];
    workingHours = json['workingHours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['daily_entry_id'] = this.dailyEntryId;
    data['user_id'] = this.userId;
    data['clockify_user_id'] = this.clockifyUserId;
    data['clockify_project_id'] = this.clockifyProjectId;
    data['clockify_task_id'] = this.clockifyTaskId;
    data['clockify_timeentry_id'] = this.clockifyTimeentryId;
    data['clockify_workspace_id'] = this.clockifyWorkspaceId;
    data['clockify_tag_id'] = this.clockifyTagId;
    data['start_time'] = this.startTime;
    data['task_description'] = this.taskDescription;
    data['end_time'] = this.endTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['started_date'] = this.startedDate;
    data['mobile_no'] = this.mobileNo;
    data['project_name'] = this.projectName;
    data['task_name'] = this.taskName;
    data['workingHours'] = this.taskName;
    return data;
  }
}
