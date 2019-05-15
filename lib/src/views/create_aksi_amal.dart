import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/services/news_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAksiAmal extends StatefulWidget {
  @override
  _CreateAksiAmalState createState() => _CreateAksiAmalState();
}

class _CreateAksiAmalState extends State<CreateAksiAmal> {

//  Shared Preferences
  SharedPreferences _preferences;

// Variable Selected image
  File selected_berita1,
      selected_berita2,
      selected_berita3,
      selected_berita4,
      selected_berita5;

//  Text Controller
  final judulAksiController = new TextEditingController();
  final kategoriAksiController = new TextEditingController();
  final deskripsiAksiController = new TextEditingController();
  final targetDonasiController = new TextEditingController();
  final batasWaktuController = new TextEditingController();

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
//    _preferences = await SharedPreferences.getInstance();
//
//    var title = judulAksiController.text;
//    var description = deskripsiAksiController.text;
//    var target = targetDonasiController.text;
//    var batasWaktu = batasWaktuController.text;
//
//    var user_id = _preferences.getInt("userId");
//    var createdBy = _preferences.getString("fullname");
//
//    NewsService newsService = new NewsService();
//    newsService.saveNews(title, user_id, description, createdBy, selected_berita1.path, selected_berita2.path).then((response) {
//      print(response.statusCode);
//      if (response.statusCode == 201) {
//        print("Data Berita Berhasil Disimpan");
//        Navigator.of(context).pushReplacementNamed("/home");
//      }
//      print("Bangsat Kau");
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(47.0),
        child: AppBar(
          backgroundColor: Colors.blueAccent,
          title: new Text(
            'Buat Aksi Amal',
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
              color: Colors.transparent,
              child: new Column(
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: judulAksiController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Judul Aksi *',
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
                      new Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: kategoriAksiController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Kategori Aksi *',
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _addNewsImageMenu(),
                  new Text(
                    "Aksi amal Minimal memiliki 1 gambar atau video yang diunggah."
                        " Video maskismal berdurasi 1 menit 30 detik.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: Container(
                          child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            controller: targetDonasiController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Target Donasi *',
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
                      new Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: batasWaktuController,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Batas Waktu *',
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
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: TextFormField(
                controller: deskripsiAksiController,
                maxLines: 10,
                textInputAction: TextInputAction.next,
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
              padding: EdgeInsets.only(right: 120.0, left: 120.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
                  child: Text('Unggah Berita',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                onPressed: () {
                  onCreateBerita();
//          _login();
//        Navigator.of(context).pushReplacementNamed('/home');
                },
              ),
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
    return new Container(
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
              height: 120.0,
              width: 120.0,
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
              child: new Center(
                child: selected_berita1 == null ? SvgPicture.asset(
                  "assets/icon/saved_donation.svg",
                  width: 45.0,
                  color: Colors.grey,
                ) : SvgPicture.asset(
                  "",
                  width: 45.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 6.0),
          ),
        ],
      ),
    );
  }

  Widget berita2() {
    return new Container(
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
              height: 120.0,
              width: 120.0,
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
              child: new Center(
                child: SvgPicture.asset(
                  "assets/icon/saved_donation.svg",
                  width: 45.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 6.0),
          ),
        ],
      ),
    );
  }

  Widget berita3() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: new Container(
              height: 120.0,
              width: 120.0,
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius:
                  new BorderRadius.all(new Radius.circular(10.0))),
              padding: EdgeInsets.all(12.0),
              child: new Center(
                child: SvgPicture.asset(
                  "assets/icon/saved_donation.svg",
                  width: 45.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 6.0),
          ),
        ],
      ),
    );
  }

  Widget berita4() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: new Container(
              height: 120.0,
              width: 120.0,
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius:
                  new BorderRadius.all(new Radius.circular(10.0))),
              padding: EdgeInsets.all(12.0),
              child: new Center(
                child: SvgPicture.asset(
                  "assets/icon/saved_donation.svg",
                  width: 45.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 6.0),
          ),
        ],
      ),
    );
  }

  Widget berita5() {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: new Container(
              height: 120.0,
              width: 120.0,
              decoration: new BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius:
                  new BorderRadius.all(new Radius.circular(10.0))),
              padding: EdgeInsets.all(12.0),
              child: new Center(
                child: SvgPicture.asset(
                  "assets/icon/saved_donation.svg",
                  width: 45.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 6.0),
          ),
        ],
      ),
    );
  }
}

