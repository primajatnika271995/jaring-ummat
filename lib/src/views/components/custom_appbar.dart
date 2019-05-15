import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/header_custom_icons.dart';

Widget searchBoxContainer() {
  return Padding(
    padding: EdgeInsets.only(left: 10.0, right: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print(1);
          },
          child: Icon(
            HeaderCustom.ic_news,
            size: 20.0,
            color: Colors.white,
          ),
        ),
        Container(
          width: 270.0,
          height: 25.0,
          padding: EdgeInsets.fromLTRB(10.0, 0.5, 10.0, 0.5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
          child: TextField(
            style: TextStyle(fontSize: 10.0, color: Colors.black, height: 0.4),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Cari galang atau badan amil',
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print(1);
          },
          child: Icon(
            HeaderCustom.ic_comment_inactive,
            size: 20.0,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

class CustomAppBar extends AppBar {
  CustomAppBar()
      : super(
            elevation: 0.25,
            backgroundColor: Colors.white,
            title: Stack(
              children: <Widget>[searchBoxContainer()],
            ),
            flexibleSpace: _buildCustomAppBar());

  static Widget _buildCustomAppBar() {
    return new Container(
        height: 200.0,
        decoration: new BoxDecoration(
          color: Colors.orange,
          boxShadow: [new BoxShadow(blurRadius: 10.0)],
          borderRadius:
              new BorderRadius.vertical(bottom: new Radius.circular(30.0)),
        ));
  }
}
