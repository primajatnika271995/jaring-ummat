import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/services/otp_service.dart';
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

  final _textEditingControllerContact = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool nomorTeleponIsSubmited = false;

  final _otpServices = new OtpServices();

  @override
  Widget build(BuildContext context) {
    final widgetLogo = Padding(
      padding: EdgeInsets.only(top: 30.0),
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
      child: const Text('Masukan alamat email'),
    );

    final widgetSocialLoginName = Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: const Text('atau buat akun dengan media sosial'),
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
      padding: EdgeInsets.only(top: 10.0, left: 80.0, right: 80.0),
      child: TextFormField(
        controller: _textEditingControllerContact,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
          ),
          prefixIcon: Icon(
            Icons.mail_outline,
            color: grayColor,
          ),
          prefixStyle: TextStyle(fontWeight: FontWeight.bold),
          hintText: "Alamat Email",
          suffixIcon: IconButton(
            onPressed: () {
              onSubmit();
            },
            icon: CircleAvatar(
              backgroundColor: greenColor,
              child: Icon(
                NewIcon.next_small_2x,
                size: 18.0,
                color: whiteColor,
              ),
            ),
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.go,
        validator: (value) {
          if (value.isEmpty) {
            return 'Isi alamat email terlebih dahulu';
          }
          return null;
        },
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
      var otp = _otpServices.otpGenarator(_textEditingControllerContact.text);
      _otpServices.emailOtp(_textEditingControllerContact.text, otp.toString());

      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => StepTwo(
                  emailKey: _textEditingControllerContact.text,
                  otpKey: otp.toString(),
                )),
      );
    }
  }
}
