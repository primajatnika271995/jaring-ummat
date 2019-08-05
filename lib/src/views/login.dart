import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:otp/otp.dart';
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'package:linkedin_login/linkedin_login.dart';
import 'package:linkedin_auth/linkedin_auth.dart';

import 'package:flutter_jaring_ummat/src/models/login_model.dart' as modelLogin;
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/registerApi.dart';

import 'components/container_bg_default.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/services/login_service.dart';
import 'components/form_field_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/create_account_icons.dart';
import 'package:flutter_jaring_ummat/src/models/UserDetails.dart';
import 'package:flutter_jaring_ummat/src/services/user_details.dart';

class LoginView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginView> {
  SharedPreferences _preferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _emailTextEditController = TextEditingController();
  TextEditingController _passwordTextEditController = TextEditingController();

  String _emailTampung;
  String _passwordTampung;

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();

  bool _isSubmit = false;
  bool _obscureTextPassword = true;

  LoginServices service = new LoginServices();
  UserDetailsService userDetailsService = new UserDetailsService();
  final FacebookLogin facebookSignIn = new FacebookLogin();
  final UserDetailsService _userDetailsService = new UserDetailsService();
  final RegisterApiProvider register = new RegisterApiProvider();

  ProgressDialog _progressDialog;
  AuthorizationCodeResponse authorizationCodeResponse;

  final String redirectUrl = 'https://api.linkedin.com/v2/';
  final String clientId = '81vfnbt57g6p6q';
  final String clientSecret = 'QOzI7o0ZTBAF8hr7';

