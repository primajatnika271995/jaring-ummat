import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/berita_bloc/berita_event.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jaring_ummat/src/bloc/berita_bloc/berita_bloc.dart';

import 'berita_container.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 8,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: PreferredSize(
              child: AppBar(
                titleSpacing: 10.0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.white,
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
                    color: Colors.grey[300],
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.black45),
                      onPressed: () => Navigator.pop(context)),
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
                  BlocProvider(
                    builder: (context) => BeritaBloc(httpClient: http.Client())
                      ..dispatch(Fetch()),
                    child: BeritaContainer(),
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
