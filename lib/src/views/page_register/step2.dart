import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_register/step3.dart';

class StepTwo extends StatefulWidget {
  final String contactKey;
  final String otpKey;
  StepTwo({@required this.contactKey, @required this.otpKey});

  @override
  _StepTwoState createState() => _StepTwoState();
}

class _StepTwoState extends State<StepTwo> with TickerProviderStateMixin {
  AnimationController animationController;

  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusNode focusNode3 = new FocusNode();
  FocusNode focusNode4 = new FocusNode();
  FocusNode focusNode5 = new FocusNode();

  TextEditingController otpDigit1Ctrl = new TextEditingController();
  TextEditingController otpDigit2Ctrl = new TextEditingController();
  TextEditingController otpDigit3Ctrl = new TextEditingController();
  TextEditingController otpDigit4Ctrl = new TextEditingController();
  TextEditingController otpDigit5Ctrl = new TextEditingController();
  TextEditingController otpDigit6Ctrl = new TextEditingController();

  String otp;
  bool otpFilled = false;
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                icon: Icon(
                  NewIcon.back_small_2x,
                  color: Colors.white,
                  size: 15,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
              )),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Input OTP",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontFamily: 'sofiapro-bold'),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/backgrounds/accent_app_width_full_screen.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Masukan kode OTP yang terkirim ke nomor telepon",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    '+62 ' +
                        widget.contactKey
                            .replaceAllMapped(RegExp(r".{4}"),
                                (match) => "${match.group(0)} ")
                            .replaceRange(5, 6, "*")
                            .replaceRange(6, 7, "*")
                            .replaceRange(7, 8, "*")
                            .replaceRange(8, 9, "*"),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  height: 75,
                  width: 295,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100)),
                          child: TextField(
                            controller: otpDigit1Ctrl,
                            keyboardType: TextInputType.numberWithOptions(),
                            textInputAction: TextInputAction.next,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              border: InputBorder.none,
                              counterText: '',
                              hintText: '-',
                            ),
                            onChanged: (value) {
                              checkTextFieldOtp();
                              FocusScope.of(context).requestFocus(focusNode1);
                            },
                          )),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100)),
                          child: TextField(
                            controller: otpDigit2Ctrl,
                            focusNode: focusNode1,
                            keyboardType: TextInputType.numberWithOptions(),
                            textInputAction: TextInputAction.next,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              border: InputBorder.none,
                              counterText: '',
                              hintText: '-',
                            ),
                            onChanged: (value) {
                              checkTextFieldOtp();
                              FocusScope.of(context).requestFocus(focusNode2);
                            },
                          )),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100)),
                          child: TextField(
                            controller: otpDigit3Ctrl,
                            focusNode: focusNode2,
                            keyboardType: TextInputType.numberWithOptions(),
                            textInputAction: TextInputAction.next,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              border: InputBorder.none,
                              counterText: '',
                              hintText: '-',
                            ),
                            onChanged: (value) {
                              checkTextFieldOtp();
                              FocusScope.of(context).requestFocus(focusNode3);
                            },
                          )),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100)),
                          child: TextField(
                            controller: otpDigit4Ctrl,
                            focusNode: focusNode3,
                            keyboardType: TextInputType.numberWithOptions(),
                            textInputAction: TextInputAction.next,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              border: InputBorder.none,
                              counterText: '',
                              hintText: '-',
                            ),
                            onChanged: (value) {
                              checkTextFieldOtp();
                              FocusScope.of(context).requestFocus(focusNode4);
                            },
                          )),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100)),
                          child: TextField(
                            controller: otpDigit5Ctrl,
                            focusNode: focusNode4,
                            keyboardType: TextInputType.numberWithOptions(),
                            textInputAction: TextInputAction.next,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              border: InputBorder.none,
                              counterText: '',
                              hintText: '-',
                            ),
                            onChanged: (value) {
                              checkTextFieldOtp();
                              FocusScope.of(context).requestFocus(focusNode5);
                            },
                          )),
                      Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(100)),
                          child: TextField(
                            controller: otpDigit6Ctrl,
                            focusNode: focusNode5,
                            keyboardType: TextInputType.numberWithOptions(),
                            textInputAction: TextInputAction.done,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 10),
                              border: InputBorder.none,
                              counterText: '',
                              hintText: '-',
                            ),
                            onChanged: (value) {
                              checkTextFieldOtp();
                            },
                          )),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      child: Text("Kode OTP akan berakhir pada"),
                    ),
                    AnimatedBuilder(
                        animation: animationController,
                        builder: (_, Widget child) {
                          return Text(
                            timerString,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          );
                        }),
                  ],
                ),
                Container(
                  height: 35,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 75),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(45)),
                  child: FlatButton(
                    onPressed: () {
                      if (!isSubmitted) submit();
                    },
                    child: Text(
                      isSubmitted ? "Loading..." : "Selanjutnya",
                      style: TextStyle(
                          fontFamily: 'sofiapro-bold',
                          fontSize: 16,
                          color: otpFilled ? Colors.white : Colors.grey[700]),
                    ),
                    color: otpFilled ? Colors.green : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 300));
    startTimer();

    super.initState();
  }

  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void startTimer() {
    setState(() {
      if (animationController.isAnimating) {
        animationController.stop();
      } else {
        animationController.reverse(
            from: animationController.value == 0.0
                ? 1.0
                : animationController.value);
      }
    });
  }

  void checkTextFieldOtp() {
    setState(() {
      if (!otpDigit1Ctrl.text.isEmpty &&
          !otpDigit2Ctrl.text.isEmpty &&
          !otpDigit3Ctrl.text.isEmpty &&
          !otpDigit4Ctrl.text.isEmpty) {
        otpFilled = true;
      } else {
        otpFilled = false;
      }
    });
  }

  void submit() {
    setState(() {
      isSubmitted = true;
    });

    otp = otpDigit1Ctrl.text +
        otpDigit2Ctrl.text +
        otpDigit3Ctrl.text +
        otpDigit4Ctrl.text +
        otpDigit5Ctrl.text +
        otpDigit6Ctrl.text;

    if (otp == widget.otpKey) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => StepThree(
            contactKey: widget.contactKey,
          ),
        ),
      );
    } else {
      setState(() {
        isSubmitted = false;
      });
    }
  }
}
