import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:video_player/video_player.dart';

class VideoStory extends StatefulWidget {

  int index = 0;
  List<StoryList> content;

  VideoStory({
    Key key,
    @required this.content,
    @required this.index,
  }) : super(key: key);

  @override
  _VideoStoryState createState() =>
      _VideoStoryState(content: content, index: index);
}

class _VideoStoryState extends State<VideoStory> {
  int index = 0;
  VideoPlayerController _controller;
  List<StoryList> content;

  _VideoStoryState({
    Key key,
    this.content,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Story",
      child: GestureDetector(
        onVerticalDragEnd: (DragEndDetails dwon) {
          if (dwon.primaryVelocity > 800) {
            Navigator.pop(context);
          }
        },
        child: _controller.value.initialized
            ? Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print(this.index);
    _controller = VideoPlayerController.network(this.content[index].url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
