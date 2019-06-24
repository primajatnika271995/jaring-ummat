import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/storiesModel.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class UserStoryContainerOld extends StatefulWidget {
  String userId;
  String createdBy;
  String video;
  int createdDate;
  UserStoryContainerOld(
      {@required this.userId,
      this.createdBy,
      this.createdDate,
      @required this.video});

  @override
  State<StatefulWidget> createState() {
    return UserStoryContainerOldState();
  }
}

class UserStoryContainerOldState extends State<UserStoryContainerOld> {
  List<Content> urlContent = List<Content>();
  IjkMediaController controller = IjkMediaController();

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    storiesList().then((response) {
      var data = json.decode(response.body);
      Story stories = Story.fromJson(data[0]);
      stories.storyList.forEach((val) {
        setState(() {
          urlContent.add(val.contents[0]);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: PageView.builder(
                  itemCount: urlContent.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(urlContent.length);
                    if (urlContent[index].imgUrl == null) {}
                    return Container(
                      margin: EdgeInsets.fromLTRB(1.0, 25.0, 4.0, 1.0),
                      child: Card(
                        elevation: 10.0,
                        child: Center(
                          child: urlContent[index].imgUrl == null
                              ? videoPlayer(urlContent[index].videoUrl)
                              : Image.network(
                                  urlContent[index].imgUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          // margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://www.skylightsearch.co.uk/wp-content/uploads/2017/01/Loren-profile-pic-circle.png")),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 13,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: TextField(
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                icon: Icon(Icons.search, size: 18.0),
                                border: InputBorder.none,
                                hintText: 'Send Message',
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.grey[200],
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                  colors: [Colors.black87, Colors.black54.withOpacity(0.1)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 37.0,
            child: linearProgress(),
          ),
          Positioned(
            top: 60.0,
            left: 40.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                        "https://www.skylightsearch.co.uk/wp-content/uploads/2017/01/Loren-profile-pic-circle.png"),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget linearProgress() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < urlContent.length; i++) {
      list.add(
        LinearPercentIndicator(
          lineHeight: 4.0,
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          width: MediaQuery.of(context).size.width - 10,
          progressColor: Colors.blue,
          animationDuration: 7000,
          percent: 1,
          animation: true,
        ),
      );
    }
    return new Container(
      margin: EdgeInsets.only(left: 10.0, right: 50.0),
      child: Row(
        children: list,
      ),
    );
  }

  Widget videoPlayer(String url) {
    controller.setNetworkDataSource(url, autoPlay: true);
    return Container(
      height: 700.0,
      child: IjkPlayer(
        mediaController: controller,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<http.Response> storiesList() async {
    var response =
        await http.get("http://139.162.15.91/jaring-ummat/api/stories/list");
    return response;
  }
}
