class RegistrationModel {
  final String fullname;
  final String username;
  final String passwd;
  final String phoneNo;

  RegistrationModel({this.fullname, this.username, this.passwd, this.phoneNo});

  Map<String, dynamic> toJSON() => {
    "fullname": fullname,
    "username": username,
    "passwd": passwd,
    "phone_no": phoneNo
  };
}

class RegistrationOtpModel {
  final String username;
  final String otp;

  RegistrationOtpModel({this.username, this.otp});

  Map<String, dynamic> toJSON() => {
    "username": this.username,
    "otp": this.otp
  };
}