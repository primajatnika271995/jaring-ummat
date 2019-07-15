import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/storiesBloc.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/video_player_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_stories/image_story.dart';

class Story extends StatefulWidget {
  final String userId;
  StoryByUser contents;

  Story(this.userId, this.contents);

  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final PageController controller = PageController();

  @override
  void initState() {
    print(widget.contents.storyList.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        key: _scaffoldkey,
        body: Stack(
          children: <Widget>[
            PageView.builder(
              itemCount: widget.contents.storyList.length,
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                return widget.contents.storyList[index].contents[0].videoUrl ==
                        null
                    ? ImageStory(
                        imageUri:
                            widget.contents.storyList[index].contents[0].imgUrl,
                      )
                    : VideoStory(
                        videoUri: widget
                            .contents.storyList[index].contents[0].videoUrl,
                        thumbnailUri: widget
                            .contents.storyList[index].contents[0].thumbnailUrl,
                      );
              },
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
              top: 40.0,
              left: 40.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/users/profile.png"),
                        fit: BoxFit.contain,
                      ),
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
                        widget.contents.createdBy,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        TimeAgoService().timeAgoFormatting(
                            widget.contents.storyList[0].createdDate),
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
