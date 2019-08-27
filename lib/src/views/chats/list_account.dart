import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/chatsBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/accountChatsModel.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/views/chats/chats_screen.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';

class ListAccountChat extends StatefulWidget {
  @override
  _ListAccountChatState createState() => _ListAccountChatState();
}

class _ListAccountChatState extends State<ListAccountChat> {
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          titleSpacing: 0.0,
          elevation: 1.0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(NewIcon.back_big_3x, color: greenColor),
          ),
          title: new Text(
            'Obrolan Amil',
            style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(left: 10.0),
              onPressed: () {},
              icon: Icon(NewIcon.search_big_3x),
              color: greenColor,
            ),
            IconButton(
              padding: EdgeInsets.only(right: 20.0),
              onPressed: () {},
              icon: Icon(NewIcon.delete_3x),
              color: greenColor,
            ),
          ],
        ),
        body: StreamBuilder(
          stream: bloc.streamAccount,
          builder: (context, AsyncSnapshot<List<AccountChats>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                _loadingVisible = true;
                return Text('');
                break;
              default:
                if (snapshot.hasData) {
                  _loadingVisible = false;
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
      ),
    );
  }

  Widget listBuilder(AsyncSnapshot<List<AccountChats>> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        var value = snapshot.data[index];
        return ListTile(
          title: Text(value?.username),
          subtitle: Text(value?.tipeUser),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  idLembaga: value.id,
                  email: value.email,
                ),
              ),
            );
          },
          leading: CircleAvatar(
            child: Text(
              value.email.substring(0, 1).toUpperCase(),
            ),
          ),
          trailing: Icon(Icons.chat_bubble_outline),
        );
      },
    );
  }

  @override
  void initState() {
    bloc.fetchAccount();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
