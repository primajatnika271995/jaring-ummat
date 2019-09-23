import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/UserDetailPref.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/login/reLogin.dart';
import 'package:flutter_jaring_ummat/src/bloc/preferencesBloc.dart';
import 'package:flutter_jaring_ummat/src/views/page_explorer/explorer.dart';
import 'package:flutter_jaring_ummat/src/views/page_inbox/inbox.dart';
import 'package:flutter_jaring_ummat/src/views/page_portofolio/portofoilio.dart';
import 'package:flutter_jaring_ummat/src/views/page_profile/profile_menu.dart';

import 'package:toast/toast.dart';
import 'package:flutter_jaring_ummat/src/views/lembaga_amal/popular_account.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  final int currentindex;
  HomeView({this.currentindex});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  int _currentIndex = 0;
  SharedPreferences _preferences;
  String _token;

  UserDetailPref _pref;

  static const snackBarDuration = Duration(seconds: 3);
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  DateTime backButtonPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: PageView(
          controller: PageController(initialPage: 1),
          children: <Widget>[
            BeritaPage(),
            mainView(),
            PopularAccountView(),
          ],
        ),
      ),
    );
  }

  Widget mainView() {
    // Cek Terlebih dahulu Token
    checkToken();

    final List<Widget> _children = [
      ProgramAmalPage(),
      (_token == null) ? ReLogin() : ExplorerPage(),
      (_token == null) ? ReLogin() : Inbox(),
      (_token == null) ? ReLogin() : Portofolio(),
      (_token == null) ? ReLogin() : ProfileMenu(),
    ];

    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        child: Icon(NewIcon.nav_scan_3x, size: 20.0),
        backgroundColor: greenColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: _selectedTab,
          items: [
            BottomNavigationBarItem(
              icon: Icon(NewIcon.nav_home_inactive_3x, size: 20.0),
              activeIcon: Icon(
                NewIcon.nav_home_active_3x,
                color: greenColor,
                size: 20.0,
              ),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore, size: 25.0),
              activeIcon: Icon(
                Icons.explore,
                color: greenColor,
                size: 25.0,
              ),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(NewIcon.nav_portfolio_3x, size: 0, color: Colors.white),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: Icon(NewIcon.nav_portfolio_3x, size: 20.0),
              activeIcon: Icon(
                NewIcon.nav_portfolio_3x,
                color: greenColor,
                size: 20.0,
              ),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: new Icon(NewIcon.nav_others_3x, size: 20.0),
              activeIcon: new Icon(
                ProfileInboxIcon.nav_others_active_3x,
                color: greenColor,
                size: 20.0,
              ),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      Toast.show('Press again to leave', context,
          duration: 3, backgroundColor: Colors.grey);
      return false;
    }
    return true;
  }

  @override
  void initState() {
    setState(() {
      if (widget.currentindex == null) {
        _currentIndex = 0;
      } else {
        _currentIndex = widget.currentindex;
      }
    });
    bloc.preferences.forEach((value) {
      setState(() {
        _pref = value;
      });
    });
    super.initState();
  }

  void checkToken() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
  }

  void _selectedTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
