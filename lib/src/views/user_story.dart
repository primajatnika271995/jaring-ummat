import 'package:flutter/material.dart';
import 'components/userstory_container.dart';

class UserStoryView extends StatefulWidget {
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
            Navigator.pushReplacementNamed(context, '/home');
          },
          child: UserStoryContainer(),
        )
      ),
    );
  }
}