import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/UserDetailPref.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_baru_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/app_bar_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/menu_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/menu_lain_icon_icons.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_jaring_ummat/src/bloc/preferencesBloc.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  UserDetailPref _pref;

  String emailKey;
  String fullnameKey;
  String contactKey;
  String profileKey;

  Widget leftSection(Icon icon) {
    return new Container(
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        child: icon,
        radius: 24.0,
      ),
    );
  }

  Widget rightSection() {
    return new Container(
        child: new IconButton(icon: Icon(NewIcon.next_small_2x), onPressed: () {}));
  }

  Widget middleSection(String title, String desc) {
    return Container(
      width: MediaQuery.of(context).size.width - 140,
      padding: new EdgeInsets.only(left: 8.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            title,
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
          new Text(
            desc,
            style: new TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: new AppBar(
          elevation: 1.0,
          title: new Text(
            'Profile',
            style: TextStyle(color: blackColor),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showDialog(
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
              },
              icon: Icon(
                AppBarIcon.logout,
                color: blackColor,
              ),
            ),
          ],
        ),
        preferredSize: Size.fromHeight(47.0),
      ),
      body: fullnameKey == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Stack(
                    children: <Widget>[
                      Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
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
                                            onTap: () {},
                                            child: Container(
                                              width: 80.0,
                                              height: 80.0,
                                              margin: EdgeInsets.fromLTRB(
                                                  2.0, 0.0, 2.0, 0.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                image: DecorationImage(
                                                  image: (profileKey == null)
                                                      ? NetworkImage(
                                                          _pref?.img_profile_db)
                                                      : NetworkImage(
                                                          profileKey),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: <Widget>[
                                        Container(
                                          width: 25.0,
                                          height: 25.0,
                                          child: new Icon(
                                            IconBaru.badge_member,
                                            color: Colors.yellow,
                                          ),
                                          margin: EdgeInsets.fromLTRB(
                                              2.0, 0.0, 2.0, 0.0),
                                        ),
                                        Container(
                                            child: new Text(
                                          "G",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                      ]),
                                ],
                              ),
                              new Container(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width - 120,
                                      child: new Text(
                                        fullnameKey,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            color: Colors.black),
                                            maxLines: 2,
                                      ),
                                    ),
                                    new Text(
                                      '$emailKey - $contactKey',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    new Text(
                                      "Anggota Bamius",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Change Profile under Development'),
                                            ));
                                          },
                                          child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: <Widget>[
                                                Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  margin: EdgeInsets.fromLTRB(
                                                      2.0, 0.0, 2.0, 0.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: greenColor,
                                                  ),
                                                ),
                                                Container(
                                                  child: Icon(
                                                    NewIcon.upload_2x,
                                                    color: Colors.white,
                                                    size: 15.0,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Scaffold.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Edit Profile under Development'),
                                            ));
                                          },
                                          child: Stack(
                                              alignment:
                                                  AlignmentDirectional.center,
                                              children: <Widget>[
                                                Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  margin: EdgeInsets.fromLTRB(
                                                      2.0, 0.0, 2.0, 0.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: greenColor,
                                                  ),
                                                ),
                                                Container(
                                                  child: Icon(
                                                    NewIcon.update_2x,
                                                    color: Colors.white,
                                                    size: 15.0,
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0)),
                  padding:
                      EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          InkWell(
                              onTap: () {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Menu Level Keanggotaan Under Development'),
                                ));
                              },
                              child: Row(
                                children: <Widget>[
                                  leftSection(
                                    Icon(
                                      MenuIcon.badge_member_menu,
                                      color: Colors.blueAccent,
                                      size: 30.0,
                                    ),
                                  ),
                                  middleSection(
                                      'Level Keanggotaan',
                                      'Tingkatkan terus aktivitas amal '
                                          'anda untuk memperbaharui ke anggotaan ke level selanjutnya'),
                                  rightSection()
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0)),
                  padding:
                      EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Menu Tukar Point Amal Under Development'),
                              ));
                            },
                            child: Row(
                              children: <Widget>[
                                leftSection(Icon(
                                  MenuLainIcon.redeem_point,
                                  color: Colors.blueAccent,
                                  size: 30.0,
                                )),
                                middleSection('Tukar Point Amal',
                                    'Tukarkan Point Amal Anda dengan penawaran menarik dari Jaring Ummat'),
                                rightSection()
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0)),
                  padding:
                      EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Menu Galang Amal Tersimpan Under Development'),
                              ));
                            },
                            child: Row(
                              children: <Widget>[
                                leftSection(Icon(
                                  MenuLainIcon.saved_donation,
                                  color: Colors.blueAccent,
                                  size: 30.0,
                                )),
                                middleSection('Galang Amal Tersimpan',
                                    'Daftar galang amal pada semua kategori yang tersimpan'),
                                rightSection()
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0)),
                  padding:
                      EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Menu Kalkulator Zakat Under Development'),
                              ));
                            },
                            child: Row(
                              children: <Widget>[
                                leftSection(Icon(
                                  MenuLainIcon.calculator_zakat,
                                  color: Colors.blueAccent,
                                  size: 30.0,
                                )),
                                middleSection('Kalkulator Zakat',
                                    'Hitung zakat profesi atau maal Anda sesuai pendapatan, tabungan dan hutang'),
                                rightSection()
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0)),
                  padding:
                      EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Menu Pengaturan Akun dan Aplikasi Under Development'),
                              ));
                            },
                            child: Row(
                              children: <Widget>[
                                leftSection(Icon(
                                  IconBaru.app_setting,
                                  color: Colors.blueAccent,
                                  size: 30.0,
                                )),
                                middleSection('Pengaturan Akun dan Aplikasi',
                                    'Atur akun Anda dan aplikasi Jaring Ummat serta notifikasi'),
                                rightSection()
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void initState() {
    bloc.preferences.forEach((value) {
      setState(() {
        _pref = value;
      });
    });
    getUser();
    super.initState();
  }

  void getUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var email = _preferences.getString(EMAIL_KEY);
    var id = _preferences.getString(LEMABAGA_AMAL_ID);
    var contact = _preferences.getString(CONTACT_KEY);
    var fullname = _preferences.getString(FULLNAME_KEY);
    var profile = _preferences.getString(PROFILE_PICTURE_KEY);

    setState(() {
      this.emailKey = email;
      this.fullnameKey = fullname;
      this.contactKey = contact;
      this.profileKey = profile;
    });
    print('--> email $email');
    print(id);
  }

  @override
  void dispose() {
    bloc?.dispose();
    super.dispose();
  }

  void logout() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.clear();
    Navigator.of(context).pushReplacementNamed("/login");
  }
}
