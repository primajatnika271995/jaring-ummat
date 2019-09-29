import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:http/http.dart' as http;

class SmsOtpProvider {
  final String userKey = "e5akyw";
  final String passwordKey = "7b4wkanoxu";

  Future<http.Response> postSMSOtp(String contact, String otpCode) async {
    Uri uri = Uri.parse(OTP_SMS_URL);

    var params = {
      "userkey": userKey,
      "passkey": passwordKey,
      "nohp": "0$contact",
      "kode_otp": otpCode,
    };
    final uriParams = uri.replace(queryParameters: params);
    return await http.get(uriParams);
  }
}
