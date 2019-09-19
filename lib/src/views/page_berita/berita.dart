import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/beritaBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_content.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_views.dart';
import 'package:flutter_svg/svg.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({Key key}) : super(key: key);

  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  String selectedCategory = "beritaku";

  final String noImg =
      "http://www.sclance.com/pngs/no-image-png/no_image_png_935227.png";

  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        body: DefaultTabController(
          length: 7,
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: whiteColor,
              elevation: 0.0,
              title: Text(
                'Berita Jejaring',
                style:
                    TextStyle(color: blackColor, fontSize: SizeUtils.titleSize),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(right: 10.0),
                  icon: Icon(NewIcon.search_big_3x),
                  iconSize: 20.0,
                  color: blackColor,
                ),
              ],
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                new SliverAppBar(
                  backgroundColor: whiteColor,
                  elevation: 1.0,
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  flexibleSpace: AppBar(
                    backgroundColor: whiteColor,
                    elevation: 2.0,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      isScrollable: true,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: greenColor),
                      ),
                      labelColor: blackColor,
                      unselectedLabelColor: grayColor,
                      onTap: (int index) {
                        switch (index) {
                          case 0:
                            setState(() {
                              selectedCategory = "beritaku";
                            });
                            break;
                          case 1:
                            setState(() {
                              selectedCategory = "";
                            });
                            break;
                          case 2:
                            setState(() {
                              selectedCategory = "Keagamaan";
                            });
                            break;
                          case 3:
                            setState(() {
                              selectedCategory = "Kemanusiaan";
                            });
                            break;
                          case 4:
                            setState(() {
                              selectedCategory = "Pendidikan";
                            });
                            break;
                          case 5:
                            setState(() {
                              selectedCategory = "Lingkungan";
                            });
                            break;
                          case 6:
                            setState(() {
                              selectedCategory = "Kesehatan";
                            });
                            break;
                          default:
                            setState(() {
                              selectedCategory = "beritaku";
                            });
                        }
                        bloc.fetchAllBerita(selectedCategory);
                      },
                      tabs: <Widget>[
                        new Tab(
                          text: 'Beritaku',
                        ),
                        new Tab(
                          text: 'Populer',
                        ),
                        new Tab(
                          text: 'Keagamaan',
                        ),
                        new Tab(
                          text: 'Kemanusiaan',
                        ),
                        new Tab(
                          text: 'Pendidikan',
                        ),
                        new Tab(
                          text: 'Lingkungan',
                        ),
                        new Tab(
                          text: 'Kesehatan',
                        ),
//                        new Tab(
//                          text: 'Zakat',
//                        ),
//                        new Tab(
//                          text: 'Bakti Sosial',
//                        ),
//                        new Tab(
//                          text: 'lain-lain',
//                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      children: <Widget>[
                        Container(
                          child: StreamBuilder(
                              stream: bloc.allBerita,
                              builder: (context,
                                  AsyncSnapshot<List<BeritaModel>> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Text('');
                                    break;
                                  default:
                                    if (snapshot.hasData) {
                                      var data = snapshot.data[0];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BeritaViews(
                                                    value: data,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 230.0,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: data.imageContent == null
                                                  ? Image.network(
                                                      noImg,
                                                      fit: BoxFit.fitWidth,
                                                    )
                                                  : Image.network(
                                                      data.imageContent[0]
                                                          .imgUrl,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 20.0,
                                                top: 10.0),
                                            child: const Text(
                                              'Kegiatan',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.0,
                                              right: 20.0,
                                              top: 0.0,
                                            ),
                                            child: Text(
                                              data.titleBerita,
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10.0,
                                              right: 15.0,
                                              top: 5.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Text(data.createdBy),
                                                    Text(DateTime
                                                            .fromMicrosecondsSinceEpoch(
                                                                data.createdDate *
                                                                    1000)
                                                        .toString(), style: TextStyle(fontSize: 11))
                                                  ],
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 5.0,
                                                    right: 5.0,
                                                    bottom: 5.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Icon(NewIcon.love_3x,
                                                          color: blackColor,
                                                          size: 20.0),
                                                      SizedBox(width: 10.0),
                                                      Icon(NewIcon.comment_3x,
                                                          color: blackColor,
                                                          size: 20.0),
                                                      SizedBox(width: 10.0),
                                                      Icon(NewIcon.share_3x,
                                                          color: blackColor,
                                                          size: 20.0),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                            child: new Center(
                                              child: new Container(
                                                margin:
                                                    new EdgeInsetsDirectional
                                                            .only(
                                                        start: 1.0, end: 1.0),
                                                height: 5.0,
                                                color: softGreyColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                }
                                return Container();
                              }),
                        ),
                        StreamBuilder(
                          stream: bloc.allBerita,
                          builder: (context,
                              AsyncSnapshot<List<BeritaModel>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                _loadingVisible = true;
                                return Text('');
                                break;
                              default:
                                if (snapshot.hasData) {
                                  _loadingVisible = false;
                                  return buildList(snapshot);
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                _loadingVisible = false;
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
                                break;
                            }
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
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

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchAllBerita(selectedCategory);
  }
}
