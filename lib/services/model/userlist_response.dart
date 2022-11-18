class userList_res {
  bool? status;
  String? message;
  List<Data>? data;

  userList_res({this.status, this.message, this.data});

  userList_res.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? roleId;
  String? fullName;
  String? designation;
  String? workExperience;
  Null? interests;
  String? email;
  String? mobileNo;
  Null? password;
  String? clockifyApiKey;
  Null? profilePicture;
  Null? clockifyUserId;
  String? userCompany;
  Null? userStatus;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.userId,
      this.roleId,
      this.fullName,
      this.designation,
      this.workExperience,
      this.interests,
      this.email,
      this.mobileNo,
      this.password,
      this.clockifyApiKey,
      this.profilePicture,
      this.clockifyUserId,
      this.userCompany,
      this.userStatus,
      this.fcmToken,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
    fullName = json['full_name'];
    designation = json['designation'];
    workExperience = json['work_experience'];
    interests = json['interests'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    password = json['password'];
    clockifyApiKey = json['clockify_api_key'];
    profilePicture = json['profile_picture'];
    clockifyUserId = json['clockify_user_id'];
    userCompany = json['user_company'];
    userStatus = json['user_status'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['full_name'] = this.fullName;
    data['designation'] = this.designation;
    data['work_experience'] = this.workExperience;
    data['interests'] = this.interests;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['password'] = this.password;
    data['clockify_api_key'] = this.clockifyApiKey;
    data['profile_picture'] = this.profilePicture;
    data['clockify_user_id'] = this.clockifyUserId;
    data['user_company'] = this.userCompany;
    data['user_status'] = this.userStatus;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
