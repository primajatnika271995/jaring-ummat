import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoStory extends StatefulWidget {
  final String videoUri;
  final String thumbnailsUri;

  VideoStory({this.videoUri, this.thumbnailsUri});

  @override
  _VideoStoryState createState() => _VideoStoryState();
}

class _VideoStoryState extends State<VideoStory> {
  VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUri)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.initialized
          ? Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16.0/9.0,
                  child: VideoPlayer(_controller),
                ),
              ],
            )
          : Container(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FadeInImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 100),
                      placeholder: NetworkImage(widget.thumbnailsUri),
                      image: NetworkImage(widget.thumbnailsUri)),
                  Center(child: CircularProgressIndicator())
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
