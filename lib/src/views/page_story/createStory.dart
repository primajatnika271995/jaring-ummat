import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera_utils/camera_utils.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'dart:math' as Math;

class CreateStory extends StatefulWidget {
  final String path;
  CreateStory({this.path});

  @override
  _CreateStoryState createState() => _CreateStoryState();
}

class _CreateStoryState extends State<CreateStory> {
  String _path = null;
  String _thumbPath = null;

  SharedPreferences _preferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isSubmit = false;
  bool _isVideo = false;
  String _videoName;
  bool _loadingVisible = false;

  StoriesApiProvider _service = new StoriesApiProvider();

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            _path != null
                ? _isVideo ? _getVideoContainer() : _getImageFromFile()
                : _getImageFromAsset(),
            _path != null
                ? _postContentStory()
                : Positioned(
                    bottom: 0.0,
                    width: MediaQuery.of(context).size.width,
                    child: _getContentContainerLogo(),
                  ),
            _path != null
                ? _getAvatarUsers()
                : Positioned(
                    bottom: 0.0,
                    width: MediaQuery.of(context).size.width,
                    child: _getContentContainerLogo(),
                  ),
            _path != null
                ? _cancelContent()
                : Positioned(
                    bottom: 0.0,
                    width: MediaQuery.of(context).size.width,
                    child: _getContentContainerLogo(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _cancelContent() {
    return Positioned(
      top: 30.0,
      right: 10.0,
      child: CircleAvatar(
        backgroundColor: greenColor,
        child: IconButton(
          onPressed: () {
            setState(() {
              this._path = null;
            });
          },
          icon: Icon(Icons.close, color: whiteColor),
        ),
      ),
    );
  }

  Widget _getAvatarUsers() {
    return Positioned(
      bottom: 5.0,
      left: 27.0,
      child: CircularProfileAvatar(
        'https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png',
        borderWidth: 3.0,
        radius: 25.0,
        elevation: 15.0,
        cacheImage: true,
        borderColor: greenColor,
        backgroundColor: whiteColor,
      ),
    );
  }

  Widget _postContentStory() {
    return Positioned(
      right: 20.0,
      bottom: 5.0,
      child: RaisedButton(
        onPressed: () {
          _isVideo ? _postContentVideo() : _postContentImage();
        },
        elevation: 10.0,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.white,
        textColor: Colors.white,
        padding: EdgeInsets.all(0.0),
        color: greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
          child: Row(
            children: <Widget>[
              Text(
                'Post Story',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageFromFile() {
    return Container(
      child: new Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey,
          child: Stack(
            children: <Widget>[
              new Image.file(
                File(
                  _path,
                ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
              ),
              _buildPathWidget(),
            ],
          )),
    );
  }

  Widget _getImageFromAsset() {
    return Container(
      child: new Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.black54,
          child: Stack(
            children: <Widget>[
              new Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Please Take Image or Video !',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildPathWidget(),
            ],
          )),
    );
  }

  Widget _getVideoContainer() {
    return Container(
      child: new Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey,
          child: Stack(
            children: <Widget>[
              _thumbPath != null
                  ? new Opacity(
                      opacity: 0.5,
                      child: new Image.file(
                        File(
                          _thumbPath,
                        ),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                      ),
                    )
                  : new Container(),
              new Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      'assets/ic_play.png',
                      width: 72.0,
                      height: 72.0,
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 2.0),
                      child: Text(
                        _videoName != null ? _videoName : '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildPathWidget()
            ],
          )),
    );
  }

  Widget _buildPathWidget() {
    return _path != null
        ? new Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 105.0,
              padding: EdgeInsets.all(5.0),
              color: Color.fromRGBO(00, 00, 00, 0.7),
              child: Text(
                'PATH: $_path',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : new Container();
  }

  Widget _getContentContainerLogo() {
    return Container(
        margin: EdgeInsets.only(top: 700 + 5.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            new Container(
              color: Color.fromRGBO(00, 00, 00, 0.7),
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: _captureImage,
                    child:
                        buildButtonControl(Icons.camera_alt, 'Capture Image'),
                  ),
                  InkWell(
                    onTap: _pickImage,
                    child: buildButtonControl(Icons.image, 'Pick Image'),
                  ),
                  InkWell(
                    onTap: () => _takeVideo(true),
                    child: buildButtonControl(Icons.videocam, 'Capture Video'),
                  ),
                  InkWell(
                    onTap: () => _takeVideo(false),
                    child:
                        buildButtonControl(Icons.video_library, 'Pick Video'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildButtonControl(IconData icon, String label) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _postContentImage() async {
    _preferences = await SharedPreferences.getInstance();
    String userId = _preferences.getString(USER_ID_KEY);
    String createdBy = _preferences.getString(FULLNAME_KEY);

    await changeLoadingVisible();

    setState(() {
      _isSubmit = true;
    });

    await _service.saveStoryData(userId, createdBy).then((response) {
      print('Response Code Save Content ?${response.statusCode}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        _service.uploadImage(data["id"], this._path).then((response) {
          changeLoadingVisible();
          print('Response Code Uploader?${response.statusCode}');
          Navigator.of(context).pushReplacementNamed("/home");
        });
      }
    });
  }

  void _postContentVideo() async {
    StoriesApiProvider service = new StoriesApiProvider();
    _preferences = await SharedPreferences.getInstance();
    String userId = _preferences.getString(USER_ID_KEY);
    String createdBy = _preferences.getString(FULLNAME_KEY);

    await changeLoadingVisible();

    setState(() {
      _isSubmit = true;
    });

    await service.saveStoryData(userId, createdBy).then((response) {
      print("For Response Story Videos Post ${response.statusCode}");
      if (response.statusCode == 200) {
        Toast.show(' Content Stories ${response.statusCode}', context,
            backgroundColor: Colors.red, duration: 3, textColor: Colors.white);

        var data = json.decode(response.body);
        print(data["id"]);
        service.uploadVideo(data["id"], this._path).then((response) {
          changeLoadingVisible();
          print(response.statusCode);
          Navigator.of(context).pushReplacementNamed("/home");
        });
      }
    });
  }

  Future _captureImage() async {
    final path = await CameraUtils.captureImage;

    final tempDir = await getTemporaryDirectory();
    final loc = tempDir.path;
    int rand = new Math.Random().nextInt(10000);
    Im.Image image = Im.decodeImage(File(path).readAsBytesSync());
    Im.Image smallerImage = Im.copyResizeCropSquare(image, 700);

    var compressedImage = new File('$loc/img_$rand.png')
      ..writeAsBytesSync(Im.encodeJpg(
        smallerImage,
        quality: 100,
      ));
    if (path != null) {
      var file = File(path);
      setState(() {
        print('ORIGINAL FILE ==>');
        print('Path ${file.path}');
        print('Size File Original ${file.readAsBytesSync().length}');

        print('COMPRESS FILE ==>');
        print('Path ${compressedImage.path}');
        print('Size File Resize ${compressedImage.readAsBytesSync().length}');
        _path = compressedImage.path;
        _isVideo = false;
      });
    }
  }

  Future _pickImage() async {
    final path = await CameraUtils.pickImage;
    final tempDir = await getTemporaryDirectory();
    final loc = tempDir.path;
    int rand = new Math.Random().nextInt(10000);
    Im.Image image = Im.decodeImage(File(path).readAsBytesSync());
    Im.Image smallerImage = Im.copyResizeCropSquare(image, 700);

    var compressedImage = new File('$loc/img_$rand.png')
      ..writeAsBytesSync(Im.encodeJpg(
        smallerImage,
        quality: 100,
      ));
    if (path != null) {
      var file = File(path);
      setState(() {
        print('ORIGINAL FILE ==>');
        print('Path ${file.path}');
        print('Size File Original ${file.readAsBytesSync().length}');

        print('COMPRESS FILE ==>');
        print('Path ${compressedImage.path}');
        print('Size File Resize ${compressedImage.readAsBytesSync().length}');
        _path = compressedImage.path;
        _isVideo = false;
      });
    }
  }

  Future _takeVideo(bool isCapture) async {
    setState(() {
      _thumbPath = null;
      _isVideo = false;
      _path = null;
      _videoName = null;
    });

    final path = isCapture
        ? await CameraUtils.captureVideo
        : await CameraUtils.pickVideo;

    if (path != null) {
      setState(() {
        _path = path;
        _isVideo = true;
      });
      Future<String> name = CameraUtils.getFileName(path);
      name.then((fileName) {
        setState(() {
          _videoName = fileName;
          print(fileName);
        });
      });
      Future<String> thumbPath = CameraUtils.getThumbnail(path);
      thumbPath.then((path) {
        setState(() {
          _thumbPath = path;
          print(path);
        });
      });
    }
  }

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
}
