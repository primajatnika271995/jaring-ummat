import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/navigation_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_jaring_ummat/src/bloc/registerBloc.dart';

class StepThree extends StatefulWidget {
  final String emailKey;
  StepThree({@required this.emailKey});

  @override
  _StepThreeState createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final String bgUrl = 'assets/backgrounds/accent_app_width_full_screen.png';

  final usernameCtrl = new TextEditingController();
  final passwordCtrl = new TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  File _selectedImage;
  String _selectedDefaultPicture = "";
  bool defaultPictureMan = false;
  bool defaultPictureWoman = false;

  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                    icon: Icon(
                      NewIcon.back_small_2x,
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                  )),
            ),
            elevation: 0,
            title: Text(
              "Data Diri",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'sofiapro-bold',
                  color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: LoadingScreen(
            inAsyncCall: _loadingVisible,
            child: Form(
              key: _keyForm,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      "Lengkapi Akunmu!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "Unggah foto diri dan lengkapi nama Anda\nuntuk mulai berbagi kebaikan!",
                        textAlign: TextAlign.center),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            _selectedImage == null
                                ? _selectedDefaultPicture.isEmpty
                                    ? emptyPicture()
                                    : defaultPicture()
                                : selectedImage(),
                            GestureDetector(
                              onTap: () async {
                                print(context);
                                final ImageSource imageSource =
                                    await _asyncImageSourceDialog(context);
                                print('--> $imageSource');
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  NewIcon.upload_2x,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.0),
                      child: TextFormField(
                        controller: usernameCtrl,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 10.0,
                            ),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0)),
                            ),
                            hintText: "Nama Lengkap"),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Username tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.0),
                      child: TextFormField(
                        controller: passwordCtrl,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0)),
                            ),
                            hintText: "Password"),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.go,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 35,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 70),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(45)),
                      child: FlatButton(
                        onPressed: () {
                          onSubmit();
                        },
                        child: Text(
                          "Selesai",
                          style: TextStyle(
                              fontFamily: 'sofiapro-bold',
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// SimpleDialogOption
  dialogContent(BuildContext context) {
    return Container(
        height: 450,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.green),
                child: IconButton(
                    alignment: Alignment.center,
                    icon: Icon(
                      Navigation.close,
                      color: Colors.white,
                      size: 10,
                    ),
                    onPressed: () {
                      Navigator.pop(context, null);
                    }),
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Icon(
                      NewIcon.empty_pp_big_12x,
                      size: 90,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SimpleDialogOption(
                    onPressed: () async {
                      Navigator.of(context).pop(ImageSource.gallery);
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      print('Select Galery!');
                      setState(() {
                        _selectedImage = image;
                      });
                      print('--> ${_selectedImage.path}');
                    },
                    child: const Text(
                      'Unggah foto dari galeri',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'sofiapro-bold',
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Container(
                    height: 3.5,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.grey[200],
                  ),
                  SimpleDialogOption(
                    onPressed: () async {
                      Navigator.of(context).pop(ImageSource.camera);
                      var image = await ImagePicker.pickImage(
                          source: ImageSource.camera);
                      print('Select Camera!');
                      setState(() {
                        _selectedImage = image;
                      });
                    },
                    child: const Text(
                      'Ambil foto dari kamera',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'sofiapro-bold',
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Container(
                    height: 3.5,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text("Pilih Foto Default"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 195,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            Image.asset(
                              'assets/icon/default_picture_man.png',
                              width: 90,
                            ),
                            GestureDetector(
                              onTap: () {
                                defaultPictureSelected(
                                    'assets/icon/default_picture_man.png');
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: defaultPictureMan
                                        ? Colors.green
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Navigation.check,
                                  size: 20,
                                  color: defaultPictureMan
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: <Widget>[
                            Image.asset(
                              'assets/icon/default_picture_woman.png',
                              width: 90,
                            ),
                            GestureDetector(
                              onTap: () {
                                defaultPictureSelected(
                                    'assets/icon/default_picture_woman.png');
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: defaultPictureWoman
                                        ? Colors.green
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Navigation.check,
                                  size: 20,
                                  color: defaultPictureWoman
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 180,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45)),
                      child: Text(
                        "Unggah",
                        style: TextStyle(
                            fontFamily: 'sofiapro-bold',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void defaultPictureSelected(value) {
    setState(() {
      if (value == 'assets/images/default_picture_man.png') {
        defaultPictureWoman = false;
        defaultPictureMan = !defaultPictureMan;
        defaultPictureMan
            ? _selectedDefaultPicture = value
            : _selectedDefaultPicture = "";
      } else {
        defaultPictureMan = false;
        defaultPictureWoman = !defaultPictureWoman;
        defaultPictureMan
            ? _selectedDefaultPicture = value
            : _selectedDefaultPicture = "";
      }
    });
  }

  Future<ImageSource> _asyncImageSourceDialog(BuildContext context) async {
    return await showDialog<ImageSource>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: dialogContent(context),
          );
        });
  }

  Widget emptyPicture() {
    return Icon(
      NewIcon.empty_pp_big_12x,
      size: 120,
      color: Colors.grey,
    );
  }

  Widget defaultPicture() {
    return Image.asset(
      _selectedDefaultPicture,
      width: 120,
    );
  }

  Widget selectedImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.5),
        image: DecorationImage(
          image: FileImage(_selectedImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void onSubmit() async {
    if (_selectedImage == null) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        margin: EdgeInsets.all(8.0),
        borderRadius: 8.0,
        message: "Gambar profile tidak boleh kosong",
        leftBarIndicatorColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      if (_keyForm.currentState.validate()) {
        final value = PostRegistration(
            contact: "-",
            email: widget.emailKey,
            fullname: usernameCtrl.text,
            password: passwordCtrl.text,
            tipe_user: "AMIL",
            username: widget.emailKey);

        await changeLoadingVisible();
        bloc.saveUser(context, value, _selectedImage.path);
        await changeLoadingVisible();
      }
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
