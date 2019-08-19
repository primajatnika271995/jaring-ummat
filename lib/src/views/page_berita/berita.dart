import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/beritaBloc.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_content.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({Key key}) : super(key: key);

  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  String selectedCategory = "";

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
                elevation: 0.0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Container(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blueAccent,
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
                      icon: Icon(Icons.arrow_forward, color: Colors.black),
                      onPressed: () {}),
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
                  onTap: (int index) {
                    switch (index) {
                      case 1:
                        setState(() {
                          selectedCategory = "Pendidikan";
                        });
                        break;
                      case 2:
                        setState(() {
                          selectedCategory = "Kemanusiaan";
                        });
                        break;
                      case 3:
                        setState(() {
                          selectedCategory = "Amal";
                        });
                        break;
                      case 4:
                        setState(() {
                          selectedCategory = "Pembangunan Mesjid";
                        });
                        break;
                      case 5:
                        setState(() {
                          selectedCategory = "Zakat";
                        });
                        break;
                      case 6:
                        setState(() {
                          selectedCategory = "Sosial";
                        });
                        break;
                      case 7:
                        setState(() {
                          selectedCategory = "lain-lain";
                        });
                        break;
                      default:
                        setState(() {
                          selectedCategory = "";
                        });
                    }
                    bloc.fetchAllBerita(selectedCategory);
                  },
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
                  Column(
                    children: <Widget>[
                      StreamBuilder(
                        stream: bloc.allBerita,
                        builder: (context, AsyncSnapshot<List<BeritaModel>> snapshot) {
                          if (snapshot.hasData) {
                            return buildList(snapshot);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<BeritaModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.data[index];
        return BeritaContent(
          berita: value,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchAllBerita(selectedCategory);
  }
}
