import 'dart:async';
import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ChatsResponse.dart';
import 'package:flutter_jaring_ummat/src/bloc/chatsBloc.dart';
import 'package:jstomp/jstomp.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  JStomp stomp = JStomp.instance;

  TextEditingController _textEditingControllerChatsMessage =
      new TextEditingController();

  final streamChats = StreamController<List<ChatsResponse>>();
  List<ChatsResponse> logChats_tmp = new List<ChatsResponse>();

  String fromId = "primajatnika271995@gmail.com";
  String toId = "admin";

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
              Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              new Flexible(
                child: new TextField(
                  controller: _textEditingControllerChatsMessage,
                  decoration: new InputDecoration.collapsed(
                      hintText: "Type a message",
                      hintStyle: TextStyle(color: Colors.grey[400])),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(Icons.send),
                    color: Colors.lightBlue,
                    onPressed: () {
                      sendMsg(_textEditingControllerChatsMessage.text);
                      _textEditingControllerChatsMessage.clear();
                      onSendCallback();
                    }),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: new Row(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            new Text(
              'Admin Amil',
              style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            color: Colors.grey,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          new Flexible(
            child: Container(
              color: Colors.grey.withAlpha(64),
              child: StreamBuilder(
                stream: streamChats.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: logChats_tmp.length,
                    padding: EdgeInsets.all(8.0),
                    itemBuilder: (context, index) {
                      if (logChats_tmp[index].fromId != fromId) {
                        return Bubble(
                          style: styleSomebody,
                          nip: BubbleNip.no,
                          child: Text(snapshot.hasData
                              ? '${logChats_tmp[index].message}'
                              : ''),
                        );
                      } else {
                        return Bubble(
                          style: styleMe,
                          nip: BubbleNip.no,
                          child: Text(snapshot.hasData
                              ? '${logChats_tmp[index].message}'
                              : ''),
                        );
                      }
                    },
                  );
                },
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

  @override
  void initState() {
    bloc.fetchChatsHistory();
    bloc.chatsBehavior.stream.forEach((value) {
      if (mounted) {
        setState(() {
          logChats_tmp = value.reversed.toList();
          streamChats.sink.add(logChats_tmp);
        });
      }
    });
    initStomp();
    super.initState();
  }

  Future initStomp() async {
    if (stomp == null) {
      stomp = JStomp.instance;
    }

    String url = WEBSOCKET_CHAT;
    bool b = await stomp.init(url: url, sendUrl: '/chat/request');

    print(b ? 'Initialization Succesfull' : 'Initialization Failed');

    if (b) {
      await stomp.connection((open) {
        print("The connection is open ...$open");
      }, onError: (error) {
        print("Connection open error...$error");
      }, onClosed: (closed) {
        print("Connection open error...$closed");
      });
    }

    subscribeMsg();
  }

  Future<String> sendMsg(String pesan) async {
    Map<String, dynamic> msg = {
      "fromId": fromId,
      "toId": toId,
      "message": pesan,
    };

    var log = ChatsResponse(fromId: fromId, toId: toId, message: pesan);

    logChats_tmp.add(log);
    return await stomp.sendMessage(json.encode(msg));
  }

  Future<String> subscribeMsg() async {
    final String p2p = "/secure/user/$fromId/chat/send";
    await stomp.subscribP2P([p2p]);
    onMessageCallbacks();
  }

  void onSendCallback() async {
    await stomp.onSendCallback((status, sendMsg) {
      print("Pesan Terkirim：$status :msg=" + sendMsg.toString());
      streamChats.sink.add(logChats_tmp);
    });
  }

  void onMessageCallbacks() async {
    await stomp.onMessageCallback((message) {
      print("Menerima pesan baru p2p：" + message.toString());
      var data = json.decode(message);
      var log = ChatsResponse(
          fromId: data["fromId"], toId: data["toId"], message: data["message"]);

      logChats_tmp.add(log);
      streamChats.sink.add(logChats_tmp);
    });
  }
}
