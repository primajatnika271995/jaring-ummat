import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding/step4.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:otp/otp.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

// Component
import '../components/container_bg_default.dart';
import '../components/create_account_icons.dart';

class Step3View extends StatefulWidget {
  final String email;
  final String fullname;
  final String contact;
  final String password;

  Step3View({this.email, this.fullname, this.password, this.contact});

  @override
  State<StatefulWidget> createState() {
    return Step3State();
  }
}

class Step3State extends State<Step3View> with TickerProviderStateMixin {
//
  TextEditingController textEditingController1 = new TextEditingController();
  TextEditingController textEditingController2 = new TextEditingController();
  TextEditingController textEditingController3 = new TextEditingController();
  TextEditingController textEditingController4 = new TextEditingController();
  TextEditingController textEditingController5 = new TextEditingController();
  TextEditingController textEditingController6 = new TextEditingController();

  TextEditingController currController = new TextEditingController();

//

  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusNode focusNode3 = new FocusNode();
  FocusNode focusNode4 = new FocusNode();
  FocusNode focusNode5 = new FocusNode();
  FocusNode focusNode6 = new FocusNode();

// TIMER FOR OTP

  AnimationController _animationController;

  int otpKey;

  String get timerString {
    Duration duration =
        _animationController.duration * _animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void startTimer() {
    setState(() {
      if (_animationController.isAnimating) {
        _animationController.stop();
      } else {
        _animationController.reverse(
            from: _animationController.value == 0.0
                ? 1.0
                : _animationController.value);
      }
    });
  }

  void sendOTP() async {
    // Setting Email Sender
    String username = "dis@tabeldata.com";
    String password = "0fm6lyn9cjph";
//    String username = "braveavi2@gmail.com";
//    String password = "Risingforce12";

//    final smtpServer = gmail(username, password);
    final smtpServer = SmtpServer('mail.tabeldata.com',
        username: username, password: password, port: 26, ssl: false);

    final message = new Message()
      ..from = new Address(username, 'Jaring Umat OTP')
      ..recipients.add(widget.email)
      // ..ccRecipients.addAll(['braveavi.2@gmail.com', 'braveavi.2@gmail.com'])
      // ..bccRecipients.add(new Address('braveavi.2@gmail.com'))
      ..subject = 'Jaring Umat Register :: :: ${new DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>Your OTP CODE $otpKey </h1>\n<p>If you are having any issues with your Account, please don\'t hesitate to contact us by replying to this email\n \n <p>Thank!";

    send(message, smtpServer);
  }

  void submitOTP() {
    String otp = textEditingController1.text +
        textEditingController2.text +
        textEditingController3.text +
        textEditingController4.text +
        textEditingController5.text +
        textEditingController6.text;

    if (otp == otpKey.toString()) {
      setState(() {
        is_submited = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Step4View(
                  email: widget.email,
                  username: widget.fullname,
                  password: widget.password,
                  contact: widget.contact,
                ),
          ),
        );
      });
    } else {
      Toast.show('OTP Number is Wrong, check Again', context,
          duration: 2, backgroundColor: Colors.red);
    }
  }

//

  bool is_submited = false;

//  BATAS VARIABLE

  @override
  void initState() {
    super.initState();

    otpKey = OTP.generateHOTPCode(
        widget.fullname + DateTime.now().toIso8601String(), 300,
        length: 6);

    print("INI KODE OTP");
    print(otpKey);

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 240));
    startTimer(); // Untuk memulai Countdown Timer OTP
    sendOTP();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController1.dispose();
    textEditingController2.dispose();
    textEditingController3.dispose();
    textEditingController4.dispose();
    textEditingController5.dispose();
    textEditingController6.dispose();
    currController.dispose();
  }

//

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

//  BATAS WIDGET BUILD

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _buildPage(),
      ),
    );
  }

  List<Widget> _buildPage() {
    var widgets = new List<Widget>();
    widgets.add(ContainerBackground());
    widgets.add(
      Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: <Widget>[
              //     Padding(
              //       padding: EdgeInsets.only(left: 20.0),
              //       child: Text(
              //         'Langkah 13/4',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 16.0,
              //           color: Colors.white,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // appLogo(),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.5),
                ),
                padding: EdgeInsets.symmetric(vertical: 55.0),
                child: Icon(
                  CreateAccount.create_account_step_2,
                  color: Colors.white,
                  size: 120.0,
                ),
              ),
              Column(
                children: <Widget>[
                  Text('Masukkan kode OTP yang terkirim ke email',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Text(
                    widget.email,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                    child: otpTextFieldContainer(),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            "Kode akses akan berakhir pada ",
                            style:
                                TextStyle(fontSize: 11.0, color: Colors.white),
                          ),
                          AnimatedBuilder(
                              animation: _animationController,
                              builder: (_, Widget child) {
                                return Text(
                                  timerString,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                          new Text(
                            " detik!",
                            style:
                                TextStyle(fontSize: 11.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: submitOTP,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                      child: Text(is_submited ? 'Loading ...' : 'Selanjutnya'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return widgets;
  }

  Widget otpTextFieldContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        otpTextField(textEditingController1, focusNode1, focusNode2,
            TextInputAction.next),
        SizedBox(
          width: 5.0,
        ),
        otpTextField(textEditingController2, focusNode2, focusNode3,
            TextInputAction.next),
        SizedBox(
          width: 5.0,
        ),
        otpTextField(textEditingController3, focusNode3, focusNode4,
            TextInputAction.next),
        SizedBox(
          width: 5.0,
        ),
        otpTextField(textEditingController4, focusNode4, focusNode5,
            TextInputAction.next),
        SizedBox(
          width: 5.0,
        ),
        otpTextField(textEditingController5, focusNode5, focusNode6,
            TextInputAction.next),
        SizedBox(
          width: 5.0,
        ),
        otpTextField(textEditingController6, focusNode6, focusNode6,
            TextInputAction.done),
      ],
    );
  }

  Widget otpTextField(TextEditingController ctrl, FocusNode currentFocusNode,
      FocusNode nextFocusNode, TextInputAction textInputAction) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
        color: Colors.white,
      ),
      child: TextField(
        keyboardType: TextInputType.numberWithOptions(),
        focusNode: currentFocusNode,
        controller: ctrl,
        textInputAction: textInputAction,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (val) {
          var targetFocusNode;
          print(targetFocusNode);
          print(val);
          print(val.length);
          print(currentFocusNode);
          setState(() {
            var i = val.length + 1;
            print(focusNode6.hasFocus.toString());
          });

          if (val.length > 0) {
            print("masuk ke next focus bangsat");
            currentFocusNode.unfocus();
            targetFocusNode = nextFocusNode;
          }

          // if (val.length < 5) {
          //   currentFocusNode.unfocus();
          //   focusNode6.unfocus();
          //   // currentFocusNode.dispose();
          //   // targetFocusNode = currentFocusNode;
          // }
          FocusScope.of(context).requestFocus(targetFocusNode);
        },
      ),
    );
  }
}
