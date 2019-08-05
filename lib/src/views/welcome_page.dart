import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/create_account_icons.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offset;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 0.10))
        .animate(_controller);

    switch (_controller.status) {
      case AnimationStatus.completed:
        _controller.reverse();
        break;
      case AnimationStatus.dismissed:
        _controller.forward();
        break;
      default:
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logo = SlideTransition(
      position: _offset,
      child: Icon(
        CreateAccount.jaring_ummat_new_logo,
        color: Colors.black54,
        size: 100.0,
      ),
    );

    final text1 = Text(
      'Jaring Ummat',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );

    final text2 = Text(
      'Mudah dan syar\'i, indahnya beramal, hidupkanmu!',
      style: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );

    final loginButton = RaisedButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/login');
      },
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: const Text(
        'SIGN IN / SIGN UP',
        style: TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logo,
            SizedBox(
              height: 20.0,
            ),
            text1,
            text2,
            SizedBox(
              height: 40.0,
            ),
            loginButton
          ],
        ),
      ),
    );
  }
}
