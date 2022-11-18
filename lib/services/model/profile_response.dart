class GoogleLogin_Res {
  bool? status;
  String? message;
  Data? data;
  String? token;

  GoogleLogin_Res({this.status, this.message, this.data, this.token});

  GoogleLogin_Res.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  String? fullName;
  String? email;
  String? fcmToken;
  int? user_id;
  int? role_id;

  Data({this.fullName, this.email, this.fcmToken, this.user_id, this.role_id});

  Data.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    fcmToken = json['fcm_token'];
      user_id = json['user_id'];
      role_id = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['fcm_token'] = this.fcmToken;
    data['user_id'] = this.user_id;
    data['role_id'] = this.role_id;
    return data;
  }
}
