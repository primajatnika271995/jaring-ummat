import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/app.dart';

import 'src/config/preferences.dart';

checkIfAuthenticated() async {
  await Future.delayed(Duration(seconds: 6));
  return true;
}

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  App();
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  SharedPreferences _preferences;

  @override
  void initState() {
    checkIfAuthenticated().then((_) async {
      _preferences = await SharedPreferences.getInstance();
      var token = _preferences.getString(ACCESS_TOKEN_KEY);
      if (token == null) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SpinKitThreeBounce(
          color: Colors.white,
          size: 20.0,
        ),
      ),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.3), BlendMode.dstATop),
          image: AssetImage('assets/backgrounds/background_jaring_ummat.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
