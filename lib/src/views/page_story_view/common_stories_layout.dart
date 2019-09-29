import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/storiesBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:flutter_jaring_ummat/src/views/page_story_view/image_story.dart';
import 'package:flutter_jaring_ummat/src/views/page_story_view/video_story.dart';

class Story extends StatefulWidget {
  List<StoryList> content;
  int index;
  Story(this.content, this.index);

  @override
  _StoryState createState() => _StoryState(this.index, this.content);
}

class _StoryState extends State<Story> {
  int index;
  List<StoryList> content;
  _StoryState(this.index, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        _getStoryItem(),
        Container(
          alignment: FractionalOffset.bottomCenter,
          margin: EdgeInsets.only(bottom: 48),
        )
      ]),
    );
  }

  Widget _getStoryItem() {
    bool noVideos = content[index].resourceType == "image";
    return noVideos
        ? ImageStory(content: content, index: index)
        : VideoStory(content: content, index: index);

        // Center(
        //     child: Text(
        //       noVideos.toString(),
        //       style: TextStyle(color: blackColor),
        //     ),
        //   );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
