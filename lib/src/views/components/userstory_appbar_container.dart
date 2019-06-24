import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_jaring_ummat/src/models/storiesModel.dart';
import 'package:flutter_jaring_ummat/src/views/user_story.dart';
import '../../bloc/storiesBloc.dart';

class UserStoryAppBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserStoryAppBarState();
  }
}

class UserStoryAppBarState extends State<UserStoryAppBar> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.fetchAllStories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
//          Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
//                child: Row(
//                  children: <Widget>[
//                    const Text(
//                      'Stories',
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          color: Colors.black87),
//                    ),
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 0.0),
//                child: const Text(
//                  'See fullscreen photos and videos before they disappear.',
//                  style:
//                  TextStyle(fontSize: 12.0, color: Colors.grey),
//                ),
//              ),
//            ],
//          ),
          StreamBuilder(
            stream: bloc.storyFetchAll,
            builder: (context, AsyncSnapshot<List<Story>> snapshot) {
              if (snapshot.hasData) {
                print("GET Stories");
                return userStories(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget userStories(List<Story> snapshot) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemCount: snapshot.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          List<String> thumbnail = List<String>();
          List<String> videoUrl = List<String>();
          String video;
          String thumbnails;
          var data = snapshot[index];
//          var list = snapshot[index];
//           list.storyList[index].contents.forEach((val) {
//             String data = val.videoUrl;
//             videoUrl.add(data);
//           });
          data.storyList.forEach((f) {
            f.contents.forEach((val) {
              thumbnails = val.thumbnailUrl;
              video = val.videoUrl;
              thumbnail.add(thumbnails);
              videoUrl.add(video);
            });
          });
          print("Video index 0 : ${videoUrl[0]}");
          return GestureDetector(
            onTap: () {
              Route route = MaterialPageRoute(builder: (context) => UserStoryView(video: videoUrl[0], userId: data.userId, createdBy: data.createdBy, createdDate: data.storyList[0].createdDate,));
              Navigator.push(context, route);
            },
            child: Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.only(left: 7.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 140.0,
                      child: Image.network(
                        thumbnail[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      top: 10.0,
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
                      left: 0.0,
                      bottom: 0.0,
                      width: 100.0,
                      height: 30.0,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black,
                                  Colors.black.withOpacity(0.1)
                                ])),
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      child: new Text(
                        snapshot[index].createdBy,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
