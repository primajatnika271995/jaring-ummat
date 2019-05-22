import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:shimmer/shimmer.dart';

// Component
import 'package:flutter_jaring_ummat/src/views/components/activity_post_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_appbar_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/urls.dart';
import '../scope_model/program_amal_json_cache.dart';

class TimelineView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TimelineState();
  }
}

class _TimelineState extends State<TimelineView>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  // Dio Variable
  Response response;
  Dio dio = new Dio();

  // Variable Preferences
  SharedPreferences _preferences;
  String _email;

  // Variable Animation Control
  AnimationController _controller;

  // Variable Tab Controller
  TabController _tabController;

  var _programAmalList = new List<ProgramAmalModel>();
  var _programAmalListStore = new List<ProgramAmalModel>();

  bool _isSelected;
  CircularProgressIndicator progressIndicator = new CircularProgressIndicator();

  ProgramAmalCache _programAmalCache = ProgramAmalCache();

  @override
  void initState() {
    super.initState();
    this._tabController = new TabController(vsync: this, length: 8);
    this._controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    setState(() {
      fetchProgramAmalCache();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<List<ProgramAmalModel>> fetchProgramAmalCache() async {
    _preferences = await SharedPreferences.getInstance();
    var data = _preferences.getString("timeline_store");
    print("INI STORE DATA");
    print(data);

    Iterable list = json.decode(data);
    setState(() {
      _programAmalListStore =
          list.map((model) => ProgramAmalModel.fromJson(model)).toList();
    });

    print("INI LENGTH DARTI STORE LIST ==>");
    print(_programAmalList.length);
  }

  Future<List<ProgramAmalModel>> fetchProgramAmal() async {
    final response = await dio.get(PROGRAM_AMAL_LIST_ALL_URL);
    print("INI RESPONSE CODE NYA ==>");
    print(response.statusCode);

    print("INI RESPONSE BODY NYA ==>");
    print(response.data);

    if (response.statusCode == 200) {
      _preferences = await SharedPreferences.getInstance();
      var data = json.encode(response.data);
      _preferences.setString("timeline_store", data);

      Iterable list = response.data;
      _programAmalList =
          list.map((model) => ProgramAmalModel.fromJson(model)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.blueAccent,
            leading: new Icon(AppBarIcons.ic_leading),
            actions: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Icon(Icons.chat),
              SizedBox(
                width: 12.0,
              ),
              Icon(AppBarIcons.ic_action),
              SizedBox(
                width: 5.0,
              ),
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
                color: Colors.white,
              ),
              padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
            ),
          ),
          preferredSize: Size.fromHeight(47.0),
        ),
        body: RefreshIndicator(
            child: CustomScrollView(
              slivers: <Widget>[
                new SliverAppBar(
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(99.0),
                    child: Text(''),
                  ),
                  backgroundColor: Colors.white,
                  flexibleSpace: new Scaffold(
                    body: new UserStoryAppBar(),
                  ),
                ),
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
                          future: fetchProgramAmal(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                if (_programAmalListStore.isEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 16.0),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100],
                                      child: Column(
                                        children: [0, 1, 2, 3, 4, 5, 6, 7, 8]
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
                                  itemCount: _programAmalListStore.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var programAmalItem =
                                        _programAmalListStore[index];
                                    print("INI DATA DARI STORE ==>");
                                    print(programAmalItem.titleProgram);
                                    return ActivityPostContainer(
                                      activityPostId: programAmalItem.idUser,
                                      title: programAmalItem.titleProgram,
                                      profileName: programAmalItem.createdBy,
                                      postedAt: programAmalItem.createdDate,
                                      imgContent: programAmalItem.imageContent,
                                      description:
                                          programAmalItem.descriptionProgram,
                                      totalDonation:
                                          programAmalItem.totalDonasi,
                                      targetDonation:
                                          programAmalItem.targetDonasi,
                                      dueDate: programAmalItem.endDonasi,
                                      totalLike: programAmalItem.totalDonasi
                                          .toString(),
                                      totalComment: programAmalItem.totalDonasi
                                          .toString(),
                                    );
                                  },
                                );
                              default:
                                return ListView.builder(
                                  shrinkWrap:
                                      true, // todo comment this out and check the result
                                  physics: ClampingScrollPhysics(),
                                  itemCount: _programAmalList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var programAmalItem =
                                        _programAmalList[index];
                                    return ActivityPostContainer(
                                      activityPostId: programAmalItem.idUser,
                                      title: programAmalItem.titleProgram,
                                      profileName: programAmalItem.createdBy,
                                      postedAt: programAmalItem.createdDate,
                                      imgContent: programAmalItem.imageContent,
                                      description:
                                          programAmalItem.descriptionProgram,
                                      totalDonation:
                                          programAmalItem.totalDonasi,
                                      targetDonation:
                                          programAmalItem.targetDonasi,
                                      dueDate: programAmalItem.endDonasi,
                                      totalLike: programAmalItem.totalDonasi
                                          .toString(),
                                      totalComment: programAmalItem.totalDonasi
                                          .toString(),
                                    );
                                  },
                                );
                            }
                          },
                        ),
                      ],
                    )
                  ]),
                ),
              ],
            ),
            onRefresh: () => Future.value()));
  }
}
