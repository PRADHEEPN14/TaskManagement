class Update_Res {
  bool? status;
  String? message;
  Data? data;

  Update_Res({this.status, this.message, this.data});

  Update_Res.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? fullName;
  String? designation;
  String? workExperience;
  String? interests;
  String? email;
  String? mobileNo;
  String? password;
  String? clockifyApiKey;
  String? profilePicture;
  String? clockifyUserId;
  String? userCompany;
  String? userStatus;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.userId,
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
