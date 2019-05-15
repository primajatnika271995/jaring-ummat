import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/services/news_service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/preferences.dart';
import '../views/components/show_alert_dialog.dart';

class CreateNews extends StatefulWidget {
  @override
  _CreateNewsState createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

//  Shared Preferences
  SharedPreferences _preferences;

  bool _isSubmit = false;

//

  List<String> _kategori = [
    'Pendidikan',
    'Zakat',
    'Sosial',
    'Amal'
  ]; // Option 2
  String _selectedKategori; // Option 2

// Variable Selected image
  File selected_berita1,
      selected_berita2,
      selected_berita3,
      selected_berita4,
      selected_berita5;

//  Text Controller

  final judulBeritaController = new TextEditingController();
  final kategoriBeritaController = new TextEditingController();
  final deskripsiBeritaController = new TextEditingController();

  //  LOADING METODE

  Future<bool> showLoadingIndicator() async {
    await new Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isSubmit = false;
    });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onCreateBerita() async {
    _preferences = await SharedPreferences.getInstance();

    var title = judulBeritaController.text;
    var description = deskripsiBeritaController.text;
    var kategori = kategoriBeritaController.text;

    var user_id = _preferences.getString(USER_ID_KEY);
    var createdBy = _preferences.getString(FULLNAME_KEY);

    var userProfile = _preferences.getString(PROFILE_PICTURE_KEY);

    print(userProfile);
    print(user_id);
    print(createdBy);

    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        duration: new Duration(seconds: 2),
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text(" Please Wait ... ")
          ],
        ),
      ),
    );

    NewsService newsService = new NewsService();
    newsService
        .saveNews(title, user_id, _selectedKategori, description, createdBy,
            selected_berita1.path, selected_berita2.path, userProfile)
        .then((response) async {
      print(response.statusCode);
      await showLoadingIndicator();
      if (response.statusCode == 201) {
        print("Data Berita Berhasil Disimpan");
        Navigator.of(context).pushReplacementNamed("/home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(47.0),
        child: AppBar(
          backgroundColor: Colors.blueAccent,
          title: _isSubmit
              ? new Text(
                  'Loading ...',
                  style: TextStyle(fontSize: 14.0),
                )
              : new Text(
                  'Unggah Berita',
                  style: TextStyle(fontSize: 14.0),
                ),
          centerTitle: false,
        ),
      ),
      body: new Container(
        child: new ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              color: Colors.grey[200],
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: judulBeritaController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Judul Berita *',
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                        ),
                        flex: 5,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      new Expanded(
                        child: Container(
                          height: 40.0,
                          padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              child: DropdownButton(
                                elevation: 4,
                                isDense: true,
                                iconSize: 15.0,
                                isExpanded: true,
                                hint: Text(
                                  'Pilih Kategori *',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black54),
                                ), // Not necessary for Option 1
                                value: _selectedKategori,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedKategori = newValue;
                                  });
                                },
                                items: _kategori.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      location,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        flex: 5,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _addNewsImageMenu(),
                  new Text(
                    "Berita Amil Minimal memiliki 1 gambar atau video yang diunggah."
                        " Video maskismal berdurasi 1 menit 30 detik.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: TextFormField(
                controller: deskripsiBeritaController,
                maxLines: 10,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Deskripsi Berita *',
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.white,
              ),
              padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
            ),
            SizedBox(
              height: 20.0,
            ),
            new Container(
              padding: EdgeInsets.only(right: 105.0, left: 105.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                  child: Text('Unggah Berita',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0)),
                ),
                onPressed: () {
                  onCreateBerita();
//          _login();
//        Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _addNewsImageMenu() {
    return new SizedBox(
      width: double.infinity,
      height: 270.0,
      child: new Container(
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: <Widget>[
            berita1(),
            berita2(),
            berita3(),
            berita4(),
            berita5()
          ],
        ),
      ),
    );
  }

  Widget berita1() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 15.0,
          left: 5.0,
          child: CircleAvatar(
            radius: 10.0,
            child: new Text(
              '1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        new Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  final ImageSource imageSource =
                      await _asyncImageSourceDialog(context);
                  var image = await ImagePicker.pickImage(source: imageSource);
                  File croppedFile = await ImageCropper.cropImage(
                    sourcePath: image.path,
                    ratioX: 1.0,
                    ratioY: 1.0,
                    maxWidth: 512,
                    maxHeight: 512,
                  );
                  setState(() {
                    selected_berita1 = croppedFile;
                  });
                },
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: selected_berita1 == null
                              ? AssetImage(
                                  "assets/icon/saved_donation.svg",
                                )
                              : FileImage(selected_berita1),
                          fit: BoxFit.fill),
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10.0))),
                  padding: EdgeInsets.all(12.0),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 6.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget berita2() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 15.0,
          left: 5.0,
          child: CircleAvatar(
            radius: 10.0,
            child: new Text(
              '2',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  final ImageSource imageSource =
                      await _asyncImageSourceDialog(context);
                  var image = await ImagePicker.pickImage(source: imageSource);
                  File croppedFile = await ImageCropper.cropImage(
                    sourcePath: image.path,
                    ratioX: 1.0,
                    ratioY: 1.0,
                    maxWidth: 512,
                    maxHeight: 512,
                  );
                  setState(() {
                    selected_berita2 = croppedFile;
                  });
                },
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: selected_berita2 == null
                              ? AssetImage(
                                  "assets/icon/saved_donation.svg",
                                )
                              : FileImage(selected_berita2),
                          fit: BoxFit.fill),
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10.0))),
                  padding: EdgeInsets.all(12.0),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 6.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget berita3() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 15.0,
          left: 5.0,
          child: CircleAvatar(
            radius: 10.0,
            child: new Text(
              '3',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10.0))),
                  padding: EdgeInsets.all(12.0),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 6.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget berita4() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 15.0,
          left: 5.0,
          child: CircleAvatar(
            radius: 10.0,
            child: new Text(
              '4',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10.0))),
                  padding: EdgeInsets.all(12.0),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 6.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget berita5() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 15.0,
          left: 5.0,
          child: CircleAvatar(
            radius: 10.0,
            child: new Text(
              '5',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: new BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(10.0))),
                  padding: EdgeInsets.all(12.0),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(top: 6.0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
