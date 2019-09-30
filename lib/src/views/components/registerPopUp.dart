import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';

void onSuccess(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        elevation: 0.0,
        backgroundColor: Colors.white,
        child: Container(
          height: 500.0,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          iconSize: 20,
                          color: greenColor,
                          icon: Icon(NewIcon.close_2x),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Buat Akun Sukses! \n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5.0, left: 40, right: 40),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Selamat! Pembuatan akun Anda berhasil.',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                          TextSpan(
                            text: 'Mari mulai lakukan kebaikan untuk sesama!',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 20),
                  child: Container(
                    width: screenWidth(context),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/backgrounds/accent_success.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, left: 20.0, right: 20.0, bottom: 20),
                  child: Container(
                    width: screenWidth(context),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      color: greenColor,
                      child: const Text('Bismillah',
                          style: TextStyle(color: Colors.white)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
