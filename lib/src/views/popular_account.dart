import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/header_custom_icons.dart';
import 'components/container_bg_default.dart';
import 'components/account_category_container.dart';
import 'components/container_profile_account.dart';

const double _ITEM_HEIGHT = 70.0;

class PopularAccountView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PopularAccountState();
  }
}

class PopularAccountState extends State<PopularAccountView>
    with TickerProviderStateMixin {
  // Variable list
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Scroll Variable
    _scrollController = new ScrollController();
    // Tab Controller
    _tabController = new TabController(vsync: this, length: 8);
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonsWidget = new Container(
      color: Colors.white,
      child: new TabBar(
        isScrollable: true,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 4.0, color: Colors.blueAccent),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: <Widget>[
          new Tab(
            text: 'Semua Kategori',
          ),
          new Tab(
            text: 'Pendidikan',
          ),
          new Tab(
            text: 'Kemanusiaan',
          ),
          new Tab(
            text: 'Amal',
          ),
          new Tab(
            text: 'Pembangunan Masjid',
          ),
          new Tab(
            text: 'Zakat',
          ),
          new Tab(
            text: 'Bakti Sosial',
          ),
          new Tab(
            text: 'lain-lain',
          )
        ],
        controller: _tabController,
      ),
    );

    // Widget itemsWidget = new ListView(
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     controller: _scrollController,
    //     children: _items.map((Item item) {
    //       return _singleItemDisplay(item);
    //     }).toList());

    // for (int i = 0; i < _items.length; i++) {
    //   if (_items.elementAt(i).selected) {
    //     _scrollController.animateTo(i * _ITEM_HEIGHT,
    //         duration: new Duration(seconds: 2), curve: Curves.ease);
    //     break;
    //   }
    // }
    return new Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: new Icon(Icons.arrow_back, color: Colors.grey[600]),
          actions: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            SizedBox(
              width: 0.0,
            ),
            Icon(AppBarIcons.ic_action, color: Colors.white,),
            SizedBox(
              width: 5.0,
            ),
//            IconButton(
//              icon: Icon(Icons.chat),
//              onPressed: () => {},
//            ),
//            IconButton(
//              icon: Icon(AppBarIcons.ic_action),
//              onPressed: () => {},
//            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: true,
          titleSpacing: 0.0,
          title: Container(
            child: TextFormField(
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.only(top: 7.0, bottom: 7.0, left: -15.0),
                icon: Icon(Icons.search, size: 18.0),
                border: InputBorder.none,
                hintText: 'Cari lembaga amal atau produk lainnya',
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Colors.grey[200],
            ),
            padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
          ),
        ),
        preferredSize: Size.fromHeight(47.0),
      ),
      body: new Padding(
          padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
          child: new Column(children: <Widget>[
            buttonsWidget,
            new Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 8.0),
                itemBuilder: (context, index) {
                  return new Column(
                    children: <Widget>[
                      ContainerProfileAccount(
                        profileId: '1',
                        name: 'Rumah Amal Salman',
                        totalFollowers: '84.982',
                        totalEvents: '14',
                        imgIcon: 'assets/users/logo-rumaha-amal-salman.png',
                        isFollowed: false,
                      ),
                      ContainerProfileAccount(
                        profileId: '2',
                        name: 'Yayasan Cinta Dakwah Indonesia',
                        totalFollowers: '12.053',
                        totalEvents: '8',
                        imgIcon: 'assets/users/logo_yayasan.png',
                        isFollowed: false,
                      ),
                      ContainerProfileAccount(
                        profileId: '3',
                        name: 'Pundi Amal Pemuda Indonesia',
                        totalFollowers: '840.042',
                        totalEvents: '27',
                        imgIcon: 'assets/users/logo-pundi-amal-ind.png',
                        isFollowed: false,
                      ),
                      ContainerProfileAccount(
                        profileId: '4',
                        name: 'Yayasan Amal Jariyah Indonesia',
                        totalFollowers: '524.520',
                        totalEvents: '17',
                        imgIcon: 'assets/users/logo-yayasan-amal-jariyah.png',
                        isFollowed: false,
                      ),
                      ContainerProfileAccount(
                        profileId: '5',
                        name: 'Inisiatif Zakat Indonesia',
                        totalFollowers: '57.134',
                        totalEvents: '6',
                        imgIcon: 'assets/users/zakatpedia.png',
                        isFollowed: false,
                      ),
                      ContainerProfileAccount(
                        profileId: '6',
                        name: 'Laznas Dewan Da\'wah',
                        totalFollowers: '57.134',
                        totalEvents: '6',
                        imgIcon: 'assets/users/logo-dewan-dakwah.png',
                        isFollowed: false,
                      ),
                    ],
                  );
                },
                itemCount: 1,
                shrinkWrap: true, // todo comment this out and check the result
                physics:
                    ClampingScrollPhysics(), // todo comment this out and check the result
              ),
            )
          ])),
    );
  }

  // Widget _singleItemDisplay(Item item) {
  //   return new Container(
  //     height: _ITEM_HEIGHT,
  //     child: new Container(
  //       padding: const EdgeInsets.all(2.0),
  //       child: new Text(item.displayName),
  //     ),
  //   );
  // }

  // void _filterSemuaKategori() {
  //   setState(() {
  //     for (var item in _items) {
  //       if (item.categories == "Semua Kategori") {
  //         item.selected = true;
  //         _tabController.index = 0;
  //       } else {
  //         item.selected = false;
  //       }
  //     }
  //   });
  // }

  // void _filterPendidikan() {
  //   setState(() {
  //     for (var item in _items) {
  //       if (item.categories == "Pendidikan") {
  //         item.selected = true;
  //         _tabController.index = 1;
  //       } else {
  //         item.selected = false;
  //       }
  //     }
  //   });
  // }
}
