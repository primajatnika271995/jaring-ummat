import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareProgramAmal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: new Column(
        children: <Widget>[
          InkWell(
            onTap: () {},
            highlightColor: Colors.grey,
            child: new Container(
              height: 70.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      'Bagikan Melalui Facebook',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            highlightColor: Colors.grey,
            child: new Container(
              height: 70.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      'Bagikan Melalui WhatsApp',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            highlightColor: Colors.grey,
            child: new Container(
              height: 70.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Icon(
                      FontAwesomeIcons.mailBulk,
                      color: Colors.red,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      'Bagikan Melalui Email',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            highlightColor: Colors.grey,
            child: new Container(
              height: 70.0,
              child: new Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Icon(
                      FontAwesomeIcons.link,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      'Salin Link Berita ini',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
