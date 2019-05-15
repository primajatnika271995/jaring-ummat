import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget showAlertDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(text),
      );
    },
  );
}

Widget resetPasswordDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: new Card(
              child: new Container(
                height: 340.0,
                child: new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.only(right: 10.0, top: 10.0),
                          child: new Icon(Icons.cancel),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: SvgPicture.asset(
                        "assets/icon/create_account_step_1.svg",
                        color: Colors.white,
                        semanticsLabel: 'logo',
                        width: 100,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    new Container(
                      child: new Text('Masukan Email yang Terdaftar'),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[200]),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.5),
                      child: Stack(
                        alignment: const Alignment(1.0, 0.0),
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.email, size: 15.0),
                                border: InputBorder.none,
                                hintText: "ridwan.ramadhan@gmail.com"),
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, '/onboarding/step1');
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        padding:
                        const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                        child: Text('Kirim OTP'),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}
