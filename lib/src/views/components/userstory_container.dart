import 'dart:async';

import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:video_player/video_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserStoryContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserStoryContainerState();
  }
}

class UserStoryContainerState extends State<UserStoryContainer> {
//  VARIABLE LIST IMMAGE

  List<String> images = [
    "https://bengkulu.kemenag.go.id/file/fotoberita/498616.jpg",
    "https://v-images2.antarafoto.com/pembagian-zakat-kpskq8-prv.jpg"
  ];

  int _currentImageIdx = 0;
  String _currentImageUrl;

  @override
  void initState() {
    super.initState();
  }

//  Widget linearProgress() {
//    return LinearPercentIndicator(
//      lineHeight: 3.0,
//      width: MediaQuery.of(context).size.width,
//      progressColor: Colors.blue,
//      animationDuration: 15000,
//      percent: 1,
//      animation: true,
//    );
//  }

  @override
  Widget build(BuildContext context) {

    setState(() {
      _currentImageUrl = images[_currentImageIdx];
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.network(
                _currentImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              width: MediaQuery.of(context).size.width,
              height: 120.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.3)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10.0,
              top: 40.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                                "assets/users/user-profile-sample.png"),
                            fit: BoxFit.contain,
                          )),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Bamuis BNI',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              '5 menit lalu',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Container(
          height: 50.0,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Container(
              width: 100.0,
              height: 100.0,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/users/orang.png"),
//                      fit: BoxFit.contain,
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
                onPressed: () => {},
              ),
            ],
            centerTitle: true,
            automaticallyImplyLeading: true,
            titleSpacing: 0.0,
            title: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
//                      autofocus: true,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: 7.0, bottom: 7.0, left: -15.0),
                    icon: Icon(Icons.search, size: 18.0),
                    border: InputBorder.none,
                    hintText: 'Tulis komentar anda disini...',
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.grey[200],
              ),
              padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
            ),
          ),
        ),
      ),
    );
  }

  void setImage() {
    setState(() {

      if (_currentImageIdx < images.length - 1) {
        _currentImageIdx = _currentImageIdx + 1;
      } else {
        _currentImageIdx = 0;
      }

      print(_currentImageIdx);
      print('-----');
    });
  }
}
