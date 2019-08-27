import 'dart:convert';
import 'dart:io';

import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class PreviewsStories extends StatefulWidget {
  Future<File> imageFile;
  String cameraFile;

  PreviewsStories({this.imageFile, this.cameraFile});

  @override
  _PreviewsStoriesState createState() => _PreviewsStoriesState();
}

class _PreviewsStoriesState extends State<PreviewsStories> {
  SharedPreferences _preferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isSubmit = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: widget.imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (widget.cameraFile != null) {
          return Scaffold(
            key: _scaffoldKey,
            body: Stack(
              children: <Widget>[
                Image.file(
                  File(widget.cameraFile),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 30.0,
                  left: 10.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  width: MediaQuery.of(context).size.width,
                  height: 70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.black.withOpacity(0.1)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  left: 27.0,
                  child: CircularProfileAvatar(
                    'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4',
                    borderWidth: 3.0,
                    radius: 25.0,
                    elevation: 15.0,
                    cacheImage: true,
                    borderColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Positioned(
                  bottom: 15.0,
                  left: 20.0,
                  height: 20.0,
                  child: Container(
                    child: Text(
                      "Your Story",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  right: 20.0,
                  bottom: 25.0,
                  child: RaisedButton(
                    onPressed: _isSubmit
                        ? null
                        : () {
                            onSaveImageCamera();
                          },
                    elevation: 10.0,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.white,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            _isSubmit ? 'Loading ...' : 'Post Story',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Stack(
              children: <Widget>[
                Image.file(
                  snapshot.data,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 30.0,
                  left: 10.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 40.0,
                    ),
                  ),
                ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  width: MediaQuery.of(context).size.width,
                  height: 70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black, Colors.black.withOpacity(0.1)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  left: 27.0,
                  child: CircularProfileAvatar(
                    'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4',
                    borderWidth: 3.0,
                    radius: 25.0,
                    elevation: 15.0,
                    cacheImage: true,
                    borderColor: Colors.blue,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Positioned(
                  bottom: 15.0,
                  left: 20.0,
                  height: 20.0,
                  child: Container(
                    child: Text(
                      "Your Story",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  right: 20.0,
                  bottom: 25.0,
                  child: RaisedButton(
                    onPressed: _isSubmit
                        ? null
                        : () async {
                            StoriesApiProvider service =
                                new StoriesApiProvider();
                            _preferences =
                                await SharedPreferences.getInstance();
                            String userId = _preferences.getString("userId");
                            String createdBy =
                                _preferences.getString("fullname");

                            setState(() {
                              _isSubmit = true;
                            });

                            await service
                                .saveStoryData(userId, createdBy)
                                .then((response) {
                              print(
                                  "For Response Story Videos Post ${response.statusCode}");

                              Toast.show(' Text Stories ${response.statusCode}',
                                  context,
                                  backgroundColor: Colors.red,
                                  duration: 3,
                                  textColor: Colors.white);

                              if (response.statusCode == 200) {
                                var data = json.decode(response.body);
                                print(data["id"]);
                                service
                                    .uploadImage(data["id"], snapshot.data.path)
                                    .then((response) {
                                  print(response.statusCode);

                                  Toast.show(
                                      ' Content Stories ${response.statusCode}',
                                      context,
                                      backgroundColor: Colors.red,
                                      duration: 3,
                                      textColor: Colors.white);
                                  Navigator.of(context)
                                      .pushReplacementNamed("/home");
                                });
                              }
                            });
                          },
                    elevation: 10.0,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.white,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            _isSubmit ? 'Loading ...' : 'Post Story',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.error != null) {
          return Scaffold(
            body: Center(
              child: Container(
                child: const Text(
                  'Error Picking Image',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                child: const Text(
                  'Error Picking Image',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future onSaveImageCamera() async {
    StoriesApiProvider service = new StoriesApiProvider();
    _preferences = await SharedPreferences.getInstance();
    String userId = _preferences.getString(USER_ID_KEY);
    String createdBy = _preferences.getString(FULLNAME_KEY);

    setState(() {
      _isSubmit = true;
    });

    await service.saveStoryData(userId, createdBy).then((response) {
      print("For Response Story Videos Post ${response.statusCode}");

      Toast.show(' Text Stories ${response.statusCode}', context,
          backgroundColor: Colors.red, duration: 3, textColor: Colors.white);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data["id"]);
        service.uploadImage(data["id"], widget.cameraFile).then((response) {
          print(response.statusCode);
          Toast.show(' Content Stories ${response.statusCode}', context,
              backgroundColor: Colors.red,
              duration: 3,
              textColor: Colors.white);
          Navigator.of(context).pushReplacementNamed("/home");
        });
      }
    });
  }
}
