import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/services/loginApi.dart';
import 'package:flutter_jaring_ummat/src/services/otp_service.dart';
import 'package:flutter_jaring_ummat/src/services/smsOtpApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/sosial_media_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_register/step2.dart';

class StepOne extends StatefulWidget {
  @override
  _StepOneState createState() => _StepOneState();
}

class _StepOneState extends State<StepOne> {
  final String appName = 'Jejaring';
  final String logoUrl = 'assets/icon/logo_muzakki_jejaring.png';

  final _contactCtrl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _otpServices = new OtpServices();

  SmsOtpProvider smsProvider = new SmsOtpProvider();

  @override
  Widget build(BuildContext context) {
    final widgetLogo = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Container(
        child: Image.asset(logoUrl, scale: 40.0),
      ),
    );

    final widgetAppName = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        appName,
        style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
      ),
    );

    final widgetContactName = Padding(
      padding: EdgeInsets.only(top: 60),
      child: const Text(
        'Masuk dengan nomor telepon',
        style: TextStyle(color: Colors.black54),
      ),
    );

    final widgetSocialLoginName = Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: const Text(
        'atau buat akun dengan media sosial',
        style: TextStyle(color: Colors.black54),
      ),
    );

    final widgetSocialMedia = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.facebook),
            iconSize: 40.0,
            color: facebookColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.google),
            iconSize: 40.0,
            color: googleColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.linkedin),
            iconSize: 40.0,
            color: linkedInColor,
          ),
        ],
      ),
    );

    final widgetContactField = Padding(
      padding: EdgeInsets.only(top: 10.0, left: 60.0, right: 60.0),
      child: Stack(
        children: <Widget>[
          TextFormField(
            style: TextStyle(fontSize: 14),
            controller: _contactCtrl,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(75.0, 10.0, 20.0, 10.0),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              prefixStyle: TextStyle(fontWeight: FontWeight.bold),
              hintText: "nomer telepon",
            ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value.isEmpty) {
                return 'Isi nomor telepon terlebih dahulu';
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 5),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 8),
                    child: Icon(AllInOneIcon.edittext_phone_3x,
                        size: 20, color: grayColor),
                  ),
                  const Text('+62 |'),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(1, 0),
            child: IconButton(
              onPressed: () {
                onSubmit();
              },
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CircleAvatar(
                  backgroundColor: greenColor,
                  child: Icon(
                    NewIcon.next_small_2x,
                    size: 13.0,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widgetLogo,
                widgetAppName,
                widgetContactName,
                widgetContactField,
                widgetSocialLoginName,
                widgetSocialMedia
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Image.asset(
        "assets/backgrounds/accent_app_width_full_screen.png",
        fit: BoxFit.fitWidth,
        alignment: Alignment.bottomLeft,
      ),
    );
  }

  void onSubmit() {
    if (_formKey.currentState.validate()) {
      var otp = _otpServices.otpGenarator(_contactCtrl.text);

      print(otp.toString());

      smsProvider
          .postSMSOtp(_contactCtrl.text, otp.toString())
          .then((response) {
        print(response.statusCode);
        print(response.body);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StepTwo(
              contactKey: _contactCtrl.text,
              otpKey: otp.toString(),
            ),
          ),
        );
      });
    }
  }
}
