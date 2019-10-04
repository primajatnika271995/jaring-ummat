import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/views/chats/chats_screen.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';

class ListAccountChat extends StatefulWidget {
  @override
  _ListAccountChatState createState() => _ListAccountChatState();
}

class _ListAccountChatState extends State<ListAccountChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        titleSpacing: 0.0,
        elevation: 1.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(NewIcon.back_big_3x, size: 20.0, color: blackColor),
        ),
        title: new Text('Obrolan Amil', style: TextStyle(color: blackColor),),
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(left: 10.0),
            onPressed: () {},
            iconSize: 20.0,
            icon: Icon(NewIcon.search_big_3x),
            color: blackColor,
          ),
          IconButton(
            padding: EdgeInsets.only(right: 20.0),
            onPressed: () {},
            iconSize: 20.0,
            icon: Icon(NewIcon.delete_3x),
            color: blackColor,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.allLembagaAmalListbyCategory,
        builder: (context, AsyncSnapshot<List<LembagaAmalModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              );
              break;
            default:
              if (snapshot.hasData) {
                return listBuilder(snapshot);
              } else {
                return Container(
                  child: Center(
                    child: const Text('NO DATA'),
                  ),
                );
              }
              break;
          }
        },
      ),
    );
  }

  Widget listBuilder(AsyncSnapshot<List<LembagaAmalModel>> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        var value = snapshot.data[index];
        return ListTile(
          title: Text(value?.lembagaAmalName),
          subtitle: Text(value?.lembagaAmalCategory),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  emailLembaga: value.lembagaAmalEmail,
                  name: value.lembagaAmalName,
                ),
              ),
            );
          },
          leading: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: value.imageContent == null
                    ? NetworkImage(
                        'https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png')
                    : NetworkImage(value?.imageContent),
              ),
            ),
          ),
          trailing: Icon(NewIcon.chat_3x, size: 20.0, color: blackColor),
        );
      },
    );
  }

  @override
  void initState() {
    bloc.fetchAllLembagaAmalbyFollowed();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
