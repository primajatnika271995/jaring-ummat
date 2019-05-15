import 'package:flutter/material.dart';

class CommunityBox extends StatelessWidget {
  String iconPath;
  String name;
  String totalFollowers;
  String totalEvents;

  CommunityBox({this.iconPath, this.name, this.totalFollowers, this.totalEvents});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration (
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: 30.0,
              height: 30.0,
              color: Colors.blueAccent
            )
          ),
          SizedBox(width: 10.0,),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.name,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ),
                Text(this.totalFollowers + ' Pengikut',
                  style: TextStyle(
                    fontSize: 12.0
                  ),
                ),
                Text(this.totalEvents + ' Aksi Galang Amal',
                  style: TextStyle(
                    fontSize: 12.0
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10.0,),
          Expanded(
            flex: 3,
            child: RaisedButton(
              onPressed: () { },
              textColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              color: Color.fromRGBO(111, 113, 247, 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                child: Text('Ikuti',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}