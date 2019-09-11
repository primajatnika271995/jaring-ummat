import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
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
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
            stream: bloc.storyFetchAll,
            builder: (context, AsyncSnapshot<List<Story>> snapshot) {
              if (snapshot.hasData) {
                return userStories(snapshot.data);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Container(
                padding: EdgeInsets.only(top: 60.0),
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
          List<String> image = List<String>();
          List<String> videoUrl = List<String>();
          String video;
          String thumbnails;
          var data = snapshot[index];
          data.storyList.forEach((f) {
            f.contents.forEach((val) {
              thumbnails = val.thumbnailUrl;
              video = val.videoUrl;
              thumbnail.add(thumbnails);
              videoUrl.add(video);
            });
          });
          return GestureDetector(
            onTap: () async {
              Route route = MaterialPageRoute(
                builder: (context) => UserStoryView(
                  userId: data.userId,
                  createdBy: data.createdBy,
                  createdDate: data.storyList[0].createdDate,
                ),
              );
              Navigator.push(context, route);
            },
            child: Container(
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.only(left: 7.0),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: new Offset(2.0, 2.0),
                  blurRadius: 40.0,
                ),
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 90.0,
                      height: 140.0,
                      child: thumbnail[0] == null
                          ? Image.network(
                        data.storyList[0].contents[0].imgUrl,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        thumbnail[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      top: 10.0,
                      child: CircularProfileAvatar(
                        'https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png',
                        borderWidth: 3.0,
                        radius: 20.0,
                        elevation: 15.0,
                        cacheImage: true,
                        borderColor: greenColor,
                        backgroundColor: whiteColor,
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
                        child: Container(
                          width: 70.0,
                          child: new Text(
                            snapshot[index].createdBy,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
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
  void initState() {
    bloc.fetchAllStories();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
