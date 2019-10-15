import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/storiesModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_container.dart';
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
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
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
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
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
                    builder: (context) => StoryPlayerView(
                      createdBy: data.createdBy,
                      createdDate: data.storyList[0].createdDate,
                      content: data.storyList,
                    ),
                  ),
                );
              },
              child: Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          data.storyList[0].urlThumbnail == null
                              ? data.imageUrl
                              : data.storyList[0].urlThumbnail,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        width: 75,
                        child: Text(
                          snapshot[index].createdBy,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 11),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  ),
            );
          },
        ),
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
