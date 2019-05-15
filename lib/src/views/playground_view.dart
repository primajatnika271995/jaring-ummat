import 'package:flutter/material.dart';
import 'components/container_bg_default.dart';
import 'components/textfield_rounded.dart';
import 'components/show_alert_dialog.dart';
import 'components/userstory_appbar_container.dart';
import 'components/activity_post_container.dart';
import 'components/activity_post_listview_container.dart';

class PlaygroundView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlaygroundState();
  }
}

class PlaygroundState extends State<PlaygroundView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: UserStoryContainer(),
        )
      ),
    );
  }
}

class UserStoryContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserStoryState();
  }
}

class UserStoryState extends State<UserStoryContainer> {
  List<String> images = [
    "http://www.suaramuhammadiyah.id/wp-content/uploads/sites/2/2016/06/pembagian-zakat-fitrah-990x657.jpg",
    "https://bengkulu.kemenag.go.id/file/fotoberita/498616.jpg",
    "https://v-images2.antarafoto.com/pembagian-zakat-kpskq8-prv.jpg"
  ];
  int currentImageIdx = 0;
  String currentImageUrl;

  @override
  Widget build(BuildContext context) {
    setState(() {
      currentImageUrl = images[currentImageIdx];
    });

    Future.delayed(Duration(seconds: 5), () {
      setImage();
    });
    

    return Stack(
      children: <Widget>[
        image(),
        topBar(),
      ],
    );
  }

  void setImage() {
    setState(() {
      if (currentImageIdx < images.length-1) {
        currentImageIdx = currentImageIdx + 1;
      } else {
        currentImageIdx = 0;
      }

      print(currentImageIdx);
      print('-----');
    });
  }

  Widget topBar() {
    return Container(
      color: Color.fromRGBO(0, 0, 0, 0.3),
      width: double.infinity,
      height: 120,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0,),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/users/user-profile-sample.png"),
                      fit: BoxFit.contain,
                    )
                  ),
                ),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Bamuis BNI',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0,),
                    Text('5 menit lalu',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget image() {
    return Scaffold(
      body: Image.network(currentImageUrl,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}