import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/app.dart';


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

  @override
  void initState() {
    checkIfAuthenticated().then((_) async {
      Navigator.of(context).pushReplacementNamed('/home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/splash_screen.gif', scale: 3.0,),
      ),
    );
  }
}
