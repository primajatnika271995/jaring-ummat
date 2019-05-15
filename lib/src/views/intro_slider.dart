import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/login.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  
  SharedPreferences _preferences;
  
  @override
  void initState() {
    super.initState();
    setOnlyFirstIntallation();
  }
  
  void setOnlyFirstIntallation() async {
    _preferences = await SharedPreferences.getInstance();
    _preferences.setBool(INTRO_SLIDER_KEY, false);
  }

  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        // iconImageAssetPath: 'assets/air-hostess.png',]
        body: Text(
          'Hi, Jarumian! Masih susah beramal? Hayuk, rasakan kemudahan dan menyenangkannya beramal di jaring Ummat!',
          style: TextStyle(fontSize: 15.0),
        ),
        title: Text(
          'Mudah dan Indahnya Beramal',
          style: TextStyle(fontSize: 25.0,),
          textAlign: TextAlign.center,
        ),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset(
          'assets/icon/intro1.png',
          height: 285.0,
          width: 285.0,
          color: Colors.white,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      body: Text(
        'Pengen tau berapa banyak amalmu? Jangan pusing, Jaring Ummat bantu catatin amalmu!',
        style: TextStyle(fontSize: 15.0),
      ),
      title: Text(
        'Portofolio Amal',
        style: TextStyle(fontSize: 25.0),
      ),
      mainImage: Image.asset(
        'assets/icon/intro2.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
    PageViewModel(
      pageColor: const Color(0xFF607D8B),
      body: Text(
        'Jangan ragu Jarumian! Semua aktifitas amalmu disalurkan oleh Amil Syar\'iy melalui Bank syariah',
        style: TextStyle(fontSize: 15.0),
      ),
      title: Text(
        'Syar\'iy',
        style: TextStyle(fontSize: 25.0),
      ),
      mainImage: Image.asset(
        'assets/icon/intro3.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(
        pages,
        onTapDoneButton: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginView(),
            ), //MaterialPageRoute
          );
        },
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ), //IntroViewsFl,
    );
  }
}
