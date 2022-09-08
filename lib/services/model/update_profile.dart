class Update_Req {
  String? mobileNo;
  String? designation;
  String? clockifyApiKey;

  Update_Req({this.mobileNo, this.designation, this.clockifyApiKey});

  Update_Req.fromJson(Map<String, dynamic> json) {
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
