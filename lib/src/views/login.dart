import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';

// Component
import 'components/container_bg_default.dart';
import '../config/preferences.dart';
import '../services/login_service.dart';
import 'components/form_field_container.dart';
import '../views/components/create_account_icons.dart';
import 'package:flutter_jaring_ummat/src/models/UserDetails.dart';
import 'package:flutter_jaring_ummat/src/services/user_details.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginView> {
// VARIABLE FORM CONTROLLER

  TextEditingController _emailTextEditController = TextEditingController();
  TextEditingController _passwordTextEditController = TextEditingController();

  String _emailTampung;
  String _passwordTampung;

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  bool _isSubmit = false;

  bool _obscureTextPassword = true;

//  VARIABLE SHARED PREFERENCES

  SharedPreferences _preferences;

//  SCAFFOLD KEY

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

//  SERVICE VARIABLE
  LoginServices service = new LoginServices();
  UserDetailsService userDetailsService = new UserDetailsService();

//  TOGGLE PASSWORD METODE
  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

//  PROGRES DIALOG
  ProgressDialog _progressDialog;

//  LOGIN METODE

  Future<void> login() async {

    _preferences = await SharedPreferences.getInstance();
    _emailTampung = _emailTextEditController.text;
    _passwordTampung = _passwordTextEditController.text;

    setState(() {
      _isSubmit = true;
    });

//    _scaffoldKey.currentState.showSnackBar(
//      new SnackBar(
//        content: new Row(
//          children: <Widget>[
//            new CircularProgressIndicator(),
//            new Text(" Please Wait ... ")
//          ],
//        ),
//      ),
//    );

    _progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage("Please Wait ...");
    _progressDialog.show();

   await service.login(_emailTampung, _passwordTampung).then((response) async {

      print("INI RESPONSE CODE LOGIN ==>");
      print(response.statusCode);

      if (response.statusCode == 200) {
        var value = AccessToken.fromJson(json.decode(response.body));
        var token = value.access_token;
        _preferences.setString(ACCESS_TOKEN_KEY, token);
        _preferences.setString(EMAIL_KEY, _emailTampung);

        await getUserDetail();
      }

      if (response.statusCode == 400) {
        setState(() {
          _isSubmit = false;
          _progressDialog.hide();
          Toast.show("Username atau Password Salah", context, backgroundColor: Colors.redAccent, textColor: Colors.white, duration: 2);
        });
      }
    });
  }

  Future<void> getUserDetail() async {
    UserDetails userDetails;
    _preferences = await SharedPreferences.getInstance();
    var _email = _preferences.getString(EMAIL_KEY);

//    _scaffoldKey.currentState.showSnackBar(
//      new SnackBar(
//        content: new Row(
//          children: <Widget>[
//            new CircularProgressIndicator(),
//            new Text(" Please Wait For Details Users ... ")
//          ],
//        ),
//      ),
//    );

    _progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage("Get User Details ...");
    _progressDialog.show();

    _email != null
        ? userDetailsService.userDetails(_email).then((response) async {
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        print("INI RESPONSE USER DETAILS ==>");
        print(response.data);
        userDetails = UserDetails.fromJson(response.data[0]);
        print(userDetails.path_file);
        _preferences.setString(FULLNAME_KEY, userDetails.fullname);
        _preferences.setString(CONTACT_KEY, userDetails.contact);
        _preferences.setString(
            USER_ID_KEY, userDetails.id_user.toString());
        _preferences.setString(
            PROFILE_PICTURE_KEY, userDetails.profile_picture);
      await Navigator.of(context).pushReplacementNamed('/home');
      }
    })
        : null;
  }

//  BATAS VARIABLE

  //  WIDGET SUBMIT BUTTON
  Widget submitButton() {
    return RaisedButton(
      onPressed: _emailTextEditController.text.isNotEmpty ? this.login : null,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.white,
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
        child: Text(
          _isSubmit ? 'Loading ... ' : 'Bismillah',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: _buildPage(context),
        ),
      ),
    );
  }

  List<Widget> _buildPage(BuildContext context) {
    var widgets = new List<Widget>();
    widgets.add(ContainerBackground());
    widgets.add(
      new Container(
        width: double.infinity,
        height: double.infinity,
        child: new Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Icon(
                      CreateAccount.jaring_ummat_new_logo,
                      color: Colors.white,
                      size: 100.0,
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'Jaring Ummat',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Mudah dan syar\'i, indahnya beramal, hidupkanmu!',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        formField(
                          context,
                          'Email',
                          Icons.email,
                          _emailTextEditController,
                        ),
                        formFieldPassword(
                          context,
                          'Password',
                          Icons.lock,
                          _passwordTextEditController,
                          this._togglePassword,
                          _obscureTextPassword,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        submitButton(),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Lupa password? Klik ',
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(
                                    text: 'disini',
                                    style: TextStyle(color: Colors.blue, fontSize: 12))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            Text('Belum memiliki akun?', style: TextStyle(color: Colors.white)),
                            SizedBox(height: 10.0),
                            RaisedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/onboarding/step2');
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0.0),
                              color: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                                child: Text('Buat Akun'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return widgets;
  }
}
