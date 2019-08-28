import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/UserDetailPref.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/login/reLogin.dart';
import 'package:flutter_jaring_ummat/src/bloc/preferencesBloc.dart';

import 'package:toast/toast.dart';
import 'package:flutter_jaring_ummat/src/views/portofilio.dart';
import 'package:flutter_jaring_ummat/src/views/inbox.dart';
import 'package:flutter_jaring_ummat/src/views/lembaga_amal/popular_account.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/views/components/fab_bottom_app_bar.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_jaring_ummat/src/views/menu.dart';

class HomeView extends StatefulWidget {
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
            (_token == null) ? ReLogin() : PopularAccountView()
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
      (_token == null) ? ReLogin() : Portofolio(),
      Inbox(),
      (_token == null) ? ReLogin() : Menu()
    ];

    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        child: Icon(NewIcon.nav_scan_3x, size: 20.0),
        backgroundColor: greenColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        color: grayColor,
        height: 45.0,
        selectedColor: greenColor,
        onTabSelected: _selectedTab,
        iconSize: 25.0,
        items: [
          FABBottomAppBarItem(iconData: (_currentIndex == 0) ? NewIcon.nav_home_active_3x : NewIcon.nav_home_inactive_3x, text: ''),
          FABBottomAppBarItem(iconData: (_currentIndex == 1) ? NewIcon.nav_portfolio_3x : NewIcon.nav_portfolio_3x, text: ''),
          FABBottomAppBarItem(iconData: (_currentIndex == 2) ? NewIcon.nav_inbox_3x : NewIcon.nav_inbox_3x, text: ''),
          FABBottomAppBarItem(iconData: (_currentIndex == 3) ? NewIcon.nav_others_3x : NewIcon.nav_others_3x, text: ''),
        ],
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