  String token;
  int otpKey;

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
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: _buildPage(context),
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
                    SizedBox(
                      height: 30.0,
                    ),
                    Icon(
                      CreateAccount.jaring_ummat_new_logo,
                      color: Colors.white,
                      size: 100.0,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
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
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      50.0,
                      0.0,
                      50.0,
                      0.0,
                    ),
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
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: 'disini',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: RaisedButton.icon(
                                      icon: Icon(
                                        FontAwesomeIcons.facebookF,
                                        size: 18.0,
                                      ),
                                      label: new Text(
                                        'Facebook',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      onPressed: _loginFacebook,
                                      textColor: Colors.white,
                                      color: Color.fromRGBO(59, 89, 152, 1.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: RaisedButton.icon(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'assets/icon/google_logo.svg',
                                        width: 18.0,
                                        height: 18.0,
                                      ),
                                      label: new Text(
                                        'Google',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      color: Color.fromRGBO(255, 255, 255, 1.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: RaisedButton.icon(
                                      onPressed: () async {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LinkedInUserWidget(
                                              redirectUrl: redirectUrl,
                                              clientId: clientId,
                                              clientSecret: clientSecret,
                                              onGetUserProfile:
                                                  (LinkedInUserModel
                                                      linkedInUser) {
                                                print(
                                                    'Access token ${linkedInUser.token.accessToken}');

                                                setState(() {});
                                                onRegisterLinkedIn(linkedInUser
                                                    .token.accessToken);

                                                Navigator.pop(context);
                                              },
                                              catchError:
                                                  (LinkedInErrorObject error) {
                                                print(
                                                    'Error description: ${error.description},'
                                                    ' Error code: ${error.statusCode.toString()}');
                                                Navigator.pop(context);
                                              },
                                            ),
                                            fullscreenDialog: true,
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.linkedin,
                                        color: Colors.white,
                                        size: 18.0,
                                      ),
                                      label: new Text(
                                        'LinkedIn',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
                                      ),
                                      color: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Belum memiliki akun?',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/onboarding/step2',
                                );
                              },
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(
                                0.0,
                              ),
                              color: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  30.0,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(
                                  20.0,
                                  2.0,
                                  20.0,
                                  2.0,
                                ),
                                child: Text(
                                  'Buat Akun',
                                ),
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

  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  Future<void> login() async {
    _preferences = await SharedPreferences.getInstance();
    _emailTampung = _emailTextEditController.text;
    _passwordTampung = _passwordTextEditController.text;

    setState(() {
      _isSubmit = true;
    });

    _progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage("Please Wait ...");
    _progressDialog.show();

    await service.login(_emailTampung, _passwordTampung).then((response) async {
      print("INI RESPONSE CODE LOGIN ==>");
      print(response.statusCode);

      if (response.statusCode == 200) {
        var value = modelLogin.AccessToken.fromJson(json.decode(response.body));
        var token = value.access_token;
        _preferences.setString(ACCESS_TOKEN_KEY, token);
        _preferences.setString(EMAIL_KEY, _emailTampung);

        await getUserDetail();
      }

      if (response.statusCode == 400) {
        setState(() {
          _isSubmit = false;
          _progressDialog.hide();
          Toast.show(
            "Username atau Password Salah",
            context,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            duration: 2,
          );
        });
      }
    });
  }

  Future<void> getUserDetail() async {
    UserDetails userDetails;
    _preferences = await SharedPreferences.getInstance();
    var _email = _preferences.getString(EMAIL_KEY);

    _progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage("Get User Details ...");
    _progressDialog.show();

    _email != null
        ? userDetailsService.userDetails(_email).then(
            (response) async {
              print("For Response Users Detail Code ${response.statusCode}");
              if (response.statusCode == 200) {
                print("For Response Users Detail by Email ${response.data} ");
                userDetails = UserDetails.fromJson(response.data);
                _preferences.setString(FULLNAME_KEY, userDetails.fullname);
                _preferences.setString(CONTACT_KEY, userDetails.contact);
                _preferences.setString(USER_ID_KEY, userDetails.userId);
                _preferences.setString(
                    PROFILE_PICTURE_KEY, userDetails.imgProfile[0].imgUrl);
                await Navigator.of(context).pushReplacementNamed('/home');
              }
            },
          )
        : null;
  }

  Future<Null> _loginFacebook() async {
    _preferences = await SharedPreferences.getInstance();
    final FacebookLoginResult result =
        await facebookSignIn.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');

        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${result.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        FacebookUserDetails userDetails = FacebookUserDetails.fromJson(profile);

        await _userDetailsService
            .userDetails(userDetails.email)
            .then((response) {
          _progressDialog =
              new ProgressDialog(context, ProgressDialogType.Normal);
          _progressDialog.setMessage("Login Facebook Account ...");
          _progressDialog.show();

          if (response.statusCode == 200) {
            UserDetails user = new UserDetails();
            user = UserDetails.fromJson(response.data);

            _preferences.setString(FULLNAME_KEY, userDetails.name);
            _preferences.setString(CONTACT_KEY, 'Not Found');
            _preferences.setString(EMAIL_KEY, userDetails.email);
            _preferences.setString(ACCESS_TOKEN_KEY, accessToken.token);
            _preferences.setString(USER_ID_KEY, user.userId);
            _preferences.setString(
                PROFILE_FACEBOOK_KEY, profile['picture']['data']['url']);

            Navigator.of(context).pushReplacementNamed('/home');
          } else {
            if (response.statusCode == 204) {
              _registerFacebook();
            }
          }
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    print('Logged out.');
  }

  void onLoading() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Center(
        child: Dialog(
          backgroundColor: Colors.white,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
    await Future.delayed(Duration(seconds: 2));
  }

  void onRegisterLinkedIn(String token) async {
    _preferences = await SharedPreferences.getInstance();
    var liteProfile = await LinkedInService.getLiteProfile(token);
    var liteEmail = await LinkedInService.getEmailAddress(token);

    var profileImage = await liteProfile.profileImage.getDisplayImageUrl(token);

    await _userDetailsService.userDetails(liteEmail).then((response) {
      _progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
      _progressDialog.setMessage("Login LinkedIn Account ...");
      _progressDialog.show();

      if (response.statusCode == 200) {
        UserDetails userDetails = new UserDetails();

        userDetails = UserDetails.fromJson(response.data);

        _preferences.setString(FULLNAME_KEY, liteEmail);
        _preferences.setString(CONTACT_KEY, 'Not Found');
        _preferences.setString(EMAIL_KEY, liteEmail);
        _preferences.setString(ACCESS_TOKEN_KEY, token);
        _preferences.setString(USER_ID_KEY, userDetails.userId);
        _preferences.setString(PROFILE_FACEBOOK_KEY, profileImage);

        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        if (response.statusCode == 204) {
          _registerLinkedIn(token);
        }
      }
    });
  }

  void _registerLinkedIn(String token) async {
    _preferences = await SharedPreferences.getInstance();

    _progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage("Register LinkedIn Account ...");
    _progressDialog.show();

    var liteProfile = await LinkedInService.getLiteProfile(token);
    var liteEmail = await LinkedInService.getEmailAddress(token);
    var profileImage = await liteProfile.profileImage.getDisplayImageUrl(token);

    otpKey = OTP.generateHOTPCode(
      liteEmail + DateTime.now().toIso8601String(),
      300,
      length: 8,
    );

    final postData = PostRegistration(
      contact: "Not Found",
      email: liteEmail,
      fullname: "LinkedIn User",
      tipe_user: "LinkedIn",
      username: liteEmail,
      password: otpKey.toString(),
    );

    await register.saveUser(postData).then((response) {
      _sendPassword(liteEmail, "LinkedIn");
      _progressDialog.hide();
      onRegisterLinkedIn(token);
    });
  }

  Future<Null> _registerFacebook() async {
    _preferences = await SharedPreferences.getInstance();

    _progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage("Register Facebook Account ...");
    _progressDialog.show();

    final FacebookLoginResult result =
        await facebookSignIn.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');

        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${result.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        FacebookUserDetails userDetails = FacebookUserDetails.fromJson(profile);

        otpKey = OTP.generateHOTPCode(
          userDetails.email + DateTime.now().toIso8601String(),
          300,
          length: 8,
        );

        final postData = PostRegistration(
          contact: "Not Found",
          email: userDetails.email,
          fullname: userDetails.first_name + userDetails.last_name,
          tipe_user: "Facebook",
          username: userDetails.email,
          password: otpKey.toString(),
        );

        await register.saveUser(postData).then((response) {
          _sendPassword(userDetails.email, "Facebook");
          _progressDialog.hide();
          _loginFacebook();
        });
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  void _sendPassword(String email, String medsos) {
    String username = "dis@tabeldata.com";
    String password = "0fm6lyn9cjph";

    final smtpServer = SmtpServer('mail.tabeldata.com',
        username: username, password: password, port: 26, ssl: false);

    final message = new Message()
      ..from = new Address(username, 'Jaring Umat OTP')
      ..recipients.add(email)
      ..subject =
          'Jaring Umat ${medsos} Password Generator :: :: ${new DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>Your Pasword CODE using $otpKey </h1>\n<p>If you are having any issues with your Account, please don\'t hesitate to contact us by replying to this email\n \n <p>Thank!";

    send(message, smtpServer);
  }
}
