class AllProjects {
  bool? status;
  String? message;
  List<Data>? data;

  AllProjects({this.status, this.message, this.data});

  AllProjects.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? projectTitle;

  Data({this.projectTitle});

  Data.fromJson(Map<String, dynamic> json) {
    projectTitle = json['project_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_title'] = this.projectTitle;
    return data;
  }
}
