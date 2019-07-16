import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/user_details.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:linkedin_auth/linkedin_auth.dart';

// Component Import
import 'package:flutter_jaring_ummat/src/views/components/container_bg_default.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding/step3.dart';
import '../components/form_field_container.dart';
import '../components/create_account_icons.dart';
import '../../models/UserDetails.dart';
import '../../config/preferences.dart';

class Step2View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Step2State();
  }
}

class Step2State extends State<Step2View> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final FacebookLogin facebookSignIn = new FacebookLogin();
  final UserDetailsService _userDetailsService = new UserDetailsService();
  SharedPreferences _preferences;

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  final String redirectUrl = 'https://api.linkedin.com/v2/';
  final String clientId = '81vfnbt57g6p6q';
  final String clientSecret = 'QOzI7o0ZTBAF8hr7';

  String token;

  bool _selected = false;
  bool _isSubmit = false;
  bool _obscureTextPassword = true;
  bool _obscureTextKonfirmPassword = true;

  AuthorizationCodeResponse authorizationCodeResponse;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.grey,
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
      Container(
        width: double.infinity,
        height: double.infinity,
        child: new Form(
          key: _formKey,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Icon(
                      CreateAccount.create_account_step_1,
                      color: Colors.white,
                      size: 120.0,
                    )),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        formField(context, 'Fullname', Icons.person,
                            _fullnameController),
                        formField(
                            context, 'Email', Icons.email, _emailController),
                        formFieldContact(context, 'Phone Number',
                            Icons.phone_android, _contactController),
                        formFieldPassword(
                            context,
                            'Password',
                            Icons.lock,
                            _passwordController,
                            this._togglePassword,
                            _obscureTextPassword),
                        formFieldPassword(
                            context,
                            'Confirm Password',
                            Icons.lock,
                            _cpasswordController,
                            this._toggleKonfirmPassword,
                            _obscureTextKonfirmPassword),
                        Container(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Anggota Bamuis BNI? ",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 10.0,
                              ),
                              InkWell(
                                onTap: () {
                                  print(_selected);
                                  setState(() {
                                    _selected
                                        ? this._selected = false
                                        : this._selected = true;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _selected
                                          ? Colors.lightGreen
                                          : Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: _selected
                                        ? Icon(
                                            Icons.check,
                                            size: 15.0,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.check,
                                            size: 15.0,
                                            color: Colors.grey,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        submitButton(),
                        new Container(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Sudah punya akun? Login ',
                                      style: TextStyle(fontSize: 11)),
                                  TextSpan(
                                      text: 'disini',
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 11)),
                                  TextSpan(text: "!")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Atau buat akun dengan?',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          )),
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
                                borderRadius: BorderRadius.circular(30.0),
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
                                borderRadius: BorderRadius.circular(30.0),
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
                                              (LinkedInUserModel linkedInUser) {
                                            print(
                                                'Access token ${linkedInUser.token.accessToken}');

                                            setState(() {});
                                            onRegisterLinkedIn(
                                                linkedInUser.token.accessToken);

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
                                    color: Colors.white, fontSize: 12.0),
                              ),
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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

        _preferences.setString(FULLNAME_KEY, userDetails.name);
        _preferences.setString(CONTACT_KEY, 'Not Found');
        _preferences.setString(EMAIL_KEY, userDetails.email);
        _preferences.setString(ACCESS_TOKEN_KEY, accessToken.token);
        _preferences.setString(USER_ID_KEY, userDetails.id);
        _preferences.setString(
            PROFILE_FACEBOOK_KEY, profile['picture']['data']['url']);

        print(_preferences.getString(PROFILE_FACEBOOK_KEY));

        await Navigator.of(context).pushReplacementNamed('/home');
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

  Widget submitButton() {
    return RaisedButton(
      onPressed: _emailController.text.isNotEmpty ? this.onRegister : null,
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
          _isSubmit ? 'Loading ... ' : 'Selanjutnya',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _togglePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleKonfirmPassword() {
    setState(() {
      _obscureTextKonfirmPassword = !_obscureTextKonfirmPassword;
    });
  }

  void onRegister() async {
    if (_emailController.text.isEmpty |
        _passwordController.text.isEmpty |
        _fullnameController.text.isEmpty |
        _contactController.text.isEmpty) {
      Toast.show(
        'Field can\'t be Empty',
        context,
        duration: 2,
        backgroundColor: Colors.red,
      );
      return;
    }

    if (_passwordController.text != _cpasswordController.text) {
      Toast.show(
        'Password and cPassword not Valid',
        context,
        duration: 2,
        backgroundColor: Colors.red,
      );
      return;
    }

    final postData = PostRegistration(
      username: _emailController.text,
      fullname: _fullnameController.text,
      password: _passwordController.text,
      contact: _contactController.text,
      email: _emailController.text,
      tipe_user: "Muzakki",
    );

    await _userDetailsService.userDetails(_emailController.text).then((response) async {

      print('status code ${response.statusCode}');
      if (response.statusCode == 200) {
        Toast.show(
          'The email has been registered before.',
          context,
          duration: 2,
          backgroundColor: Colors.red,
        );
      } else if (response.statusCode == 204) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Step3View(
                  data: postData,
                ),
          ),
        );
       }
    });
  }

  void onRegisterLinkedIn(String token) async {
    _preferences = await SharedPreferences.getInstance();
    var liteProfile = await LinkedInService.getLiteProfile(token);
    var liteEmail = await LinkedInService.getEmailAddress(token);

    var profileImage = await liteProfile.profileImage.getDisplayImageUrl(token);
    print(liteEmail);
    print(profileImage);

    _preferences.setString(FULLNAME_KEY, liteEmail);
    _preferences.setString(CONTACT_KEY, 'Not Found');
    _preferences.setString(EMAIL_KEY, liteEmail);
    _preferences.setString(ACCESS_TOKEN_KEY, token);
    _preferences.setString(USER_ID_KEY, "");
    _preferences.setString(PROFILE_FACEBOOK_KEY, profileImage);

    await Navigator.of(context).pushReplacementNamed('/home');
  }
}
