import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/app_bar_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/sosial_media_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_atur_aplikasi/atur_aplikasimu.dart';
import 'package:flutter_jaring_ummat/src/views/page_kalkulator_zakat/kalkulator_zakat.dart';
import 'package:flutter_jaring_ummat/src/views/page_profile/kelengkapan_akun.dart';
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
  static String imgProfileKey;

  @override
  Widget build(BuildContext context) {
    final titleBar = Text('Menu Lain',
        style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize));

    final profileIcon = Padding(
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.transparent,
                backgroundImage: (imgProfileKey == null)
                    ? AssetImage('assets/icon/default_picture_man.png')
                    : NetworkImage(imgProfileKey),
              ),
            ),
            InkWell(
              onTap: _asyncImageSourceDialog,
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(color: greenColor, shape: BoxShape.circle),
                child: Icon(
                  NewIcon.upload_2x,
                  color: Colors.white,
                  size: 13,
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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => KelengkapanAkunPage()),
          );
        },
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '$fullnameKey • +62 $phoneNumberKey',
            style: TextStyle(color: grayColor, fontSize: 11),
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
        backgroundColor: whiteColor,
        title: titleBar,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/faq');
              },
              child: Icon(
                AllInOneIcon.faq_3x,
                size: 25,
                color: blackColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed('/term-and-condition'),
              child: Icon(
                AllInOneIcon.t_c_3x,
                size: 25,
                color: blackColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: _onlogout,
              child: Icon(
                AppBarIcon.logout,
                size: 25,
                color: blackColor,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              profileIcon,
              userProfile,
              editProfile,
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                shrinkWrap: true,
                separatorBuilder: (context, position) {
                  return Padding(
                    padding: EdgeInsets.only(left: 80.0),
                    child: new SizedBox(
                      height: 10.0,
                      child: new Center(
                        child: new Container(
                            margin: new EdgeInsetsDirectional.only(
                                start: 1.0, end: 1.0),
                            height: 5.0,
                            color: Colors.grey[200]),
                      ),
                    ),
                  );
                },
                itemBuilder: (context, index) => ListTile(
                  title: Text(MenuTextData.titleMenu[index],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  subtitle: Text(MenuTextData.subtitleMenu[index],
                      style: TextStyle(fontSize: 13)),
                  leading: CircleAvatar(
                    backgroundColor: MenuTextData.colorMenu[index],
                    child:
                        Icon(MenuTextData.iconMenu[index], color: whiteColor),
                  ),
                  trailing: Icon(NewIcon.next_small_2x, color: blackColor),
                  onTap: () {
                    switch (index) {
                      case 1:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => KalkulatorZakatPage()));
                        break;
                      case 2:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AturAplikasimuView(isActive: true)));
                        break;
                      default:
                    }
                  },
                ),
              ),
              infoBottom,
              socialMedia,
            ],
          ),
        ),
      ),
    );
  }

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

  @override
  void initState() {
    super.initState();

    // Call void getProfile
    getProfile();
  }

  Future _onlogout() {
    return showDialog(
      context: (context),
      builder: (_) => Dialog(
        child: Container(
          width: screenWidth(context),
          height: 500,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: 20,
                      color: greenColor,
                      icon: Icon(NewIcon.close_2x),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/backgrounds/logout_accent.png'))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: 'LOGOUT \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        TextSpan(
                          text: 'Kamu yakin ingin keluar \n',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        TextSpan(
                          text: 'dari aplikasi Jejaring?',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: screenWidth(context),
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Batalkan'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Container(
                      width: screenWidth(context),
                      child: RaisedButton(
                        onPressed: logout,
                        child: Text('Logout',
                            style: TextStyle(color: Colors.white)),
                        color: greenColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
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
      imgProfileKey = _preferences.getString(PROFILE_PICTURE_KEY);
    });
  }

  /// Call Function Logout

  void logout() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
    Navigator.of(context).pushReplacementNamed("/login");
  }
}
