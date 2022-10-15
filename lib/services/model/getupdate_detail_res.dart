class Userupdate_Res {
  bool? status;
  String? message;
  Data? data;

  Userupdate_Res({this.status, this.message, this.data});

  Userupdate_Res.fromJson(Map<String, dynamic> json) {
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
  String? mobileNo;
  String? designation;
  String? clockifyApiKey;

  Data({this.mobileNo, this.designation, this.clockifyApiKey});

  Data.fromJson(Map<String, dynamic> json) {
    mobileNo = json['mobile_no'];
    designation = json['designation'];
    clockifyApiKey = json['clockify_api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile_no'] = this.mobileNo;
    data['designation'] = this.designation;
    data['clockify_api_key'] = this.clockifyApiKey;
    return data;
  }
}

