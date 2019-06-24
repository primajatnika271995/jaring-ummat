import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerContainer extends StatefulWidget {

  final VideoPlayerController videoPlayerController;
  final bool looping;
  VideoPlayerContainer({@required this.videoPlayerController, this.looping});

  @override
  _VideoPlayerContainerState createState() => _VideoPlayerContainerState();
}

class _VideoPlayerContainerState extends State<VideoPlayerContainer> {
  ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 18 / 32,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      allowMuting: true,
      cupertinoProgressColors: ChewieProgressColors(playedColor: Colors.blue, backgroundColor: Colors.grey),
//      showControls: false,
      looping: widget.looping,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Chewie(
        controller: _chewieController,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//     widget.videoPlayerController.dispose();
//     _chewieController.dispose();
  }
}
