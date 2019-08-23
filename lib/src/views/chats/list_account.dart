import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/views/chats/chats_screen.dart';

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
          child: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: new Text(
          'Chats',
          style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
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
                image: NetworkImage(value?.imageContent[0].imgUrl),
              ),
            ),
          ),
          trailing: Icon(Icons.chat_bubble_outline),
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
