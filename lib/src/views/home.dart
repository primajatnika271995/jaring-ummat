import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/header_custom_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/navbar_custom_icon.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal.dart';
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

  void onTabTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });
  }

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
    return GestureDetector(
      child: Scaffold(
        body: PageView(
          controller: PageController(initialPage: 1),
          children: <Widget>[
            newsView(),
            mainView(),
            popularAccountView(),
          ],
        ),
      ),
    );
  }

  Widget mainView() {
    final List<Widget> _children = [
      ProgramAmalPage(),
      Portofolio(),
      Inbox(),
      Menu()
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: bottomNavBar(_currentIndex, onTabTapped),
    );
  }

  Widget newsView() {
    return BeritaPage();
  }

  Widget popularAccountView() {
    return PopularAccountView();
  }

  Widget bottomNavBar(int currentIndex, Function onTap) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(NavbarCustom.nav_home_inactive),
          activeIcon: new Icon(NavbarCustom.nav_home_active),
          title: new Text('Beranda'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(NavbarCustom.nav_portfolio_inactive),
          activeIcon: new Icon(NavbarCustom.nav_portfolio_active),
          title: new Text('Portofolio'),
        ),
        BottomNavigationBarItem(
          icon: new Stack(
            children: <Widget>[
              new Icon(NavbarCustom.nav_inbox_inactive),
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
              new Icon(NavbarCustom.nav_inbox_active),
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
          title: new Text('Kotak Masuk'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(NavbarCustom.nav_othersmenu_inactive),
          activeIcon: new Icon(NavbarCustom.nav_othersmenu_active),
          title: new Text('Menu Lain'),
        ),
      ],
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
