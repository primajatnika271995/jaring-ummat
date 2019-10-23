import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/bookmarkBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/bookmarkModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';
import 'package:flutter_jaring_ummat/src/views/page_bookmark/bookmark-berita.dart';
import 'package:flutter_jaring_ummat/src/views/page_bookmark/bookmark-galang-amal.dart';
import 'package:flutter_jaring_ummat/src/views/page_bookmark/bookmark-program-amal-container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
            'Konten Jaring Tersimpan',
            style:
                TextStyle(fontSize: SizeUtils.titleSize, color: Colors.black),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Semua'),
              Tab(text: 'Galang Amal'),
              Tab(text: 'Berita'),
            ],
            isScrollable: false,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: greenColor,
          ),
        ),
        body: TabBarView(children: [
          StreamBuilder(
            stream: bookmarkBloc.streamBookmarkList,
            builder:
                (BuildContext context, AsyncSnapshot<BookmarkModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Text('Waiting...'),
                  );
                  break;
                default:
                  if (snapshot.hasData) {
                    return SemuaTersimpan(snapshot: snapshot.data);
                  }
                  return Center(
                    child: Text('No Data Bookmark'),
                  );
              }
            },
          ),
          StreamBuilder(
            stream: bookmarkBloc.streamBookmarkList,
            builder:
                (BuildContext context, AsyncSnapshot<BookmarkModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Text('Waiting...'),
                  );
                  break;
                default:
                  if (snapshot.hasData) {
                    return GalangAmalTersimpan(snapshot: snapshot.data);
                  }
                  return Center(
                    child: Text('No Data Bookmark'),
                  );
              }
            },
          ),
          StreamBuilder(
            stream: bookmarkBloc.streamBookmarkList,
            builder:
                (BuildContext context, AsyncSnapshot<BookmarkModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Text('Waiting...'),
                  );
                  break;
                default:
                  if (snapshot.hasData) {
                    return BeritaTersimpan(snapshot: snapshot.data);
                  }
                  return Center(
                    child: Text('No Data Bookmark'),
                  );
              }
            },
          ),
        ]),
      ),
    );
  }

  @override
  void initState() {
    bookmarkBloc.fetchBookmarkList();
    super.initState();
  }
}

class SemuaTersimpan extends StatelessWidget {
  final BookmarkModel snapshot;
  SemuaTersimpan({this.snapshot});

  @override
  Widget build(BuildContext context) {
    bookmarkBloc.fetchBookmarkList();
    return Column(
      children: <Widget>[
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, position) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: new SizedBox(
                height: 10.0,
                child: new Center(
                  child: new Container(
                      margin:
                          new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                      height: 5.0,
                      color: Colors.grey[100]),
                ),
              ),
            );
          },
          itemCount: snapshot.listProgram.length,
          itemBuilder: (BuildContext context, int index) {
            var value = snapshot.listProgram[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookmarkGalangAmalDetails(
                      programAmal: value, likes: value.userLikeThis),
                ));
              },
              leading: Container(
                width: 55.0,
                height: 55.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                    image: (value.imageContent[0].resourceType == "video")
                        ? NetworkImage(value.imageContent[0].urlThumbnail)
                        : NetworkImage(value.imageContent[0].url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                value.titleProgram,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  'oleh ${value.createdBy} • ${TimeAgoService().timeAgoFormatting(value.createdDate)}',
                  style: TextStyle(fontSize: 12.0, color: grayColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
          child: new SizedBox(
            height: 10.0,
            child: new Center(
              child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.grey[100]),
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, position) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: new SizedBox(
                height: 10.0,
                child: new Center(
                  child: new Container(
                      margin:
                          new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                      height: 5.0,
                      color: Colors.grey[100]),
                ),
              ),
            );
          },
          itemCount: snapshot.listBerita.length,
          itemBuilder: (BuildContext context, int index) {
            var value = snapshot.listBerita[index];
            return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BookmarkBeritaDetails(value: value),
                  ));
                },
                leading: Container(
                  width: 55.0,
                  height: 55.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                      image: (value.imageContent[0].resourceType == "video")
                          ? NetworkImage(value.imageContent[0].urlThumbnail)
                          : NetworkImage(value.imageContent[0].url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  value.titleBerita,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    'oleh ${value.createdBy} • ${TimeAgoService().timeAgoFormatting(value.createdDate)}',
                    style: TextStyle(fontSize: 12.0, color: grayColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ));
//        return BookmarkProgramAmalContent(
//            programAmal: value,
//            likes: value.userLikeThis,
//            bookmark: value.bookmarkThis);
          },
        ),
      ],
    );
  }
}

class BeritaTersimpan extends StatelessWidget {
  final BookmarkModel snapshot;
  BeritaTersimpan({this.snapshot});

  @override
  Widget build(BuildContext context) {
    bookmarkBloc.fetchBookmarkList();
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
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
      itemCount: snapshot.listBerita.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.listBerita[index];
        return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BookmarkBeritaDetails(value: value),
              ));
            },
            leading: Container(
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: (value.imageContent[0].resourceType == "video")
                      ? NetworkImage(value.imageContent[0].urlThumbnail)
                      : NetworkImage(value.imageContent[0].url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              value.titleBerita,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                'oleh ${value.createdBy} • ${TimeAgoService().timeAgoFormatting(value.createdDate)}',
                style: TextStyle(fontSize: 12.0, color: grayColor),
                overflow: TextOverflow.ellipsis,
              ),
            ));
//        return BookmarkProgramAmalContent(
//            programAmal: value,
//            likes: value.userLikeThis,
//            bookmark: value.bookmarkThis);
      },
    );
  }
}

class GalangAmalTersimpan extends StatelessWidget {
  final BookmarkModel snapshot;
  GalangAmalTersimpan({this.snapshot});

  @override
  Widget build(BuildContext context) {
    bookmarkBloc.fetchBookmarkList();
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 10),
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
        return ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BookmarkGalangAmalDetails(
                    programAmal: value, likes: value.userLikeThis),
              ));
            },
            leading: Container(
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: (value.imageContent[0].resourceType == "video")
                      ? NetworkImage(value.imageContent[0].urlThumbnail)
                      : NetworkImage(value.imageContent[0].url),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              value.titleProgram,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                'oleh ${value.createdBy} • ${TimeAgoService().timeAgoFormatting(value.createdDate)}',
                style: TextStyle(fontSize: 12.0, color: grayColor),
                overflow: TextOverflow.ellipsis,
              ),
            ));
//        return BookmarkProgramAmalContent(
//            programAmal: value,
//            likes: value.userLikeThis,
//            bookmark: value.bookmarkThis);
      },
    );
  }
}
