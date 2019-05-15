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

  SharedPreferences _preferences;
  SharedPreferences _newsPreferences;

  TabController _tabController;

  PageController _controller = PageController(initialPage: 0, keepPage: false);

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 8);
    getAllNews();
  }

  var _newsList = new List<NewsModel>();


  void getAllNews() async {
    _newsPreferences = await SharedPreferences.getInstance();

    NewsService service = new NewsService();
    service.getNewsList().then((response) {
      print("ini RESPONSE buat Page News ");
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.data);
        Iterable list = response.data;
        _newsList = list.map((model) => NewsModel.fromJson(model)).toList();
      }

      if (response.statusCode == 500) {
        return Center(
          child: new Text("Null Pointer Exception"),
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

// dummy call to API
  Future<List<Map<String, String>>> getData() async {
    List<Map<String, String>> data = new List<Map<String, String>>();
    data.add({
      'post_id': '1',
      'profile_picture_url': '',
      'title': 'Bantuan Dana Pendidikan Siswa SD Tunas Harapan',
      'profile_name': 'Bamuis BNI',
      'posted_at': '30 menit yang lalu',
      'description': 'Pendidikan Adalah suatu hal yang penting dalam islam,'
          'kata pertama Al-Quran yang diwahyukan kepada Nabi Muhammad '
          'Shallallahu Alaihi Wasalam adalah IQRA atau baca. Dan menuntut '
          'ilmu adalah suatu kewajiban bagi umat Muslim .\n \nMelalui pendidikan '
          'diaharapkan umat muslim dapat menjadi pribadi yang tidak hanya pandai tetapi juga '
          'santun dan mulia. Dan kelak akan menjadi manusia yang bermanfaat untuk bangsa, negara '
          'dan Agamanya.',
      'total_donation': '4.069.830',
      'target_donation': '25.000.000',
      'due_date': '30 Juni 2019',
      'total_like': '26.112',
      'total_comment': '8.127',
    });

    data.add({
      'post_id': '2',
      'profile_picture_url': '',
      'title': 'Penggalangan Dana untuk Masjid',
      'profile_name': 'Komunitas Taufan',
      'posted_at': '30 menit yang lalu',
      'description': 'Pendidikan Adalah suatu hal yang penting dalam islam,'
          'kata pertama Al-Quran yang diwahyukan kepada Nabi Muhammad '
          'Shallallahu Alaihi Wasalam adalah IQRA atau baca. Dan menuntut '
          'ilmu adalah suatu kewajiban bagi umat Muslim .\n \nMelalui pendidikan '
          'diaharapkan umat muslim dapat menjadi pribadi yang tidak hanya pandai tetapi juga '
          'santun dan mulia. Dan kelak akan menjadi manusia yang bermanfaat untuk bangsa, negara '
          'dan Agamanya.',
      'total_donation': '13.000.000',
      'target_donation': '25.000.000',
      'due_date': '30 Juni 2019',
      'total_like': '26.112',
      'total_comment': '8.127',
    });

    await new Future.delayed(new Duration(seconds: 6));

    return data;
  }



  Widget generateActivityPosts(BuildContext context, AsyncSnapshot snapshot) {
    // List<Map<String, String>> values = snapshot.data;
    ListView myList = ListView.builder(
        shrinkWrap: true, // todo comment this out and check the result
        physics: ClampingScrollPhysics(),
        // padding: EdgeInsets.only(top: 10.0), x
        itemCount: _newsList.length,
        itemBuilder: (BuildContext context, int index) {
          // var item = values[index];
          var news = _newsList[index];
          return ActivityNewsContainer(
              newsId: news.id.toString(),
              iconImg: news.imageProfile,
              title: news.title,
              imgContent: news.imageContent,
              postedAt: news.createdDate,
              profileName: news.createdBy,
              excerpt: news.description
          );
        });
    return myList;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: PreferredSize(
              child: AppBar(
                titleSpacing: 10.0,
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
              Future.value(getData());
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
                          future: getData(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            print("ini hasil snapshot data news");
                            print(snapshot.error);
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16.0),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.grey[100],
                                    child: Column(
                                      children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                                          .map(
                                            (_) => Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 48.0,
                                                height: 48.0,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 8.0),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2.0),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 2.0),
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
                              default:
                                if (snapshot.hasError)
                                  return Text('Error: ${snapshot.error}');
                                else
                                  return this
                                      .generateActivityPosts(context, snapshot);
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
        }
    );
  }
}
