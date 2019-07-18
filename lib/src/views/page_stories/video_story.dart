import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class VideoStory extends StatefulWidget {
  final String videoUri;
  final String thumbnailsUri;

  VideoStory({this.videoUri, this.thumbnailsUri});

  @override
  _VideoStoryState createState() => _VideoStoryState();
}

class _VideoStoryState extends State<VideoStory> {
  VideoPlayerController _controller;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUri)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
    flutterWebViewPlugin.launch(widget.videoUri);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: WebviewScaffold(
          url: widget.videoUri,
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
