import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';
import 'package:shimmer/shimmer.dart';

// Component
import 'package:flutter_jaring_ummat/src/views/components/activity_post_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_appbar_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/urls.dart';

class TimelineView extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _TimelineState();
  }
}

class _TimelineState extends State<TimelineView> with SingleTickerProviderStateMixin, TickerProviderStateMixin {

  AnimationController _controller;
  TabController _tabController;

  List<ProgramAmalModel> programAmalCache = new List<ProgramAmalModel>();

  @override
  void initState() {
    bloc.fetchAllProgramAmal();
    bloc.list.stream.forEach((value) {
      if (mounted) {
        setState(() {
          programAmalCache = value;
        });
      }
    });
    this._tabController = new TabController(vsync: this, length: 8);
    this._controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
                width: 7.0,
              ),
              Icon(Icons.chat),
              SizedBox(
                width: 7.0,
              ),
              Icon(AppBarIcons.ic_action),
              SizedBox(
                width: 13.0,
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
                        StreamBuilder(
                          stream: bloc.streamProgramAmal,
                          builder: (BuildContext context, AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
                            if (snapshot.hasData) {
                              return buildList(snapshot.data);
                            } else if (snapshot.hasError) {
                              return Text(snapshot.hasError.toString());
                            }

                            if (programAmalCache.length > 0) {
                              print("CACHE DATA");
                              return buildList(programAmalCache);
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
            onRefresh: () => Future.value()));
  }

  Widget buildList(List<ProgramAmalModel> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.length,
        itemBuilder: (BuildContext context, int index) {
          return ActivityPostContainer(
            activityPostId: snapshot[index].id,
            profilePictureUrl: '',
            title: snapshot[index].titleProgram,
            profileName: snapshot[index].createdBy,
            postedAt: snapshot[index].createdDate,
            description: snapshot[index].descriptionProgram,
            totalDonation: snapshot[index].totalDonasi,
            imgContent: snapshot[index].imageContent,
            targetDonation: snapshot[index].targetDonasi,
            dueDate: snapshot[index].endDonasi,
            totalLikes: snapshot[index].totalLikes == null ? "0" : snapshot[index].totalLikes.toString(),
            totalComment: snapshot[index].totalComment.toString(),
            idUserLike: snapshot[index].idUserLike,
          );
        });
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
