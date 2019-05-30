import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/newspaperBloc.dart';
import 'package:flutter_jaring_ummat/src/models/newspaperModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/news_post_container.dart';
import 'package:shimmer/shimmer.dart';

class NewsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsState();
  }
}

class NewsState extends State<NewsView> with SingleTickerProviderStateMixin {

  TabController _tabController;
  List<Newspaper> newspaperCache = new List<Newspaper>();

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 8);
      bloc.fetchAllNewspaperOriginal();
        bloc.list.stream.forEach((value) {
          if (mounted) {
            setState(() {
              newspaperCache = value;
            });
          }
      });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.grey[100],
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
                  onPressed: () =>
                      {Navigator.of(context).pushReplacementNamed("/home")},
                ),
              ],
            ),
            preferredSize: Size.fromHeight(47.0)),
        body: RefreshIndicator(
          onRefresh: () {
            Future.value();
          },
          child: CustomScrollView(
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
                    )
                  ],
                  controller: _tabController,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: <Widget>[
                      StreamBuilder(
                        stream: bloc.allNewspaperOriginal,
                        builder:
                            (context, AsyncSnapshot<List<Newspaper>> snapshot) {
                          if (snapshot.hasData) {
                            print("GET NEWS DATA");
                            return buildList(snapshot.data);
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }

                          if (newspaperCache.length > 0) {
                            print("CACHE DATA");
                            return buildList(newspaperCache);
                          }
                          return loadingData();
                        },
                      ),
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(List<Newspaper> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.length,
      itemBuilder: (BuildContext context, int index) {
        print(snapshot[index].totalKomentar);
        return ActivityNewsContainer(
            newsId: snapshot[index].id,
            title: snapshot[index].title,
            excerpt: snapshot[index].description,
            iconImg: snapshot[index].imageProfile,
            imgContent: snapshot[index].imageContent,
            postedAt: snapshot[index].createdDate,
            profileName: snapshot[index].createdBy,
            totalKomentar: snapshot[index].totalKomentar);
      },
    );
  }

  Widget loadingData() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
              .map(
                (_) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48.0,
                            height: 48.0,
                            color: Colors.white,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Container(
                                  width: 40.0,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
              )
              .toList(),
        ),
      ),
    );
  }
}
