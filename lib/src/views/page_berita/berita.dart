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
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
              child: AppBar(
                titleSpacing: 10.0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.blueAccent,
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
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () => Navigator.pop(context)),
                ],
                bottom: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 4.0, color: Colors.white),
                  ),
                  labelColor: Colors.black45,
                  unselectedLabelColor: Colors.white,
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
              preferredSize: Size.fromHeight(80.0)),
          body: BlocProvider(
            builder: (context) =>
                BeritaBloc(httpClient: http.Client())..dispatch(Fetch()),
            child: BeritaContainer(),
          ),
        ),
      ),
    );
  }
}
