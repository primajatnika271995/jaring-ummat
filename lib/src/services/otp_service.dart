import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';

import 'package:http/http.dart' as http;
import 'package:otp/otp.dart';

class OtpServices {
  Future<http.Response> smsOtp() async {
    Map<String, String> headers = {
      'Authorization':
      'Basic QUM5YzdjMjk0N2M0ZDU1MGZmOGFjNzQwZmU0MmFmYTVjZDphNDJiNmY3MWRmODA3NTJjMDk1ZmFjMzkyZWQxYzNlOA=='
    };

    var body = {'To': '', 'From': '+12024100126', 'Body': ''};

    return await http.post(
        'https://api.twilio.com/2010-04-01/Accounts/AC9c7c2947c4d550ff8ac740fe42afa5cd/Messages.json',
        headers: headers,
        body: body);
  }

  void emailOtp(String emailTo, String otpKey) async {
    // Email Sender Information
    String username = "dis@tabeldata.com";
    String password = "0fm6lyn9cjph";

    // Var Date Formatting
    var hour = new DateFormat().add_Hm().format(new DateTime.now());
    var day = new DateFormat().add_d().format(new DateTime.now());
    var month = new DateFormat().add_MMM().format(new DateTime.now());
    var year = new DateFormat().add_y().format(new DateTime.now());
    String date = '$hour $day-$month-$year';

    final smtpServer = SmtpServer('mail.tabeldata.com',
        username: username, password: password, port: 26, ssl: false);

    final message = new Message()
      ..from = new Address(username, 'Mitra Jaring Ummat OTP')
      ..recipients.add(emailTo)
    // ..ccRecipients.addAll(['braveavi.2@gmail.com', 'braveavi.2@gmail.com'])
    // ..bccRecipients.add(new Address('braveavi.2@gmail.com'))
      ..subject = 'Mitra Jaring Ummat Registration :: $date'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "Your OTP Code : <h1> $otpKey </h1>\n<p>If you are having any issues with your Account, please don\'t hesitate to contact us by replying to this email\n \n <p>Thank!";

    send(message, smtpServer);
    print('Emailing To $emailTo');
    print('Receive OTP Code : $otpKey');
  }

  otpGenarator(String emailTo) {
    var otpRefrence = emailTo + DateTime.now().toIso8601String();
    // Generating OTP Code
    var otpKey = OTP.generateHOTPCode(otpRefrence, 300, length: 6);

    print('Generated OTP Code : $otpKey');
    return otpKey;
  }

}
