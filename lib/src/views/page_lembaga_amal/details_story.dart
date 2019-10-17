import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/bloc/storiesBloc.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/details_story_player.dart';

class StoryLembagaAmal extends StatefulWidget {
  final String userId;
  StoryLembagaAmal({this.userId});

  @override
  _StoryLembagaAmalState createState() => _StoryLembagaAmalState(userId: this.userId);
}

class _StoryLembagaAmalState extends State<StoryLembagaAmal> {
  String userId;
  _StoryLembagaAmalState({this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: StreamBuilder(
        stream: bloc.streamStoryByID,
        builder: (context, AsyncSnapshot<StoryByUserModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: Text('Waiting...'));
              break;
            default:
              if (snapshot.hasData) {
                return listBuilder(snapshot.data);
              }
              return Center(child: Text('No Data'));
          }
        },
      ),
    );
  }

  Widget listBuilder(StoryByUserModel snapshot) {
    return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      shrinkWrap: true,
      itemCount: snapshot.storyList.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.storyList[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LembagaAmalDetailStoryPlayer(
                  resourceType: value.resourceType,
                  url: value.url,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(value.resourceType == 'video' ? value.urlThumbnail : value.url),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10, top: 10),
                      child: Icon(AllInOneIcon.add_story_3x,
                          color: whiteColor, size: 25),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                      child: Text(
                        TimeAgoService().timeAgoFormatting(value.createdDate),
                        style: TextStyle(color: whiteColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    bloc.fetchAllStoryByIdUserWithoutFillter(userId);
    super.initState();
  }
}