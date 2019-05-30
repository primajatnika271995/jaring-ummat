import 'package:flutter/material.dart';
import 'activity_post_container.dart';

class ActivityPostListViewContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActivityPostListViewState();
  }
}

class ActivityPostListViewState extends State<ActivityPostListViewContainer> {
  List<Widget> activityPosts = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Container(
              width: 500.0,
              margin: EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text('Loading ...')],
              ),
            );
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return this.generateActivityPosts(context, snapshot);
        }
      },
    ));
  }

  // dummy call to API
  Future<List<Map<String, String>>> getData() async {
    List<Map<String, String>> data = new List<Map<String, String>>();
    data.add({
      'post_id': '1',
      'profile_picture_url': '',
      'title': 'Penggalangan Dana untuk Pendidikan',
      'profile_name': 'Bamuis BNI',
      'posted_at': '30 menit lalu',
      'total_donation': '13.000.000',
      'target_donation': '25.000.000',
      'due_date': '30 Juni 2019',
      'total_like': '10',
      'total_comment': '25',
    });

    data.add({
      'post_id': '2',
      'profile_picture_url': '',
      'title': 'Penggalangan Dana untuk Masjid',
      'profile_name': 'Komunitas Taufan',
      'posted_at': '30 menit lalu',
      'total_donation': '13.000.000',
      'target_donation': '25.000.000',
      'due_date': '30 Juni 2019',
      'total_like': '10',
      'total_comment': '25',
    });

    await new Future.delayed(new Duration(seconds: 1));

    return data;
  }

  Widget generateActivityPosts(BuildContext context, AsyncSnapshot snapshot) {
    List<Map<String, String>> values = snapshot.data;
    return ListView.builder(
            padding: EdgeInsets.only(top: 6.0, left: 7.0, right: 7.0),
            itemCount: values.length,
            itemBuilder: (BuildContext context, int index) {
              var item = values[index];
              return ActivityPostContainer(
                activityPostId: item['post_id'],
                profilePictureUrl: item['profile_picture_url'],
                title: item['title'],
                profileName: item['profile_name'],
                dueDate: item['due_date'],
                totalLikes: item['total_like'],
                totalComment: item['total_comment'],
              );
            }
    );
  }

}
