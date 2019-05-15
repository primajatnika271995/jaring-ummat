import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding/step3.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

// Component Import
import '../components/container_bg_default.dart';
import '../components/form_field_container.dart';
import '../../services/register_service.dart';
import '../components/create_account_icons.dart';

class Step2View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Step2State();
  }
}

class Step2State extends State<Step2View> {

//  SCAFFOLD KEY

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  VARIABLE CONTROLLER

  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool _selected = false;
  bool _isSubmit = false;

  bool _obscureTextPassword = true;
  bool _obscureTextKonfirmPassword = true;

//  BATAS WIDGET

  Future<bool> showLoadingIndicator() async {
    await new Future.delayed(const Duration(seconds: 2));
    return true;
  }

//  WIDGET SUBMIT BUTTON
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        body: Stack(
          children: _buildPage(context),
        ),
      ),
    );
  }

//  TOGGLE PASSWORD METODE

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

//  ON REGISTER METODE

  void onRegister() async {
    var fullname = _fullnameController.text;
    var email = _emailController.text;
    var contact = _contactController.text;
    var password = _passwordController.text;
    var cpassword = _cpasswordController.text;

    if (fullname.isEmpty | password.isEmpty | email.isEmpty | contact.isEmpty) {
      Toast.show('Field can\'t be Empty', context,
          duration: 2, backgroundColor: Colors.red);
      return;
    }

    if (password != cpassword) {
      Toast.show('Password and cPassword not Valid', context,
          duration: 2, backgroundColor: Colors.red);
      return;
    }

    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        duration: new Duration(seconds: 2),
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text(" Validation Data ... ")
          ],
        ),
      ),
    );
    await showLoadingIndicator();
    RegisterService service = new RegisterService();
    service.checkoutEmail(email).then((response) {
      if (response.statusCode == 200) {
        Toast.show('Email Anda Sudah terdaftar Sebelumnya !', context,
            duration: 2, backgroundColor: Colors.red);
        return;
      }

      if (response.statusCode == 204) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Step3View(
              email: email,
              fullname: fullname,
              password: password,
              contact: contact,
            ),
          ),
        );
      }
    });
  }

  List<Widget> _buildPage(BuildContext context) {
    var widgets = new List<Widget>();
    widgets.add(ContainerBackground());
    widgets.add(Container(
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
                      )
                    ),
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
                            formField(context, 'Email', Icons.email,
                                _emailController),
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
                                              color: Colors.blue,
                                              fontSize: 11)),
                                      TextSpan(text: "!")
                                    ])),
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
                                RaisedButton.icon(
                                  icon: Icon(
                                    FontAwesomeIcons.facebookF,
                                    size: 20.0,
                                  ),
                                  label: new Text('Facebook'),
                                  onPressed: () {},
                                  textColor: Colors.white,
                                  color: Color.fromRGBO(59, 89, 152, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                RaisedButton.icon(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                    'assets/icon/google_logo.svg',
                                    width: 20.0,
                                    height: 20.0,
                                  ),
                                  label: new Text('Google'),
                                  color: Color.fromRGBO(255, 255, 255, 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                )
                              ])
                        ],
                      ),
                    ),
                  ],
                )))));

    return widgets;
  }
}
