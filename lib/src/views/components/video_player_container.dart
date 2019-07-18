import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class VideoStory extends StatefulWidget {
  final String videoUri;
  final String thumbnailUri;
  VideoStory({Key key, this.videoUri, this.thumbnailUri}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoStory();
}

class _VideoStory extends State<VideoStory> {
  VideoPlayerController _controller;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    print(widget.videoUri);
    _controller = VideoPlayerController.network(widget.videoUri)
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
          child: Container(
        child: _controller.value.initialized
                  ? Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: WebviewScaffold(
                            url: widget.videoUri,
                            withZoom: false,
                          ),
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
                            placeholder: NetworkImage(widget.thumbnailUri),
                            image: NetworkImage(widget.thumbnailUri)),
                        Center(child: CircularProgressIndicator())
                      ],
                    )),
      ),
    );
  }
}