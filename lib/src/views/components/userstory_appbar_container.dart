import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/storiesModel.dart';
import 'package:flutter_jaring_ummat/src/views/page_story_view/story_page_builder.dart';
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
            builder: (context, AsyncSnapshot<List<AllStoryModel>> snapshot) {
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

  Widget userStories(List<AllStoryModel> snapshot) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        itemCount: snapshot.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var data = snapshot[index];
          return GestureDetector(
            onTap: () async {
              print('User ID Story Content : ${data.userId}');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StoryPage(
                    idStory: data.userId,
                    imageProfile: data.imageUrl,
                    createdBy: data.createdBy,
                    createdDate: data.storyList[0].createdDate,
                  ),
                ),
              );
            },
            child: Container(
                margin: EdgeInsets.only(top: 8.0),
                padding: EdgeInsets.only(left: 7.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage: NetworkImage(
                        data.storyList[0].urlThumbnail == null
                            ? data.imageUrl
                            : data.storyList[0].urlThumbnail,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0, left: 7.0),
                      width: 90.0,
                      child: Text(
                        snapshot[index].createdBy,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
//              child: ClipRRect(
//                borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                child: Stack(
//                  children: <Widget>[
//                    Container(
//                      width: 90.0,
//                      height: 140.0,
//                      child: Image.network(
//                        data.storyList[0].urlThumbnail == null ? data.imageUrl : data.storyList[0].urlThumbnail,
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                    Positioned(
//                      left: 10.0,
//                      top: 10.0,
//                      child: CircularProfileAvatar(
//                        data.imageUrl,
//                        borderWidth: 1,
//                        elevation: 20,
//                        radius: 20,
//                        cacheImage: true,
//                        borderColor: greenColor,
//                        backgroundColor: whiteColor,
//                      ),
//                    ),
//                    Positioned(
//                      left: 0.0,
//                      bottom: 0.0,
//                      width: 100.0,
//                      height: 30.0,
//                      child: Container(
//                        decoration: BoxDecoration(
//                            gradient: LinearGradient(
//                                begin: Alignment.bottomCenter,
//                                end: Alignment.topCenter,
//                                colors: [
//                              Colors.black,
//                              Colors.black.withOpacity(0.1)
//                            ])),
//                      ),
//                    ),
//                    Positioned(
//                        left: 10.0,
//                        bottom: 10.0,
//                        child: Container(
//                          width: 70.0,
//                          child: new Text(
//                            snapshot[index].createdBy,
//                            style: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                color: Colors.white,
//                                fontSize: 12.0),
//                            overflow: TextOverflow.ellipsis,
//                          ),
//                        )),
//                  ],
//                ),
//              ),
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
