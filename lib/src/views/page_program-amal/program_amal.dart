import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/repository/StoriesRepository.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_appbar_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart'as programAmalBloc;
import 'package:flutter_jaring_ummat/src/bloc/storiesBloc.dart' as storiesBloc;
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';

class ProgramAmalPage extends StatefulWidget {
  @override
  _ProgramAmalPageState createState() => _ProgramAmalPageState();
}

class _ProgramAmalPageState extends State<ProgramAmalPage> {
  String selectedCategory = "";
  bool hide_story = false;

  StoriesApiProvider _provider = new StoriesApiProvider();

  @override
  void initState() {
    programAmalBloc.bloc.fetchAllProgramAmal(selectedCategory);
    response();
    super.initState();
  }

  void response() async {
    await _provider.response().then((response) {
      print(response.statusCode);
      if (response.statusCode == 204) {
        setState(() {
          hide_story = true;
        });
      } else {
        if (response.statusCode == 200) {
          setState(() {
            hide_story = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 8,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              leading: InkWell(
                onTap: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Menu Under Development'),
                    ),
                  );
                },
                child: new Icon(
                  AppBarIcons.ic_leading,
                  color: Colors.grey[600],
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: 7.0,
                ),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Chats Menu Under Development'),
                    ));
                  },
                  child: Icon(Icons.chat, color: Colors.grey[600]),
                ),
                SizedBox(
                  width: 7.0,
                ),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Add Menu Under Development'),
                      ),
                    );
                  },
                  child: Icon(AppBarIcons.ic_action, color: Colors.grey[600]),
                ),
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
                    color: Colors.white,
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
                  color: Colors.grey[200],
                ),
                padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
              ),
            ),
            preferredSize: Size.fromHeight(47.0),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              !hide_story
                  ? new SliverAppBar(
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(100.0),
                        child: Text(''),
                      ),
                      elevation: 20.0,
                      flexibleSpace: new Scaffold(
                        backgroundColor: Colors.white,
                        body: new UserStoryAppBar(),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([]),
                    ),
              new SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                flexibleSpace: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 4.0, color: Colors.blueAccent),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    onTap: (int index) {
                      if (index == 0) {
                        setState(() {
                          selectedCategory = "";
                        });
                      } else if (index == 1) {
                        setState(() {
                          selectedCategory = "Pendidikan";
                        });
                      } else if (index == 2) {
                        setState(() {
                          selectedCategory = "Kemanusiaan";
                        });
                      } else if (index == 3) {
                        setState(() {
                          selectedCategory = "Amal";
                        });
                      } else if (index == 4) {
                        setState(() {
                          selectedCategory = "Pembangunan Mesjid";
                        });
                      } else if (index == 5) {
                        setState(() {
                          selectedCategory = "Zakat";
                        });
                      } else if (index == 6) {
                        setState(() {
                          selectedCategory = "Sosial";
                        });
                      } else if (index == 7) {
                        setState(() {
                          selectedCategory = "lain-lain";
                        });
                      }
                      programAmalBloc.bloc
                          .fetchAllProgramAmal(selectedCategory);
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
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: <Widget>[
                      StreamBuilder(
                        stream: programAmalBloc.bloc.streamProgramAmal,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          print(snapshot.connectionState);
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Container(
                                width: 500.0,
                                margin: EdgeInsets.only(top: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('No Connection To Server')
                                  ],
                                ),
                              );
                            case ConnectionState.waiting:
                              return shimmerLoading();
                            default:
                              if (snapshot.hasData && snapshot != null) {
                                if (snapshot.data.length > 0) {
                                  return buildList(snapshot.data);
                                } else if (snapshot.data.length == 0) {
                                  return Container(
                                    width: 500.0,
                                    margin: EdgeInsets.only(top: 20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text('No Data Post Amal')
                                      ],
                                    ),
                                  );
                                }
                              } else if (snapshot.hasError) {
                                var error = snapshot.error.toString();
                                toastServerError(error);
                              } else {
                                return Container(
                                  width: 500.0,
                                  margin: EdgeInsets.only(top: 30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        'assets/icon/no-content.svg',
                                        height: 250.0,
                                      ),
                                      Text(
                                        'Oops..',
                                        style: TextStyle(
                                          fontFamily: 'Proxima',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'There\'s nothing \'ere, yet.',
                                        style: TextStyle(
                                          fontFamily: 'Proxima',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          }
                        },
                      )
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toastServerError(String errorMsg) {
    Toast.show(
      "$errorMsg",
      context,
      backgroundColor: Colors.grey,
      backgroundRadius: 5.0,
      textColor: Colors.white,
      gravity: Toast.CENTER,
    );
  }

  Widget buildList(List<ProgramAmalModel> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.length,
      itemBuilder: (BuildContext context, int index) {
        List<String> thumbnailTemp = new List<String>();
        var dataSnapshot = snapshot[index];
        dataSnapshot.imageContent.forEach((val) {
          String data = val.imgUrl;
          thumbnailTemp.add(data);
        });

        return ProgramAmalContent(
          programAmal: snapshot[index],
        );
      },
    );
  }

  Widget shimmerLoading() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: [0, 1, 2, 3, 4, 5, 6, 7]
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
