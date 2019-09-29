import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/textUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/sosial_media_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/loginBloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';

class ReLogin extends StatefulWidget {
  @override
  _ReLoginState createState() => _ReLoginState();
}

class _ReLoginState extends State<ReLogin> {
  /*
   * Text Edit Controller
   */
  final _emailTextCtrl = new TextEditingController();
  final _passwordTextCtrl = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    Widget logoApp() {
      return Container(
        child: Image.asset(LoginText.logoUrl, scale: 40.0),
      );
    }

    Widget titleApp() {
      return Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 40),
        child: Text(
          LoginText.namaAplikasi,
          style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget emailField() {
      return Container(
        width: screenWidth(context, dividedBy: 1.5),
        margin: EdgeInsets.only(bottom: 5),
        child: Stack(
          children: <Widget>[
            TextFormField(
              style: TextStyle(fontSize: 14),
              controller: _emailTextCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(45.0, 10.0, 15.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: greenColor),
                ),
                hintText: LoginText.emailHint,
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
            Align(
              alignment: Alignment(-0.9, -10),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(AllInOneIcon.edittext_name_3x,
                    color: greenColor, size: 20),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordField() {
      return Container(
        width: screenWidth(context, dividedBy: 1.5),
        margin: EdgeInsets.only(top: 5),
        child: Stack(
          children: <Widget>[
            TextFormField(
              style: TextStyle(fontSize: 14),
              controller: _passwordTextCtrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(45.0, 10.0, 15.0, 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                  borderSide: BorderSide(color: greenColor),
                ),
                hintText: LoginText.passwordHint,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Password Tidak boleh Kosong';
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment(-0.9, -10),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(Icons.lock_outline, color: greenColor, size: 20),
              ),
            ),
          ],
        ),
      );
    }

    Widget loginBtn() {
      return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: RaisedButton(
          onPressed: () {
            onSubmit();
          },
          child: Text(
            LoginText.loginBtn,
            style: TextStyle(color: Colors.white),
          ),
          color: greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
        ),
      );
    }

    Widget registerBtn() {
      return Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: OutlineButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/register/step1');
          },
          child: const Text(LoginText.registerBtn),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        ),
      );
    }

    Widget socailMediaBtn() {
      return Padding(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Text(LoginText.socialMedia),
            Row(
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
          ],
        ),
      );
    }

    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  logoApp(),
                  titleApp(),
                  emailField(),
                  passwordField(),
                  loginBtn(),
                  registerBtn(),
                  socailMediaBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _loadingVisible = false;
    setState(() {});
    super.initState();
  }

  void onSubmit() async {
    if (_formKey.currentState.validate()) {
      var email = _emailTextCtrl.text;
      var password = _passwordTextCtrl.text;

      await changeLoadingVisible();
      
      await bloc.login(context, email, password);
      changeLoadingVisible();
    }
  }

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
}
