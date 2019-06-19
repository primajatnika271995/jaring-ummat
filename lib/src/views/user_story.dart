import 'package:flutter/material.dart';
import 'components/userstory_container.dart';

class UserStoryView extends StatefulWidget {

  String url;
  String createdBy; 
  int createdDate;
  UserStoryView({@required this.url, this.createdBy, this.createdDate});

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
          child: UserStoryContainerOld(url: widget.url, createdBy: widget.createdBy, createdDate: widget.createdDate,),
        )
      ),
    );
  }
}