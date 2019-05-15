import 'package:flutter/material.dart';

Widget ContainerBackground() {
  return Container(
    decoration: BoxDecoration(
      // color: Colors.black,
      image: DecorationImage(
        // colorFilter: new ColorFilter.mode(
        //   Colors.black.withOpacity(0.4), BlendMode.darken),
        image: AssetImage("assets/backgrounds/background_jaring_ummat.jpg"),
        fit: BoxFit.cover,
      )
    )
  );
}