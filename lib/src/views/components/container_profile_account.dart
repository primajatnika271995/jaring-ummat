import 'package:flutter/material.dart';

class ContainerProfileAccount extends StatefulWidget {
  final String profileId;
  final String name;
  final String totalFollowers;
  final String totalEvents;
  final String imgIcon;
  bool isFollowed = false;

  ContainerProfileAccount({Key key, this.profileId, this.name, this.totalFollowers, this.imgIcon, this.totalEvents, this.isFollowed = false});

  @override
  State<StatefulWidget> createState() {
    return ContainerProfileAccountState(
      name: this.name,
      totalFollowers: this.totalFollowers,
      totalEvents: this.totalEvents,
      isFollowed: this.isFollowed,
      imgIcon: this.imgIcon
    );
  }
}

class ContainerProfileAccountState extends State<ContainerProfileAccount> {
  final String profileId;
  final String name;
  final String totalFollowers;
  final String totalEvents;
  final String imgIcon;
  bool isFollowed = false;

  ContainerProfileAccountState({this.profileId, this.name, this.totalFollowers, this.imgIcon, this.totalEvents, this.isFollowed = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(2.0, 10.0, 10.0, 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: containerIconProfileAccount(this.imgIcon),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  textAccountName(this.name),
                  SizedBox(height: 3.0,),
                  textTotalFollowers(this.totalFollowers),
                  textTotalEvents(this.totalEvents)
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: this.isFollowed ? buttonFollowed() : buttonFollow(),
            ),
          ],
        ),
      )
    );
  }

  Widget textAccountName(String accountName) {
    accountName = (accountName != null) ? accountName : '';
    return Text(accountName,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.0
      ),
    );
  }

  Widget textInfo(String infoText) {
    infoText = (infoText != null) ? infoText : '';
    return Text(infoText,
      style: TextStyle(
        fontSize: 11.0
      ),
    );
  }

  Widget textTotalFollowers(String totalFollowers) {
    totalFollowers = (totalFollowers != null) ? totalFollowers + ' Pengikut' : '0 Pengikut';
    return textInfo(totalFollowers);
  }

  Widget textTotalEvents(String totalEvents) {
    totalEvents = (totalEvents != null) ? totalEvents + ' Aksi Galang Amal' : '0 Aksi Galang Amal';
    return textInfo(totalEvents);
  }

  Widget containerIconProfileAccount(String imgIcon) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgIcon),
          fit: BoxFit.contain,
        )
      ),
    );
  }

Widget containerIconProfileAccount2() {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/users/rumah-harapan.png"),
          fit: BoxFit.contain,
        )
      ),
    );
  }

  Widget buttonFollow() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          // TODO: call follow API
          this.isFollowed = true;
        });
      },
      color: Color.fromRGBO(21, 101, 192, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Text('Ikuti',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget buttonFollowed() {
    return RaisedButton(
      onPressed: () {
        setState(() {
          // TODO: call UN-follow API
          this.isFollowed = false;
        });
      },
      color: Color.fromRGBO(165, 219, 98, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Icon(
          Icons.check, 
          color: Colors.white,
        )
      ),
    );
  }

  Widget buttonMenu() {
    return RawMaterialButton(
      onPressed: () {},
      child: Icon(
        Icons.menu,
        color: Colors.white
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: Color.fromRGBO(255, 221, 73, 1.0),
      padding: EdgeInsets.all(3.0),
    );
  }
}

