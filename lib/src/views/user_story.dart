import 'package:flutter/material.dart';
import 'components/userstory_container.dart';

class UserStoryView extends StatefulWidget {

  String userId;
  String createdBy;
  int createdDate;
  String video;
  UserStoryView({@required this.userId, this.createdBy, this.createdDate, @required this.video});

  @override
  State<StatefulWidget> createState() {
    return UserStoryState();
  }
}

class UserStoryState extends State<UserStoryView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: UserStoryContainerOld(video: widget.video, userId: widget.userId, createdBy: widget.createdBy, createdDate: widget.createdDate,),
        )
      ),
    );
  }
}