import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/bookmarkBloc.dart';
import 'package:flutter_jaring_ummat/src/models/bookmarkModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_bookmark/bookmark-program-amal-container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(AllInOneIcon.back_small_2x),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 20,
        ),
        title: Text(
          'Galang Amal Tersimpan',
          style: TextStyle(fontSize: SizeUtils.titleSize, color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: bookmarkBloc.streamBookmarkList,
        builder: (BuildContext context, AsyncSnapshot<BookmarkModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text('Waiting...'),
              );
              break;
            default:
              if (snapshot.hasData) {
                return listBuilder(snapshot.data);
              }
              return Center(
                child: Text('No Data Bookmark'),
              );
          }
        },
      ),
    );
  }

  Widget listBuilder(BookmarkModel snapshot) {
    return ListView.separated(
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: new SizedBox(
            height: 10.0,
            child: new Center(
              child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.grey[100]),
            ),
          ),
        );
      },
      itemCount: snapshot.listProgram.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.listProgram[index];
        return BookmarkProgramAmalContent(
            programAmal: value,
            likes: value.userLikeThis,
            bookmark: value.bookmarkThis);
      },
    );
  }

  @override
  void initState() {
    bookmarkBloc.fetchBookmarkList();
    super.initState();
  }
}
