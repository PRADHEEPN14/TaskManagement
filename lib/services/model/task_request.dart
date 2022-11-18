class Task_Req {
  String? clockifyProjectId;
  String? clockifyTaskId;
  String? startedDate;
  String? startTime;
  String? cal_startTime;
  String? cal_endTime;
  String? endTime;
  String? taskDescription;

  Task_Req(
      {this.clockifyProjectId,
      this.clockifyTaskId,
      this.startedDate,
      this.startTime,
      this.cal_startTime,
      this.cal_endTime,
      this.endTime,
      this.taskDescription});

  Task_Req.fromJson(Map<String, dynamic> json) {
    clockifyProjectId = json['clockify_project_id'];
    clockifyTaskId = json['clockify_task_id'];
    startedDate = json['started_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    cal_endTime =json['cal_end_time'];
    cal_startTime =json['cal_start_time'];
    taskDescription = json['task_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clockify_project_id'] = this.clockifyProjectId;
    data['clockify_task_id'] = this.clockifyTaskId;
    data['started_date'] = this.startedDate;
    data['start_time'] = this.startTime;
    data['cal_start_time'] = this.cal_startTime;
    data['end_time'] = this.endTime;
    data['cal_end_time'] = this.cal_endTime;
    data['task_description'] = this.taskDescription;
    return data;
  }
}
