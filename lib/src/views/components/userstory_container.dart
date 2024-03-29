import 'dart:async';
import 'dart:convert';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/storiesModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/active_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:story_view/story_view.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';

class StoryPlayerView extends StatefulWidget {
  final String createdBy;
  final int createdDate;
  final List<StoryList> content;
  StoryPlayerView({this.createdBy, this.createdDate, this.content});

  @override
  State<StatefulWidget> createState() => StoryPlayerViewState(
      createdBy: this.createdBy,
      createdDate: this.createdDate,
      content: this.content);
}

class StoryPlayerViewState extends State<StoryPlayerView> {
  String createdBy;
  int createdDate;
  List<StoryList> content;
  StoryPlayerViewState({this.createdBy, this.createdDate, this.content});

  final controller = StoryController();

  bool _isLoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(1.0, 25.0, 4.0, 1.0),
                  child: storiesView(),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0.0,
            top: 0.0,
            width: MediaQuery.of(context).size.width,
            height: 130.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black45, Colors.black45.withOpacity(0.1)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: greenColor,
                  child: Text(
                    widget.createdBy.substring(0, 1).toUpperCase(),
                    style: TextStyle(color: whiteColor, fontSize: 18.0),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.createdBy,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      TimeAgoService().timeAgoFormatting(widget.createdDate),
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _komentarField(),
          ),
        ],
      ),
    );
  }

  Widget storiesView() {
    List<StoryItem> widgetList = new List<StoryItem>();
    for (var i = 0; i < content.length; i++) {
      if (content[i].resourceType == "video") {
        widgetList
            .add(StoryItem.pageVideo(content[i].url, controller: controller));
        setState(() {});
      }

      if (content[i].resourceType == "image") {
        widgetList.add(
          StoryItem.pageImage(
            NetworkImage(content[i].url),
            imageFit: BoxFit.cover,
          ),
        );
        setState(() {});
      }
    }

    if (widgetList.isEmpty) {
      return Container(
        color: Colors.blue,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );
    }

    return StoryView(
      widgetList,
      controller: controller,
      onStoryShow: (s) {
        print("Showing a story");
      },
      onComplete: () {
        print("Completed a cycle");
      },
      progressPosition: ProgressPosition.top,
      repeat: false,
    );
  }

  Widget _komentarField() {
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 11.0),
        child: new Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.black45,
              child: _isLoved ? likeBtn() : unlikeBtn(),
            ),
            SizedBox(
              width: 10.0,
            ),
            new Flexible(
              child: new TextField(
                decoration: new InputDecoration(
                  fillColor: Colors.black45,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: "Tulis pesan...",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CircleAvatar(
                backgroundColor: greenColor,
                child: IconButton(
                  icon: new Icon(NewIcon.send_3x),
                  color: Colors.white,
                  iconSize: 20,
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget likeBtn() {
    return IconButton(
      icon: Icon(AllInOneIcon.love_3x),
      onPressed: () {
        _isLoved = !_isLoved;
        setState(() {});
      },
      iconSize: 20,
    );
  }

  Widget unlikeBtn() {
    return IconButton(
      icon: Icon(ActiveIcon.love_active_3x),
      onPressed: () {
        _isLoved = !_isLoved;
        setState(() {});
      },
      color: Colors.red,
      iconSize: 20,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
