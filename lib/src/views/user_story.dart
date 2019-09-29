// import 'package:flutter/material.dart';
// import 'components/userstory_container.dart';

// class UserStoryView extends StatefulWidget {

//   String userId;
//   String createdBy;
//   int createdDate;
//   UserStoryView({this.userId, this.createdBy, this.createdDate});

//   @override
//   State<StatefulWidget> createState() {
//     return UserStoryState();
//   }
// }

// class UserStoryState extends State<UserStoryView> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: UserStoryContainerOld(userId: widget.userId, createdBy: widget.createdBy, createdDate: widget.createdDate,),
//         )
//       ),
//     );
//   }
// }