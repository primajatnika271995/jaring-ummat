import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/UserDetailPref.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
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
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {

  /*
   * Inisaialisasi Variable
   */
  static const snackBarDuration = Duration(seconds: 3);
  DateTime backButtonPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: PageView(
          controller: PageController(initialPage: 1),
          children: <Widget>[
            BeritaPage(),
            MainView(),
            PopularAccountView(),
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
    super.initState();
  }
}

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  /*
   *  Inisialisasi Variable
   */
  int _currentIndex = 0;

  SharedPreferences _preferences;

  String _token;

  @override
  Widget build(BuildContext context) {

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
        child: Icon(AllInOneIcon.nav_merchant_3x, size: 20.0),
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
              icon: Icon(NewIcon.nav_home_inactive_3x, size: 25),
              activeIcon:
              Icon(NewIcon.nav_home_active_3x, color: greenColor, size: 25),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: Icon(AllInOneIcon.nav_explore_inactive_3x, size: 25),
              activeIcon: Icon(AllInOneIcon.nav_explore_active_3x,
                  color: greenColor, size: 25),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon:
              Icon(NewIcon.nav_portfolio_3x, size: 0, color: Colors.white),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: Icon(AllInOneIcon.nav_portfolio_3x, size: 25),
              activeIcon: Icon(AllInOneIcon.nav_portfolio_active_3x,
                  color: greenColor, size: 25),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
            BottomNavigationBarItem(
              icon: new Icon(NewIcon.nav_others_3x, size: 25),
              activeIcon: new Icon(ProfileInboxIcon.nav_others_active_3x,
                  color: greenColor, size: 25),
              title: Padding(padding: EdgeInsets.all(0)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  void checkToken() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
    print(_token);
  }

  void _selectedTab(int index) {
    checkToken();
    setState(() {
      _currentIndex = index;
    });
  }
}