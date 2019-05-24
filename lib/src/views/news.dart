import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_jaring_ummat/src/models/news_model.dart';
import 'package:flutter_jaring_ummat/src/services/news_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/news_post_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:shimmer/shimmer.dart';

import '../config/urls.dart';

class NewsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsState();
  }
}

class NewsState extends State<NewsView> with SingleTickerProviderStateMixin {
  //
  Response response;
  Dio dio = new Dio();

  SharedPreferences _preferences;
  SharedPreferences _newsPreferences;

  TabController _tabController;

  PageController _controller = PageController(initialPage: 0, keepPage: false);

  var _newsList = new List<NewsModel>();
  var _newsListStore = new List<NewsModel>();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 8);
    setState(() {
      fetchNewsCache();
    });
  }

  Future<List<NewsModel>> fetchNewsCache() async {
    _preferences = await SharedPreferences.getInstance();
    var data = _preferences.getString("news_store");

    if (data == null) {
      final response = await dio.get(NEWS_GET_LIST_THUMBNAIL);

      if (response.statusCode == 200) {
//        var data = json.encode(response.data);
//        _preferences.setString("news_store", data);
        Iterable list = response.data;
        setState(() {
          _newsListStore =
              list.map((model) => NewsModel.fromJson(model)).toList();
        });
      }
    }

    print("INI STORE DATA");
    print(data);

    Iterable list = json.decode(data);
    setState(() {
      _newsListStore = list.map((model) => NewsModel.fromJson(model)).toList();
    });

    print("INI LENGTH DARTI STORE LIST ==>");
    print(_newsListStore.length);
  }

  Future<List<NewsModel>> fetchNews() async {
    final response = await dio.get(NEWS_GET_LIST_ORIGINAL);

    _preferences = await SharedPreferences.getInstance();
    var datax = _preferences.getString("news_store");

    if (datax == null) {
      final response = await dio.get(NEWS_GET_LIST_THUMBNAIL);

      if (response.statusCode == 200) {
//        var data = json.encode(response.data);
//        _preferences.setString("news_store", data);
        Iterable list = response.data;
        setState(() {
          _newsListStore =
              list.map((model) => NewsModel.fromJson(model)).toList();
        });
      }
    }



    print("INI RESPONSE CODE NYA ==>");
    print(response.statusCode);

    print("INI RESPONSE BODY NYA ==>");
    print(response.data);

    _preferences = await SharedPreferences.getInstance();
    var data = json.encode(response.data);
    _preferences.setString("news_store", data);

    if (response.statusCode == 200) {
      Iterable list = response.data;
      _newsList = list.map((model) => NewsModel.fromJson(model)).toList();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                        FutureBuilder(
                          future: fetchNewsCache(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                if (_newsListStore.isEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 16.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100],
                                      child: Column(
                                        children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                                            .map(
                                              (_) => Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Container(
                                                  width: 48.0,
                                                  height: 48.0,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                      horizontal:
                                                      8.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Container(
                                                        width: double
                                                            .infinity,
                                                        height: 8.0,
                                                        color: Colors
                                                            .white,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                            2.0),
                                                      ),
                                                      Container(
                                                        width: double
                                                            .infinity,
                                                        height: 8.0,
                                                        color: Colors
                                                            .white,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                            2.0),
                                                      ),
                                                      Container(
                                                        width: 40.0,
                                                        height: 8.0,
                                                        color: Colors
                                                            .white,
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
                                return ListView.builder(
                                  shrinkWrap:
                                  true, // todo comment this out and check the result
                                  physics: ClampingScrollPhysics(),
                                  // padding: EdgeInsets.only(top: 10.0), x
                                  itemCount: _newsListStore.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // var item = values[index];
                                    var news = _newsListStore[index];
                                    print("INI TOTAL KOMENTAR");
                                    print(news.total_komentar);
                                    return ActivityNewsContainer(
                                      newsId: news.id.toString(),
                                      iconImg: news.imageProfile,
                                      title: news.title,
                                      imgContent: news.imageContent,
                                      postedAt: news.createdDate,
                                      profileName: news.createdBy,
                                      excerpt: news.description,
                                      totalKomentar: news.total_komentar,);
                                  },
                                );
                              default:
                                return ListView.builder(
                                  shrinkWrap:
                                  true, // todo comment this out and check the result
                                  physics: ClampingScrollPhysics(),
                                  // padding: EdgeInsets.only(top: 10.0), x
                                  itemCount: _newsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // var item = values[index];
                                    var news = _newsList[index];
                                    return ActivityNewsContainer(
                                      newsId: news.id.toString(),
                                      iconImg: news.imageProfile,
                                      title: news.title,
                                      imgContent: news.imageContent,
                                      postedAt: news.createdDate,
                                      profileName: news.createdBy,
                                      excerpt: news.description,
                                      totalKomentar: news.total_komentar,);
                                  },
                                );
                            }
                          },
                        )
                      ],
                    )
                  ]),
                ),
              ],
            ),
          )),
    );
  }

  Widget newsList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _newsList.length,
        itemBuilder: (context, index) {
          return Text(_newsList[index].title);
        });
  }
}
