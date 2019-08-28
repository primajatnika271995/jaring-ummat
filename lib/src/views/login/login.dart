import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/sosial_media_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/loginBloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String appName = 'Jejaring';
  final String logoUrl = 'assets/icon/main_logo.png';
  final String bgUrl = 'assets/backgrounds/accent_app_width_full_screen.png';

  final _emailTextCtrl = new TextEditingController();
  final _passwordTextCtrl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    final widgetLogo = Padding(
      padding: EdgeInsets.only(top: 60.0),
      child: Container(
        child: Image.asset(logoUrl, scale: 30.0),
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
      child: const Text('Masukan akun anda'),
    );

    final widgetSocialLoginName = Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: const Text('atau masuk dengan media sosial'),
    );

    final widgetRegisterBtn = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: OutlineButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/register/step1');
        },
        child: const Text('Daftar'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      ),
    );

    final widgetSubmitBtn = Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: FlatButton(
        onPressed: () {
          onSubmit();
        },
        child: const Text('Masuk', style: TextStyle(color: Colors.white)),
        color: greenColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
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
            iconSize: 60.0,
            color: facebookColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.google),
            iconSize: 60.0,
            color: googleColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.linkedin),
            iconSize: 60.0,
            color: linkedInColor,
          ),
        ],
      ),
    );

    final widgetEmailField = Padding(
      padding: EdgeInsets.only(top: 10.0, left: 80.0, right: 80.0),
      child: TextFormField(
        controller: _emailTextCtrl,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
          ),
          prefixIcon: Icon(Icons.mail_outline),
          hintText: "Alamat Email",
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        validator: (value) {
          if (value.isEmpty) {
            return 'Email tidak boleh kosong';
          }
          return null;
        },
      ),
    );

    final widgetPasswordField = Padding(
      padding: EdgeInsets.only(top: 10.0, left: 80.0, right: 80.0),
      child: TextFormField(
        controller: _passwordTextCtrl,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
          ),
          prefixIcon: Icon(Icons.lock_outline),
          hintText: "Password",
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        obscureText: true,
        validator: (value) {
          if (value.isEmpty) {
            return 'Password tidak boleh kosong';
          }
          return null;
        },
      ),
    );

    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      widgetLogo,
                      widgetAppName,
                      widgetContactName,
                      widgetEmailField,
                      widgetPasswordField,
                      widgetSubmitBtn,
                      widgetRegisterBtn,
                      widgetSocialLoginName,
                      widgetSocialMedia
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              bgUrl,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft,
            ),
          ),
        ],
      ),
    );
  }

  void onSubmit() async {
    if (_formKey.currentState.validate()) {
      await changeLoadingVisible();
      bloc.login(context, _emailTextCtrl.text, _passwordTextCtrl.text);
      bloc.userDetails(context, _emailTextCtrl.text);
      await Future.delayed(Duration(seconds: 2));
      changeLoadingVisible();
    }
  }

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
}
