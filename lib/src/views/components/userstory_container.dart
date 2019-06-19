import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:video_player/video_player.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class UserStoryContainerOld extends StatefulWidget {

  String url;
  String createdBy;
  int createdDate;
  UserStoryContainerOld({@required this.url, this.createdBy, this.createdDate});

  @override
  State<StatefulWidget> createState() {
    return UserStoryContainerOldState();
  }
}

class UserStoryContainerOldState extends State<UserStoryContainerOld> {

  int currentImageIdx = 0;
  String currentImageUrl;

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {
        });
      });
    _controller.play();
    _controller.setLooping(false);
    _controller.value.position.inMicroseconds;
    Timer.periodic(Duration(seconds: 15), (Timer t) {
      print(t);
    });
  }

  Widget linearProgress() {
    return LinearPercentIndicator(
      lineHeight: 3.0,
      width: MediaQuery.of(context).size.width,
      progressColor: Colors.blue,
      animationDuration: 15000,
      percent: 1,
      animation: true,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        image(),
        topBar(),
      ],
    );
  }

  Widget topBar() {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      width: double.infinity,
      height: 120,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          linearProgress(),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/users/user-profile-sample.png"),
                    fit: BoxFit.contain,
                  )),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.createdBy,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      TimeAgoService().timeAgoFormatting(widget.createdDate),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget image() {
    return Container(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
