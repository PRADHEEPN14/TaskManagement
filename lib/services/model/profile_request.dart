class GoogleLogin_Req {
  String? fullName;
  String? email;

  GoogleLogin_Req({this.fullName, this.email});

  GoogleLogin_Req.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    return data;
  }
}
