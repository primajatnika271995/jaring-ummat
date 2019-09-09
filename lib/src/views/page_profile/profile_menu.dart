import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/app_bar_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/sosial_media_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_profile/menu_text_data.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMenu extends StatefulWidget {
  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  /*
   * File Image Selected
   */
  static File selectedImage;

  /*
   * Data From Shared Preferences
   */
  static String emailKey;
  static String fullnameKey;
  static String phoneNumberKey;

  @override
  Widget build(BuildContext context) {
    final titleBar = Text('Menu Lain', style: TextStyle(color: blackColor));

    final profileIcon = Padding(
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                backgroundImage: (selectedImage == null)
                    ? AssetImage('assets/icon/default_picture_man.png')
                    : FileImage(selectedImage),
              ),
            ),
            InkWell(
              onTap: _asyncImageSourceDialog,
              child: Container(
                height: 40,
                width: 40,
                decoration:
                    BoxDecoration(color: greenColor, shape: BoxShape.circle),
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
    );

    final infoBottom = Padding(
      padding: EdgeInsets.only(top: 30),
      child: Text(
        'Ikuti akun Jejaring di beberapa social media dibawah ini \n agar kamu bisa lebih dekat dengan Kami.',
        style: TextStyle(color: grayColor),
        textAlign: TextAlign.center,
      ),
    );

    final editProfile = Padding(
      padding: EdgeInsets.only(left: 60, right: 60, top: 10),
      child: RaisedButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        color: greenColor,
        child: Text('Lengkapi Akun', style: TextStyle(color: whiteColor)),
      ),
    );

    final userProfile = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '$emailKey',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            '$fullnameKey • +62 $phoneNumberKey',
            style: TextStyle(color: grayColor, fontSize: 15),
          )
        ],
      ),
    );

    final socialMedia = Padding(
      padding: EdgeInsets.only(top: 5, bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.facebook),
            iconSize: 40.0,
            color: facebookColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.google),
            iconSize: 40.0,
            color: googleColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.linkedin),
            iconSize: 40.0,
            color: linkedInColor,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        title: titleBar,
        actions: <Widget>[
          IconButton(
            icon: Icon(AppBarIcon.logout),
            color: blackColor,
            onPressed: _onlogout,
          ),
        ],
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              profileIcon,
              userProfile,
              editProfile,
              SizedBox(
                height: 20,
              ),
            ]),
          ),
          SliverFixedExtentList(
            itemExtent: 130.0,
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                title: Text(MenuTextData.titleMenu[index],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(MenuTextData.subtitleMenu[index]),
                leading: CircleAvatar(
                  backgroundColor: MenuTextData.colorMenu[index],
                  child: Icon(MenuTextData.iconMenu[index], color: whiteColor),
                ),
                trailing: Icon(NewIcon.next_small_2x, color: blackColor),
              ),
              childCount: 5,
            ),
          ),
//          SliverList(
//            delegate: SliverChildListDelegate([
//              ListView.separated(
//                itemCount: 5,
//                shrinkWrap: true,
//                separatorBuilder: (context, position) {
//                  return Padding(
//                    padding: EdgeInsets.only(left: 80.0),
//                    child: new SizedBox(
//                      height: 10.0,
//                      child: new Center(
//                        child: new Container(
//                            margin: new EdgeInsetsDirectional.only(
//                                start: 1.0, end: 1.0),
//                            height: 5.0,
//                            color: Colors.grey[200]),
//                      ),
//                    ),
//                  );
//                },
//                itemBuilder: (context, index) => ListTile(
//                  title: Text(MenuTextData.titleMenu[index],
//                      style: TextStyle(fontWeight: FontWeight.bold)),
//                  subtitle: Text(MenuTextData.subtitleMenu[index]),
//                  leading: CircleAvatar(
//                    backgroundColor: MenuTextData.colorMenu[index],
//                    child:
//                        Icon(MenuTextData.iconMenu[index], color: whiteColor),
//                  ),
//                  trailing: Icon(NewIcon.next_small_2x, color: blackColor),
//                ),
//              ),
//            ]),
//          ),
          SliverList(
            delegate: SliverChildListDelegate([
              infoBottom,
              socialMedia,
            ]),
          ),
        ],
      ),
    );
  }

  /// Future call PopUp Dialog Image Source

  Future<ImageSource> _asyncImageSourceDialog() {
    return showDialog<ImageSource>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text('Pilih Sumber Foto '),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: getFromGallery,
              child: const Text('Gallery', style: TextStyle(fontSize: 18)),
            ),
            SimpleDialogOption(
              onPressed: getFromCamera,
              child: const Text('Camera', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  Future _onlogout() {
    return showDialog(
      context: (context),
      builder: (_) => NetworkGiffyDialog(
        image: Image.asset(
          'assets/404.gif',
        ),
        title: Text(
          'Logout Akun !',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        description: Text(
          'Apakah anda ingin keluar dari Aplikasi Mitra Jejaring ?',
          textAlign: TextAlign.center,
        ),
        buttonOkColor: Colors.redAccent,
        buttonOkText: Text(
          'Logout',
          style: TextStyle(color: Colors.white),
        ),
        onOkButtonPressed: () {
          logout();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Call void getProfile
    getProfile();
  }

  /// Call function to Get Image From Gallery

  void getFromGallery() async {
    Navigator.of(context).pop(ImageSource.gallery);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('Select Galery!');
    setState(() {
      selectedImage = image;
    });
  }

  /// Call function to Get Image From Camera

  void getFromCamera() async {
    Navigator.of(context).pop(ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print('Select Camera');
    setState(() {
      selectedImage = image;
    });
  }

  /// Call Function to Get Profile Details form Shared Preferences

  void getProfile() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    setState(() {
      emailKey = _preferences.getString(EMAIL_KEY);
      fullnameKey = _preferences.getString(FULLNAME_KEY);
      phoneNumberKey = _preferences.getString(CONTACT_KEY);
    });
  }

  /// Call Function to Logout and Clear Preferences

  void logout() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
    Navigator.of(context).pushReplacementNamed("/login");
  }
}
