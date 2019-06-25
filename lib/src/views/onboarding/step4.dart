import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/UserDetails.dart';
import 'package:flutter_jaring_ummat/src/models/login_model.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/login_service.dart';
import 'package:flutter_jaring_ummat/src/services/registerApi.dart';
import 'package:flutter_jaring_ummat/src/services/user_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

// Component
import '../../views/onboarding/success_register.dart';
import '../../config/preferences.dart';
import '../components/create_account_icons.dart';

class Step4View extends StatefulWidget {
  final VoidCallback onNext;
  final PostRegistration data;

  Step4View({this.onNext, this.data});

  @override
  State<StatefulWidget> createState() {
    return Step4State();
  }
}

class Step4State extends State<Step4View> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences _preferences;

  PageController pageController;

  ProgressDialog _progressDialog;
  UserDetailsService userDetailsService = new UserDetailsService();

  File selected_image;
  bool _isSubmit = false;
  bool isFollowed = false;

  Future<bool> showLoadingIndicator() async {
    await new Future.delayed(const Duration(seconds: 2));
    return true;
  }

  Future<ImageSource> _asyncImageSourceDialog(BuildContext context) async {
    return await showDialog<ImageSource>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Pilih Sumber Foto '),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
                child: const Text('Gallery', style: TextStyle(fontSize: 18)),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.camera);
                },
                child: const Text('Camera', style: TextStyle(fontSize: 18)),
              ),
            ],
          );
        });
  }

  Widget accountContainer(String assets, String Nama, String Pengikut,
      String AksiAmal, String LabelButton, Color colorBorderButton) {
    Widget buttonFollow() {
      return RaisedButton(
        onPressed: () {
          setState(() {
            isFollowed = true;
          });
        },
        color: Color.fromRGBO(21, 101, 192, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          child: Text(
            'Ikuti',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    Widget buttonFollowed() {
      return RaisedButton(
        onPressed: () {
          setState(() {
            isFollowed = false;
          });
        },
        color: Color.fromRGBO(165, 219, 98, 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
            child: Icon(
          Icons.check,
          color: Colors.white,
        )),
      );
    }

    return GestureDetector(
//    onTap: () {
//      Navigator.pushReplacementNamed(context, '/user/story');
//    },
      child: Container(
        margin: EdgeInsets.only(top: 23.0),
        padding: EdgeInsets.only(left: 7.0, right: 7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  width: 135.0,
                  height: 210.0,
                  decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey[600], width: 1.0),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: new Container(
                      padding: EdgeInsets.only(bottom: 110.0),
//                     height: 40.0,
//                     width: 40.0,
                      margin: EdgeInsets.all(0.0),
                      child: new Image(
                        image: AssetImage(assets),
                      )),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      Nama,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star,
                            size: 13,
                            color: Colors.amber,
                          ),
                          Icon(
                            Icons.star_half,
                            size: 13,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      Pengikut,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AksiAmal,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                      child: SizedBox(
                        width: 80.0,
                        height: 30.0,
                        child: isFollowed ? buttonFollowed() : buttonFollow(),
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          key: _scaffoldKey,
          body: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.darken),
                      image: AssetImage("assets/backgrounds/bg_step_1.png"),
                      fit: BoxFit.cover,
                    )),
              ),
              Column(
                children: <Widget>[
                  Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Container(
                              width: 120.0,
                              height: 120.0,
                              margin: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            Container(
                              child: Icon(
                                CreateAccount.create_account_step_3,
                                color: Colors.white,
                                size: 120.0,
                              ),
                            ),
                          ]),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 5.0,
                          ),
                          new Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: <Widget>[
                              Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: <Widget>[
                                    Container(
                                      child: InkWell(
                                        onTap: () async {
                                          final ImageSource imageSource =
                                              await _asyncImageSourceDialog(
                                                  context);
                                          var image =
                                              await ImagePicker.pickImage(
                                                  source: imageSource);
                                          setState(() {
                                            selected_image = image;
                                          });
                                        },
                                        child: Container(
                                          width: 80.0,
                                          height: 80.0,
                                          margin: EdgeInsets.fromLTRB(
                                              2.0, 0.0, 2.0, 0.0),
                                          child: selected_image == null
                                              ? Icon(
                                                  CreateAccount
                                                      .empty_profile_picture,
                                                  color: Colors.black,
                                                  size: 35.0,
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    image: DecorationImage(
                                                      image: FileImage(
                                                          selected_image),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: <Widget>[
                                    Container(
                                      width: 35.0,
                                      height: 35.0,
                                      margin: EdgeInsets.fromLTRB(
                                          2.0, 0.0, 2.0, 0.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      child: Icon(
                                        CreateAccount.upload,
                                        color: Colors.white,
                                        size: 15.0,
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                          new Container(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  widget.data.username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: Colors.white),
                                ),
                                new Text(
                                  '${widget.data.email} - ${widget.data.contact}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 11.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                        ],
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(10.0, 35.0, 0.0, 0.0),
                          child: new Text(
                            "Ikuti akun-akun Amil dibawah ini untuk mulai beramal!",
                            style:
                                TextStyle(fontSize: 11.0, color: Colors.white),
                          )),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                accountContainer(
                                    "assets/users/bamuis_min.png",
                                    "Bamuis BNI",
                                    "821.211 Pengikut",
                                    "14 Aksi Galang Amal",
                                    "Diikuti",
                                    Colors.grey),
                                accountContainer(
                                    "assets/users/bamuis_min.png",
                                    "Rumah Amal S...",
                                    "531.211 Pengikut",
                                    "19 Aksi Galang Amal",
                                    "Diikuti",
                                    Colors.grey),
                                accountContainer(
                                    "assets/users/bamuis_min.png",
                                    "Dewan Dakwah",
                                    "121.211 Pengikut",
                                    "9 Aksi Galang Amal",
                                    "Ikuti",
                                    Colors.blue),
                                accountContainer(
                                    "assets/users/bamuis_min.png",
                                    "Rumah Harapan ...",
                                    "821.211 Pengikut",
                                    "29 Aksi Galang Amal",
                                    "Ikuti",
                                    Colors.blue),
                              ],
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: SizedBox(
                      width: 140.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (!_isSubmit) {
                            onRegister();
                            // submit();
                          }
                        },
                        child: Text(_isSubmit ? 'Loading ... ' : 'Selanjutnya',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        color: Colors.blue,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  void onRegister() async {
    print(widget.data);
    print(selected_image.path.split("/").last);

    if (selected_image.path.isEmpty) {
      Toast.show('Please Take image For Profile', context,
          duration: 2, backgroundColor: Colors.red);
      return;
    }

    RegisterApiProvider service = new RegisterApiProvider();
    await service.saveUser(widget.data).then((response) {
      print("For Response Status Register Text ${response.statusCode}");
      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        service
            .saveContent(
                data["id"], "Users Profile", "image", selected_image.path)
            .then((response) {
          print("For Response Status Register Content ${response.statusCode}");
          onLogin();
        });
        setState(() {
          new Future.delayed(new Duration(seconds: 3));
          _isSubmit = false;
        });
      }
    });
  }

  void onLogin() async {
    _preferences = await SharedPreferences.getInstance();
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        duration: new Duration(seconds: 2),
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text(" Register Data, Please Wait ... ")
          ],
        ),
      ),
    );

    await showLoadingIndicator();
    setState(() {
      LoginServices service = new LoginServices();
      service.login(widget.data.email, widget.data.password).then((response) {
        print("For Response status code Login ${response.statusCode}");
        if (response.statusCode == 200) {
          var value = AccessToken.fromJson(json.decode(response.body));
          var token = value.access_token;
          _preferences.setString(ACCESS_TOKEN_KEY, token);
          _preferences.setString(EMAIL_KEY, widget.data.email);
          getUserDetail();
        }
      });
    });
  }

  Future<void> getUserDetail() async {
    UserDetails userDetails;
    _preferences = await SharedPreferences.getInstance();
    var _email = _preferences.getString(EMAIL_KEY);

//    _scaffoldKey.currentState.showSnackBar(
//      new SnackBar(
//        content: new Row(
//          children: <Widget>[
//            new CircularProgressIndicator(),
//            new Text(" Please Wait For Details Users ... ")
//          ],
//        ),
//      ),
//    );

    _progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    _progressDialog.setMessage("Get User Details ...");
    _progressDialog.show();

    _email != null
        ? userDetailsService.userDetails(_email).then((response) async {
            print("For Response Users Detail Code ${response.statusCode}");
            if (response.statusCode == 200) {
              print("For Response Users Detail by Email ${response.data} ");
              userDetails = UserDetails.fromJson(response.data);
              _preferences.setString(FULLNAME_KEY, userDetails.fullname);
              _preferences.setString(CONTACT_KEY, userDetails.contact);
              _preferences.setString(USER_ID_KEY, userDetails.userId);
              _preferences.setString(
                  PROFILE_PICTURE_KEY, userDetails.imgProfile[0].imgUrl);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SuccessRegisterView(
                        data: widget.data,
                        avatarImage: selected_image,
                      ),
                ),
              );
            }
          })
        : null;
  }
}
