import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import '../home.dart';

class SuccessRegisterView extends StatelessWidget {

  String email;
  String username;
  File avatarImage;

  SuccessRegisterView({Key key, @required this.avatarImage, this.email, this.username});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.darken),
                  image: AssetImage("assets/backgrounds/bg_step_1.png"),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                margin: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 2.0),
                    image: DecorationImage(
                      image: avatarImage == null
                          ? AssetImage("assets/users/user-profile-sample.png")
                          : FileImage(avatarImage),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Selamat! Pendaftaran Anda Berhasil",
                    style: TextStyle(color: Colors.white)),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, 
                    MaterialPageRoute(builder: (BuildContext context) => HomeView()),
                    ModalRoute.withName('/home'),);
                },
                textColor: Colors.white,
                padding: EdgeInsets.all(0.0),
                color: Color.fromRGBO(111, 113, 247, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                  child: Text('Mulai Beramal',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ))
        ],
      )),
    );
  }
}
