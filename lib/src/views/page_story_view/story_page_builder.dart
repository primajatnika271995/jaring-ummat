import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/page_story_view/common_stories_layout.dart';

class StoryPage extends StatefulWidget {
  String idStory;
  String createdBy;
  int createdDate;
  StoryPage({Key key, this.idStory, this.createdBy, this.createdDate})
      : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState(
      idStory: idStory, createdBy: createdBy, createdDate: createdDate);
}

class _StoryPageState extends State<StoryPage> {
  /*
   * List Content Variable
   */
  List<StoryList> urlContent = List<StoryList>();

  /*
   * SelectedItem
   */
  static int selectedItem;

  /*
   * Item Length
   */
  static int itemLength = 0;

  /*
   * Story by User Provider
   */
  StoriesApiProvider _provider = new StoriesApiProvider();

  String idStory;
  String createdBy;
  int createdDate;
  _StoryPageState({Key key, this.idStory, this.createdBy, this.createdDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            physics: BouncingScrollPhysics(),
            pageSnapping: true,
            itemBuilder: _pageBuilder,
            onPageChanged: _onPageChange,
            itemCount: itemLength,
          ),
          Positioned(
            left: 20.0,
            top: 50.0,
            child: CircularProfileAvatar(
              'https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png',
              borderWidth: 3.0,
              radius: 25.0,
              elevation: 15.0,
              cacheImage: true,
              borderColor: greenColor,
              backgroundColor: whiteColor,
            ),
          ),
          Positioned(
            top: 55,
            left: 75,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      createdBy,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      TimeAgoService().timeAgoFormatting(createdDate),
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageBuilder(BuildContext context, int index) {
    return Center(
      child: urlContent.isEmpty
          ? CircularProgressIndicator()
          : Story(urlContent, index),
    );
  }

  @override
  void initState() {
    super.initState();
    _getListStory();
  }

  void _getListStory() {
    _provider.storiesList(idStory).then((response) {
      print('get story list by id : ${response.statusCode}');
      if (response.statusCode == 200) {
        StoryByUserModel value = StoryByUserModel.fromJson(json.decode(response.body));
        setState(() {
          itemLength = value.storyList.length;
          value.storyList.forEach((data) {
            urlContent.add(data);
          });
        });
      }
    });
  }

  void _onPageChange(int value) {
    setState(() {
      selectedItem = value;
    });
  }
}
