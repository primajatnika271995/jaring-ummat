import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_baru_icons.dart';

// Component
import '../views/components/header_custom_icons.dart';
import '../views/components/create_account_icons.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget leftSection(Icon icon) {
    return new Container(
      child: new CircleAvatar(
//      backgroundImage: new NetworkImage(url),
        backgroundColor: Colors.transparent,
        child: icon,
        radius: 24.0,
      ),
    );
  }

  Widget middleSection(String title, String desc, String time) {
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
            style: new TextStyle(color: Colors.black, fontSize: 11.0),
            overflow: TextOverflow.ellipsis,
          ),
          new Text(
            time,
            style: new TextStyle(color: Colors.grey, fontSize: 11.0),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: new AppBar(
            title: new Text(
              'Kotak Masuk',
              style: TextStyle(fontSize: 14.0, color: Colors.blueAccent),
            ),
            centerTitle: false,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Setting Menu Under Development'),
                  ));
                },
                icon: Icon(
                  CreateAccount.setting_2,
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
          preferredSize: Size.fromHeight(47.0),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: 20.0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: true,
              floating: true,
              pinned: true,
              bottom: new TabBar(
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 4.0, color: Colors.blueAccent),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: <Widget>[
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        new Text('Semua Notifikasi'),
                        new Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            new SizedBox(
                              height: 26.0,
                            ),
                            new Positioned(
                              // right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: new Text(
                                  '8',
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
                      ],
                    ),
                  ),
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        new Text('Pesan Amil'),
                        new Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            new SizedBox(
                              height: 26.0,
                            ),
                            new Positioned(
                              // right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(2),
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
                      ],
                    ),
                  ),
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        new Text('Diskusi Amal'),
                        new Stack(
                          children: <Widget>[
                            new SizedBox(
                              height: 26.0,
                            ),
                            new Positioned(
                              // right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: new Text(
                                  '8',
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
                      ],
                    ),
                  ),
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        new Text('Berita Amil'),
                        new Stack(
                          children: <Widget>[
                            new SizedBox(
                              height: 26.0,
                            ),
                            new Positioned(
                              // right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: new Text(
                                  '8',
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
                      ],
                    ),
                  ),
                  new Tab(
                    child: Row(
                      children: <Widget>[
                        new Text('Pusat Bantuan'),
                        new Stack(
                          children: <Widget>[
                            new SizedBox(
                              height: 26.0,
                            ),
                            new Positioned(
                              // right: 0,
                              child: new Container(
                                padding: EdgeInsets.all(2),
                                decoration: new BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: new Text(
                                  '8',
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
                      ],
                    ),
                  ),
                ],
                controller: _tabController,
              ),
            ),
            new SliverList(
                delegate: SliverChildListDelegate(
              [_buildListItem()],
            ))
          ],
        ));
  }

  Widget _buildListItem() {
    return Column(
      children: <Widget>[
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          leftSection(
                            Icon(
                              IconBaru.reward_point,
                              color: Colors.orangeAccent,
                              size: 30.0,
                            ),
                          ),
                          middleSection(
                              'Point Amal Bertambah',
                              'Selamat! Point Amal Anda bertambah Rp. 2.500. Tingkatkan',
                              '9 menit yang lalu'),
                        ],
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
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          leftSection(
                            Icon(
                              IconBaru.donation_small,
                              color: Colors.deepPurple,
                              size: 30.0,
                            ),
                          ),
                          middleSection(
                              'Pembayaran Donasi',
                              'Selamat! Pembayaran donasi anda sebesar Rp. 100.000 ke nomor',
                              '10 menit yang lalu'),
                        ],
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
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          leftSection(
                            Icon(
                              IconBaru.chat,
                              color: Colors.redAccent,
                              size: 30.0,
                            ),
                          ),
                          middleSection(
                              'Pesan Dari Amil',
                              'Yayasan Hasanah Titik mengirim pesan untuk Anda. ',
                              '16 menit yang lalu'),
                        ],
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
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          leftSection(
                            Icon(
                              HeaderCustom.ic_news,
                              color: Colors.blue,
                              size: 30.0,
                            ),
                          ),
                          middleSection(
                              'Berita Baru',
                              'Bamuis BNI mengadakan kegiatan amal baru yang berfokus pada',
                              '22 menit yang lalu'),
                        ],
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
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          leftSection(
                            Icon(
                              IconBaru.zakat_small,
                              color: Colors.deepOrange,
                              size: 30.0,
                            ),
                          ),
                          middleSection(
                              'Info Zakat',
                              'Pembayaran Zakat Anda kepada IZI telah tersalurkan. Lihat',
                              '39 menit yang lalu'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
//        ListView.builder(
//          padding: EdgeInsets.only(top: 8.0),
//          itemBuilder: (context, index) {
//            return new Column(
//              children: <Widget>[
//                inbox(
//                    context,
//                    SvgPicture.asset(
//                      "assets/icon/ic_zakat.svg",
//                      color: Colors.blueAccent,
//                      semanticsLabel: 'logo',
//                      width: 40,
//                    ),
//                    "Portofilio Bulan January 2019",
//                    "Portofilio bulan january anda telah terbit, silahkan di check disini!",
//                    "7 menit yang lalu"),
//                inbox(
//                    context,
//                    SvgPicture.asset(
//                      "assets/icon/ic_zakat.svg",
//                      color: Colors.blueAccent,
//                      semanticsLabel: 'logo',
//                      width: 40,
//                    ),
//                    "Portofilio Bulan Feburay 2019",
//                    "Portofilio bulan febuary anda telah terbit, silahkan di check disini!",
//                    "1 menit yang lalu"),
//              ],
//            );
//          },
//          itemCount: 1,
//          shrinkWrap: true, // todo comment this out and check the result
//          physics:
//              ClampingScrollPhysics(), // todo comment this out and check the result
//        ),
      ],
    );
  }

  Widget inbox(BuildContext context, Widget icon, String title, String message,
      String time) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                icon,
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(message, style: TextStyle(fontSize: 10)),
                      Text(time, style: TextStyle(fontSize: 10)),
                    ],
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey,
            )
          ],
        ));
  }

  Widget textCategory(String name, bool isSelected) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(17.0)),
            color:
                (isSelected) ? Color.fromRGBO(165, 219, 98, 1.0) : Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                    color: (isSelected) ? Colors.white : Colors.grey,
                    fontWeight:
                        (isSelected) ? FontWeight.bold : FontWeight.normal),
              ),
            ],
          )),
      onTap: () {},
    );
  }
}
