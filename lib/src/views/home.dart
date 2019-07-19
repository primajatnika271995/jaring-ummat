import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/bni_page.dart';
import 'package:flutter_jaring_ummat/src/views/components/fab_bottom_app_bar.dart';
import 'package:flutter_jaring_ummat/src/views/components/header_custom_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_baru_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/menu_lain_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/navbar_custom_icon.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal.dart';
import 'package:toast/toast.dart';
import 'portofilio.dart';
import 'inbox.dart';
import 'popular_account.dart';
import 'menu.dart';
import '../views/components/navbar_custom_icon.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeView> {
  int _currentIndex = 0;

  void _selectedTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  static const snackBarDuration = Duration(seconds: 3);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime backButtonPressTime;

  Widget searchBoxContainer() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print(1);
            },
            child: Icon(
              HeaderCustom.ic_news,
              size: 20.0,
              color: Colors.white,
            ),
          ),
          Container(
            width: 270.0,
            height: 25.0,
            padding: EdgeInsets.fromLTRB(10.0, 0.5, 10.0, 0.5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: TextField(
              style:
                  TextStyle(fontSize: 10.0, color: Colors.black, height: 0.4),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Cari galang atau badan amil',
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              HeaderCustom.ic_comment_inactive,
              size: 20.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: PageView(
          controller: PageController(initialPage: 1),
          children: <Widget>[
            newsView(),
            mainView(),
            bniAccount(),
            popularAccountView(),
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

  Widget mainView() {
    final List<Widget> _children = [
      ProgramAmalPage(),
      Portofolio(),
      // Toko(),
      Inbox(),
      Menu()
    ];

    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        child: const Icon(IconBaru.scan_qr,),
        backgroundColor: Colors.orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        height: 45.0,
        selectedColor: Colors.black,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        iconSize: 25.0,
        items: [
          FABBottomAppBarItem(iconData: NavbarCustom.nav_home_active, text: ''),
          FABBottomAppBarItem(iconData: NavbarCustom.nav_portfolio_active, text: ''),
          FABBottomAppBarItem(iconData: NavbarCustom.nav_inbox_active, text: ''),
          FABBottomAppBarItem(iconData: NavbarCustom.nav_othersmenu_active, text: ''),
        ],
      ),
    );
  }

  Widget newsView() {
    return BeritaPage();
  }

  Widget popularAccountView() {
    return PopularAccountView();
  }

  Widget bniAccount() {
    return BNIPage();
  }

  Widget bottomNavBar(int currentIndex, Function onTap) {
    return SizedBox(
      height: 50.0,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 20.0,
        currentIndex: currentIndex,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(
              NavbarCustom.nav_home_inactive,
              color: Colors.grey,
              size: 27.0,
            ),
            activeIcon: new Icon(
              NavbarCustom.nav_home_active,
              color: Colors.black,
              size: 27.0,
            ),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              NavbarCustom.nav_portfolio_inactive,
              color: Colors.grey,
              size: 27.0,
            ),
            activeIcon: new Icon(
              NavbarCustom.nav_portfolio_active,
              color: Colors.black,
              size: 27.0,
            ),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              MenuLainIcon.merchant_amal,
              color: Colors.grey,
              size: 27.0,
            ),
            activeIcon: new Icon(
              MenuLainIcon.merchant_amal,
              color: Colors.black,
              size: 27.0,
            ),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: new Stack(
              children: <Widget>[
                new Icon(
                  NavbarCustom.nav_inbox_inactive,
                  color: Colors.grey,
                  size: 27.0,
                ),
                new Positioned(
                  right: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      '12',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            activeIcon: new Stack(
              children: <Widget>[
                new Icon(
                  NavbarCustom.nav_inbox_active,
                  color: Colors.black,
                  size: 27.0,
                ),
                new Positioned(
                  right: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      '12',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            title: Container(height: 0.0),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              NavbarCustom.nav_othersmenu_inactive,
              color: Colors.grey,
              size: 27.0,
            ),
            activeIcon: new Icon(
              NavbarCustom.nav_othersmenu_active,
              color: Colors.black,
              size: 27.0,
            ),
            title: Container(height: 0.0),
          ),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
