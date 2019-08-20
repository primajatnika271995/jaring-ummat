import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );

    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    Widget _chatEnvironment() {
      return IconTheme(
        data: new IconThemeData(color: Colors.blue),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  decoration: new InputDecoration.collapsed(
                      hintText: "Start typing ..."),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send), onPressed: () {}),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0.0,
        elevation: 1.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: new Text(
          'Amil Account',
          style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          new Flexible(
            child: Container(
              color: Colors.grey.withAlpha(64),
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: [
                  Bubble(
                    alignment: Alignment.center,
                    color: Color.fromARGB(255, 212, 234, 244),
                    elevation: 1 * px,
                    margin: BubbleEdges.only(top: 8.0),
                    child: Text('TODAY', style: TextStyle(fontSize: 10)),
                  ),
                  Bubble(
                    style: styleSomebody,
                    child: Text(
                        'Hi Jason. Sorry to bother you. I have a queston for you.'),
                  ),
                  Bubble(
                    style: styleMe,
                    child: Text('Whats\'up?'),
                  ),
                  Bubble(
                    style: styleSomebody,
                    child:
                        Text('I\'ve been having a problem with my computer.'),
                  ),
                  Bubble(
                    style: styleSomebody,
                    margin: BubbleEdges.only(top: 2.0),
                    nip: BubbleNip.no,
                    child: Text('Can you help me?'),
                  ),
                  Bubble(
                    style: styleMe,
                    child: Text('Ok'),
                  ),
                  Bubble(
                    style: styleMe,
                    nip: BubbleNip.no,
                    margin: BubbleEdges.only(top: 2.0),
                    child: Text('What\'s the problem?'),
                  ),
                  Bubble(
                    style: styleMe,
                    nip: BubbleNip.no,
                    margin: BubbleEdges.only(top: 2.0),
                    child: Text('Hmmmmm?'),
                  ),
                ],
              ),
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _chatEnvironment(),
          )
        ],
      ),
    );
  }
}
