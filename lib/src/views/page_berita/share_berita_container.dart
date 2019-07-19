import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareBerita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      padding: EdgeInsets.only(
        top: 45.0,
      ),
      child: GridView.count(
        crossAxisCount: 4,
        children: <Widget>[
          Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.linkedin,
                size: 35.0,
                color: Colors.blue,
              ),
              SizedBox(
                height: 10.0,
              ),
              const Text(
                'LinkedIn',
                style: TextStyle(
                  fontFamily: 'Proxima',
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.facebookF,
                size: 35.0,
                color: Colors.blueAccent,
              ),
              SizedBox(
                height: 10.0,
              ),
              const Text(
                'Facebook',
                style: TextStyle(
                  fontFamily: 'Proxima',
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.whatsapp,
                size: 35.0,
                color: Colors.green,
              ),
              SizedBox(
                height: 10.0,
              ),
              const Text(
                'WhatsApp',
                style: TextStyle(
                  fontFamily: 'Proxima',
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.instagram,
                size: 35.0,
                color: Colors.orangeAccent,
              ),
              SizedBox(
                height: 10.0,
              ),
              const Text(
                'Instagram',
                style: TextStyle(
                  fontFamily: 'Proxima',
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.twitter,
                size: 35.0,
                color: Colors.blue,
              ),
              SizedBox(
                height: 10.0,
              ),
              const Text(
                'Twitter',
                style: TextStyle(
                  fontFamily: 'Proxima',
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.twitch,
                size: 35.0,
                color: Colors.purple,
              ),
              SizedBox(
                height: 10.0,
              ),
              const Text(
                'Twitch',
                style: TextStyle(
                  fontFamily: 'Proxima',
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
