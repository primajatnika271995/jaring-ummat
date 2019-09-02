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
  final String appName = 'Mitra Jejaring';
  final String logoUrl = 'assets/icon/logo_mitra_jejaring.png';
  final String bgUrl = 'assets/backgrounds/accent_app_width_full_screen.png';

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = new FocusNode();

  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    final bloc = LoginBloc();

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
      padding: EdgeInsets.only(top: 40),
      child: const Text('Masukan akun anda'),
    );

    final widgetSocialLoginName = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: const Text('atau masuk dengan media sosial'),
    );

    final widgetRegisterBtn = Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: OutlineButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/register/step1');
        },
        child: const Text('Daftar'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      ),
    );

    final widgetSocialMedia = Padding(
      padding: EdgeInsets.only(top: 5.0),
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

    final widgetEmailField = Padding(
      padding: EdgeInsets.only(top: 10.0, left: 60.0, right: 60.0),
      child: StreamBuilder<String>(
        stream: bloc.email,
        builder: (context, snapshot) => TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              hintText: "Alamat Email",
              hintStyle: TextStyle(fontSize: 15.0),
              errorText: snapshot.error),
          controller: emailController,
          focusNode: _emailFocusNode,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          onChanged: bloc.changeEmail,
          textInputAction: TextInputAction.next,
        ),
      ),
    );

    final widgetPasswordField = Padding(
      padding: EdgeInsets.only(top: 5.0, left: 60.0, right: 60.0),
      child: StreamBuilder<String>(
        stream: bloc.password,
        builder: (context, snapshot) => TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              hintText: "Password",
              hintStyle: TextStyle(fontSize: 15.0),
              errorText: snapshot.error),
          controller: passwordController,
          focusNode: _passwordFocusNode,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          obscureText: true,
          onChanged: bloc.changePassword,
        ),
      ),
    );

    final widgetSubmitBtn = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) => FlatButton(
          onPressed: snapshot.hasData
              ? () => onSubmit(context)
              : null,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          child: const Text('Masuk', style: TextStyle(color: Colors.white)),
          color: greenColor,
          disabledColor: grayColor,
          disabledTextColor: whiteColor,
        ),
      ),
    );

    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: Center(
              child: SingleChildScrollView(
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

  onSubmit(BuildContext context) async {
    await changeLoadingVisible();
    bloc.login(context, emailController.text, passwordController.text);
    await Future.delayed(Duration(seconds: 5));
    await changeLoadingVisible();
  }

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
}
