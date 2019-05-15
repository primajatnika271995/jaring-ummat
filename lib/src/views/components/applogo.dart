import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget appLogo() {
  return Expanded(
    flex: 3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 30.0),
        SvgPicture.asset(
          "assets/icon/logo.svg",
          color: Colors.white,
          semanticsLabel: 'logo',
          width: 75,
        ),
        SizedBox(height: 15.0),
        Text(
          'Jaring Ummat',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        ),
        Text(
          'Mudah dan syar\'i, indahnya beramal, hidupkanmu!',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )
        )
      ],
    ),
  );
}