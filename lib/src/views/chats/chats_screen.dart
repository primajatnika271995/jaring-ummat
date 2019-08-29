import 'dart:async';
import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ChatsResponse.dart';
import 'package:flutter_jaring_ummat/src/bloc/chatsBloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:jstomp/jstomp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  final String idLembaga;
  final String email;
  ChatScreen({this.idLembaga, this.email});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  JStomp stomp = JStomp.instance;

  TextEditingController _textEditingControllerChatsMessage =
      new TextEditingController();

  final streamChats = StreamController<List<ChatsResponse>>();
  List<ChatsResponse> logChats_tmp = new List<ChatsResponse>();

  SharedPreferences _preferences;

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
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 11.0),
          child: new Row(
            children: <Widget>[
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Icon(NewIcon.add_picture_camera_3x, color: greenColor),
              ),
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Icon(NewIcon.add_picture_gallery_3x, color: greenColor),
              ),
              SizedBox(
                width: 10.0,
              ),
              new Flexible(
                child: new TextField(
                  controller: _textEditingControllerChatsMessage,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    hintText: "Type a message",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                    icon: new Icon(NewIcon.send_3x),
                    color: greenColor,
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
          child: Icon(NewIcon.back_big_3x, color: greenColor),
        ),
        title: new Text(
          widget.email,
          style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(NewIcon.delete_3x),
            iconSize: 20.0,
            color: greenColor,
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
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    default:
                      return ListView.builder(
                        itemCount: logChats_tmp.length,
                        padding: EdgeInsets.all(8.0),
                        itemBuilder: (context, index) {
                          if (logChats_tmp[index].toId != widget.email) {
                            return Bubble(
                              style: styleSomebody,
                              nip: BubbleNip.no,
                              child: Text(snapshot.hasData
                                  ? '${logChats_tmp[index].message}'
                                  : ''),
                            );
                          } else if (logChats_tmp[0].fromId == 'Today') {
                            return Bubble(
                              color: Color.fromRGBO(212, 234, 244, 1.0),
                              child: Text('TODAY',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11.0)),
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
                      break;
                  }
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
    setState(() {
      logChats_tmp.add(
        ChatsResponse(
          fromId: 'Today',
        ),
      );
    });
    bloc.fetchChatsHistory(widget.email);
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
    bool b = await stomp.init(url: url, sendUrl: '/request/chat');

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
    _preferences = await SharedPreferences.getInstance();
    var email = _preferences.getString(EMAIL_KEY);

    Map<String, dynamic> msg = {
      "fromId": email,
      "toId": widget.email,
      "message": pesan,
    };

    // var log = ChatsResponse(fromId: email, toId: widget.email, message: pesan);

    // logChats_tmp.add(log);
    return await stomp.sendMessage(json.encode(msg));
  }

  Future<String> subscribeMsg() async {
    final String p2p = "/secure/user/${widget.email}/chat/send";
    await stomp.subscribP2P([p2p]);
    onMessageCallbacks();
  }

  void onSendCallback() async {
    _preferences = await SharedPreferences.getInstance();
    var fromId = _preferences.getString(EMAIL_KEY);

    print('from $fromId');
    print('to email ${widget.email}');
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
