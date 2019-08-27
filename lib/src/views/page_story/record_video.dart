import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:toast/toast.dart';
import 'package:image/image.dart' as Img;

import '../../views/page_story/stories_previews_container.dart';
import '../../views/page_story/video_stories_previews.container.dart';

class VideoRecord extends StatefulWidget {
  @override
  _VideoRecordState createState() => _VideoRecordState();
}

class _VideoRecordState extends State<VideoRecord> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final String _assetVideoRecorder = 'assets/ic_video_shutter.png';
  final String _assetStopVideoRecorder = 'assets/ic_stop_video.png';
  final String _assetToggleCamera = 'assets/ic_switch_camera_3.png';
  final String _assetPickImagegallery = 'assets/gallery.png';
  final String _assetTakeImage = 'assets/ic_camera.png';

  bool _toggleCamera = false;
  bool _startRecording = false;

  CameraController _cameraController;
  String videoPath;
  String imagePath;

  List<CameraDescription> cameras;
  int selectedCameraIdx;

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  Future<File> imageFile;

  @override
  void initState() {
    super.initState();

    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(),
        sized: false,
        child: Container(
          child: Stack(
            children: <Widget>[
              CameraPreview(_cameraController),
              Positioned(
                right: 0.0,
                top: 15.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.white,
                  highlightColor: Colors.grey,
                  iconSize: 35.0,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 120.0,
                  padding: EdgeInsets.all(20.0),
                  color: Color.fromRGBO(00, 00, 00, 0.7),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              !_startRecording
                                  ? _startVideoRecording()
                                  : _stopVideoRecording();
                              setState(() {
                                _startRecording = !_startRecording;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              child: Image.asset(
                                !_startRecording
                                    ? _assetVideoRecorder
                                    : _assetStopVideoRecorder,
                                width: 72.0,
                                height: 72.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      !_startRecording
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  onTap: () {
                                    !_toggleCamera
                                        ? onCameraSelected(cameras[1])
                                        : onCameraSelected(cameras[0]);
                                    setState(() {
                                      _toggleCamera = !_toggleCamera;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4.0),
                                    child: Image.asset(
                                      _assetToggleCamera,
                                      color: Colors.grey[200],
                                      width: 42.0,
                                      height: 42.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : new Container(),
                      Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                onTap: () {
                                  _onCapturePressed();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  child: Image.asset(
                                    _assetTakeImage,
                                    color: Colors.grey[200],
                                    width: 25.0,
                                    height: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0)),
                                onTap: () =>
                                    pickImageFromGallery(ImageSource.gallery),
                                child: Container(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Image.asset(
                                    _assetPickImagegallery,
                                    color: Colors.grey[200],
                                    width: 25.0,
                                    height: 25.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (_cameraController != null) await _cameraController.dispose();
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    _cameraController.addListener(() {
      if (mounted) setState(() {});
      if (_cameraController.value.hasError) {}
    });

    try {
      await _cameraController.initialize();
    } on CameraException catch (e) {}

    if (mounted) setState(() {});
  }

  Future<void> _onCameraSwitched(CameraDescription cameraDescription) async {
    if (_cameraController != null) {
      await _cameraController.dispose();
    }

    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    _cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (_cameraController.value.hasError) {
        Toast.show(
          'Camera error ${_cameraController.value.errorDescription}',
          context,
          textColor: Colors.red,
        );
      }
    });

    try {
      await _cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future _takePicture() async {
    if (!_cameraController.value.isInitialized) {
      Toast.show('Please wait', context,
          textColor: Colors.white, backgroundColor: Colors.blue);
      return null;
    }

    // Do nothing if a capture is on progress
    if (_cameraController.value.isTakingPicture) {
      return null;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String pictureDirectory = '${appDirectory.path}/Pictures';
    await Directory(pictureDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$pictureDirectory/${currentTime}.jpg';

    try {
      await _cameraController.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  void pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source, maxHeight: 480, maxWidth: 680);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewsStories(
                imageFile: imageFile,
                cameraFile: null,
              ),
        ),
      );
    });
  }

  void _onCapturePressed() {
    _takePicture().then((filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          print("this file path from camera ${imagePath}");

          Img.Image image_temp = Img.decodeImage(File(imagePath).readAsBytesSync());
          Img.Image smallerImage = Img.copyResize(image_temp);

          var compress = new File(imagePath)
            ..writeAsBytesSync(Img.encodeJpg(smallerImage, quality: 85));

          print("this file path from camera ${compress.path}");
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewsStories(cameraFile: compress.path)),
          );
        });

        if (filePath != null) {
          Toast.show('Picture saved to $filePath', context,
              textColor: Colors.white, backgroundColor: Colors.blue);
        }
      }
    });
  }

  Future<String> _startVideoRecording() async {
    if (!_cameraController.value.isInitialized) {
      Toast.show('Please wait', context,
          textColor: Colors.white, backgroundColor: Colors.blue);
      return null;
    }

    // Do nothing if a recording is on progress
    if (_cameraController.value.isRecordingVideo) {
      return null;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$videoDirectory/${currentTime}.mp4';

    try {
      await _cameraController.startVideoRecording(filePath);
      videoPath = filePath;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  Future<void> _stopVideoRecording() async {
    if (!_cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      await _cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoStoryPreviews(
              path: videoPath,
            ),
      ),
    );
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    Toast.show('Error: ${e.code}\n${e.description}', context,
        textColor: Colors.white, backgroundColor: Colors.blue);
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }
}
