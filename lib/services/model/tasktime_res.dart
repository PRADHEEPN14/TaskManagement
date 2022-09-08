class GetallTaskTime_Res {
  bool? status;
  String? message;
  Data? data;

  GetallTaskTime_Res({this.status, this.message, this.data});

  GetallTaskTime_Res.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? dailyEntryId;
  int? userId;
  String? clockifyUserId;
  String? clockifyProjectId;
  String? clockifyTaskId;
  String? clockifyTimeentryId;
  String? clockifyWorkspaceId;
  Null? clockifyTagId;
  String? startTime;
  String? taskDescription;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  String? startedDate;

  Data(
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
      this.startedDate});

  Data.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
