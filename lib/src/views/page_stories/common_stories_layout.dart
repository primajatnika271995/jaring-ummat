import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/storiesBloc.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
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
    print(widget.contents.storyList[1].id);
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
        body: PageView.builder(
          itemCount: widget.contents.storyList.length,
          controller: controller,
          itemBuilder: (BuildContext context, int index) {
            return widget.contents.storyList[index].contents[0].videoUrl == null
                ? ImageStory(
                    imageUri:
                        widget.contents.storyList[index].contents[0].imgUrl,
                  )
                : VideoStory(
                    videoUri:
                        widget.contents.storyList[index].contents[0].videoUrl,
                    thumbnailUri: widget
                        .contents.storyList[index].contents[0].thumbnailUrl,
                  );
          },
        ),
      ),
    );
  }

  Widget _getStoryItem() {
    return StreamBuilder(
      stream: bloc.allStoryByIdUser,
      builder: (BuildContext context, AsyncSnapshot<StoryByUser> snapshot) {
        print('Snaps Data${snapshot.data.userId}');
        List<String> imageUri = new List<String>();
        List<String> videoUri = new List<String>();
        List<String> thumbnailUri = new List<String>();
        snapshot.data.storyList.forEach((val) {
          val.contents.forEach((data) {
            imageUri.add(data.imgUrl);
            videoUri.add(data.videoUrl);
            thumbnailUri.add(data.thumbnailUrl);
          });
        });

        if (snapshot.hasData && snapshot != null) {
          return videoUri[1] == null
              ? ImageStory(
                  imageUri: imageUri[1],
                )
              : VideoStory(
                  videoUri: videoUri[1],
                  thumbnailUri: thumbnailUri[1],
                );
        }

        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
