import 'dart:io';
import 'dart:convert';

import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';

class VideoStoryPreviews extends StatefulWidget {
  String path;
  VideoStoryPreviews({@required this.path});

  @override
  _VideoStoryPreviewsState createState() => _VideoStoryPreviewsState();
}

class _VideoStoryPreviewsState extends State<VideoStoryPreviews> {
  VideoPlayerController playerController;
  VoidCallback listener;
  SharedPreferences _preferences;
  bool _isSubmit = false;

  @override
  void initState() {
    super.initState();
    listener = () {};
    playerController = VideoPlayerController.file(File(widget.path))
      ..addListener(listener)
      ..setVolume(1.0)
      ..initialize()
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: (playerController != null
                ? VideoPlayer(
                    playerController,
                  )
                : Container()),
          ),
          Positioned(
            top: 30.0,
            left: 10.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 40.0,
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            width: MediaQuery.of(context).size.width,
            height: 70.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black.withOpacity(0.1)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40.0,
            left: 27.0,
            child: CircularProfileAvatar(
              'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4',
              borderWidth: 3.0,
              radius: 25.0,
              elevation: 15.0,
              cacheImage: true,
              borderColor: Colors.blue,
              backgroundColor: Colors.transparent,
            ),
          ),
          Positioned(
            bottom: 15.0,
            left: 20.0,
            height: 20.0,
            child: Container(
              child: Text(
                "Your Story",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            right: 20.0,
            bottom: 25.0,
            child: RaisedButton(
              onPressed: _isSubmit ? null : () {
                onSaveVideo();
              },
              elevation: 10.0,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.white,
              textColor: Colors.white,
              padding: EdgeInsets.all(0.0),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      _isSubmit ? 'Loading ...' : 'Post Story',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future onSaveVideo() async {
    StoriesApiProvider service = new StoriesApiProvider();
    _preferences = await SharedPreferences.getInstance();
    String userId = _preferences.getString("userId");
    String createdBy = _preferences.getString("fullname");

    setState(() {
      _isSubmit = true;
    });

    await service.saveStoryData(userId, createdBy).then((response) {
      print("For Response Story Videos Post ${response.statusCode}");

      Toast.show(' Text Stories ${response.statusCode}',
          context,
          backgroundColor: Colors.red,
          duration: 3,
          textColor: Colors.white);

      if (response.statusCode == 200) {

        Toast.show(
            ' Content Stories ${response.statusCode}',
            context,
            backgroundColor: Colors.red,
            duration: 3,
            textColor: Colors.white);

        var data = json.decode(response.body);
        print(data["id"]);
        service.uploadVideo(data["id"], widget.path).then((response) {
          print(response.statusCode);
          Navigator.of(context).pushReplacementNamed("/home");
        });
      }
    });
  }

  @override
  void deactivate() {
    if (playerController != null) {
      playerController.setVolume(0.0);
      playerController.removeListener(listener);
    }
    super.deactivate();
  }
}
