import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final EdgeInsetsGeometry padding;
  IconAndText({this.icon, this.title, this.subtitle, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        children: <Widget>[
          this.icon,
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(this.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                )),
          ),
          Text(this.subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}