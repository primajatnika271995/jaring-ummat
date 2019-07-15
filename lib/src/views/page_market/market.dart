import 'package:flutter/material.dart';

class Toko extends StatefulWidget {
  @override
  _TokoState createState() => _TokoState();
}

class _TokoState extends State<Toko> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 8,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: PreferredSize(
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                title: new Text(
                  'Toko Jaring Ummat',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
                centerTitle: false,
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  // IconButton(
                  //   onPressed: () {
                  //     Scaffold.of(context).showSnackBar(
                  //       SnackBar(
                  //         content: Text('Setting Menu Under Development'),
                  //       ),
                  //     );
                  //   },
                  //   icon: Icon(
                  //     Icons.settings,
                  //     color: Colors.grey[600],
                  //   ),
                  // ),
                ],
              ),
              preferredSize: Size.fromHeight(47.0)),
          body: CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                expandedHeight: 20.0,
                backgroundColor: Colors.white,
                elevation: 10.0,
                automaticallyImplyLeading: true,
                floating: true,
                pinned: true,
                bottom: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 4.0, color: Colors.blueAccent),
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
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                                  width: 500.0,
                                  margin: EdgeInsets.only(top: 30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/coming-soon.png',
                                        height: 250.0,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'Oops..',
                                        style: TextStyle(
                                          fontFamily: 'Proxima',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19.0,
                                        ),
                                      ),
                                      Text(
                                        'This feature is Coming Soon !',
                                        style: TextStyle(
                                          fontFamily: 'Proxima',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
