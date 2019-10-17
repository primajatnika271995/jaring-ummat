import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/beritaBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_content.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_views.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';

class BeritaLembaga extends StatefulWidget {
  final String idUser;
  final String category;
  BeritaLembaga({this.idUser, this.category});

  @override
  _BeritaLembagaState createState() => _BeritaLembagaState(idUser: this.idUser, category: this.category);
}

class _BeritaLembagaState extends State<BeritaLembaga> {
  String idUser;
  String category;
  _BeritaLembagaState({this.idUser, this.category});

  String selectedCategory = "beritaku";

  bool _loadingVisible = false;

  var formatter = new DateFormat('dd MMM yyyy HH:mm:ss');

  /*
   * Image No Content Replace with This
   */
  final List<String> imgNoContent = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png"
  ];

  /*
   * Variable Current Image
   */
  int current = 0;
  int currentImage = 1;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: CustomScrollView(
          slivers: <Widget>[
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
                                                  BeritaViews(value: data),
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            CarouselSlider(
                                              height: 260.0,
                                              autoPlay: false,
                                              reverse: false,
                                              viewportFraction: 1.0,
                                              aspectRatio:
                                              MediaQuery.of(context)
                                                  .size
                                                  .aspectRatio,
                                              items: (data.imageContent == null)
                                                  ? imgNoContent.map((url) {
                                                return Container(
                                                  child: CachedNetworkImage(
                                                      imageUrl: url,
                                                      fit: BoxFit.cover,
                                                      width:
                                                      MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width),
                                                );
                                              }).toList()
                                                  : data.imageContent.map(
                                                    (url) {
                                                  return Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        child:
                                                        CachedNetworkImage(
                                                          imageUrl: url.resourceType ==
                                                              "video"
                                                              ? url
                                                              .urlThumbnail
                                                              : url.url,
                                                          fit: BoxFit
                                                              .cover,
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width,
                                                        ),
                                                      ),
                                                      url.resourceType ==
                                                          "video"
                                                          ? Positioned(
                                                        right: screenWidth(
                                                            context,
                                                            dividedBy:
                                                            2.3),
                                                        top: screenHeight(
                                                            context,
                                                            dividedBy:
                                                            8),
                                                        child:
                                                        InkWell(
                                                          onTap: () =>
                                                              showMediaPlayer(
                                                                  url.url),
                                                          child:
                                                          CircleAvatar(
                                                            radius:
                                                            30,
                                                            backgroundColor:
                                                            greenColor,
                                                            child:
                                                            Icon(
                                                              AllInOneIcon
                                                                  .play_4x,
                                                              color:
                                                              whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          : Container(),
                                                    ],
                                                  );
                                                },
                                              ).toList(),
                                              onPageChanged: (index) {
                                                current = index;
                                                currentImage = index + 1;
                                                setState(() {});
                                              },
                                            ),
                                            Positioned(
                                              right: 20.0,
                                              top: 10.0,
                                              child: Badge(
                                                badgeColor: blackColor,
                                                elevation: 0.0,
                                                shape: BadgeShape.square,
                                                borderRadius: 10,
                                                toAnimate: false,
                                                badgeContent: (data
                                                    .imageContent ==
                                                    null)
                                                    ? Text(
                                                  '$currentImage / ${imgNoContent.length}',
                                                  style: TextStyle(
                                                      color: whiteColor),
                                                )
                                                    : Text(
                                                  '$currentImage / ${data.imageContent.length}',
                                                  style: TextStyle(
                                                      color: whiteColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 20.0, top: 10.0),
                                        child: const Text(
                                          'Kegiatan',
                                          style: TextStyle(color: Colors.grey),
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
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 5.0,
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    data.createdBy,
                                                    style:
                                                    TextStyle(fontSize: 12),
                                                  ),
                                                  Text(
                                                      formatter
                                                          .format(DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                          data.createdDate *
                                                              1000))
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 11))
                                                ],
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5.0,
                                                right: 5.0,
                                                bottom: 5.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[
                                                  // Icon(NewIcon.love_3x,
                                                  //     color: blackColor,
                                                  //     size: 20.0),
                                                  // SizedBox(width: 10.0),
                                                  Icon(
                                                    NewIcon.save_3x,
                                                    color: blackColor,
                                                    size: 20.0,
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Icon(
                                                    NewIcon.share_3x,
                                                    color: blackColor,
                                                    size: 20.0,
                                                  ),
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
                                            new EdgeInsetsDirectional.only(
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
                      builder:
                          (context, AsyncSnapshot<List<BeritaModel>> snapshot) {
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
                              width: screenWidth(context),
                              color: whiteColor,
                              margin: EdgeInsets.only(top: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                      'assets/backgrounds/no_data_accent.png',
                                      height: 250),
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

  void showMediaPlayer(String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 250,
            color: Colors.transparent,
            width: screenWidth(context),
            child: SimpleViewPlayer(
              url,
              isFullScreen: false,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchAllBeritaLembagaAmal(idUser, selectedCategory);
  }
}