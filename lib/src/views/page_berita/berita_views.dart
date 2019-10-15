import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/share_program_amal_container.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/services/likeUnlikeApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/active_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/komentar_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeritaViews extends StatefulWidget {
  final BeritaModel value;

  BeritaViews({this.value});

  @override
  _BeritaViewsState createState() => _BeritaViewsState();
}

class _BeritaViewsState extends State<BeritaViews> {
  final String noImg =
      "http://www.sclance.com/pngs/no-image-png/no_image_png_935227.png";

  bool isLoved = false;

  var titleBar = Text('Berita',
      style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize));

  LikeUnlikeProvider api = new LikeUnlikeProvider();

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

  var formatter = new DateFormat('dd MMMM yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final title = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        widget.value.titleBerita,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );

    final createdBy = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        widget.value.createdBy,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );

    final createdDate = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 3.0),
      child: Text(
        'Diterbitkan pada ${formatter.format(DateTime.fromMicrosecondsSinceEpoch(widget.value.createdDate * 1000))}',
        style: TextStyle(fontSize: 13),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      child: Text(widget.value.descriptionBerita),
    );

    final mainImage = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Stack(
        children: <Widget>[
          CarouselSlider(
            height: 260.0,
            autoPlay: false,
            reverse: false,
            viewportFraction: 1.0,
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
            items: (widget.value.imageContent == null)
                ? imgNoContent.map((url) {
                    return Container(
                      child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width),
                    );
                  }).toList()
                : widget.value.imageContent.map(
                    (url) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: url.resourceType == "video"
                                  ? url.urlThumbnail
                                  : url.url,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          url.resourceType == "video"
                              ? Positioned(
                                  right: screenWidth(context, dividedBy: 2.3),
                                  top: screenHeight(context, dividedBy: 8),
                                  child: InkWell(
                                    onTap: () => showMediaPlayer(url.url),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: greenColor,
                                      child: Icon(
                                        AllInOneIcon.play_4x,
                                        color: whiteColor,
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
              badgeContent: (widget.value.imageContent == null)
                  ? Text(
                      '$currentImage / ${imgNoContent.length}',
                      style: TextStyle(color: whiteColor),
                    )
                  : Text(
                      '$currentImage / ${widget.value.imageContent.length}',
                      style: TextStyle(color: whiteColor),
                    ),
            ),
          ),
        ],
      ),
    );

    final postLocation = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
      child: const Text(
        'Jakarta, 30 Agustus 2019',
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );

    final likeNComment = Padding(
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0.0, right: 10.0),
                child: Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
//                        setState(() {
//                          if (isLoved == true) {
//                            isLoved = false;
//                          } else {
//                            isLoved = true;
//                          }
//                        });
                        isLoved ? unlikeProgram() : likeProgram();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: isLoved ? iconLike() : iconUnlike(),
                      ),
                    ),
                    Text('${widget.value.totalLikes} suka'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return KomentarContainer(
                        berita: this.widget.value,
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(NewIcon.comment_3x,
                            color: blackColor, size: 25),
                      ),
                      Text('${widget.value.totalComment} komentar'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return ShareProgramAmal();
              },
            ),
            child: Icon(
              NewIcon.share_3x,
              color: blackColor,
              size: 25,
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: titleBar,
        backgroundColor: whiteColor,
        centerTitle: false,
        elevation: 1.0,
        titleSpacing: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(NewIcon.back_big_3x, color: blackColor, size: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title,
            createdBy,
            createdDate,
            mainImage,
            postLocation,
            description,
            likeNComment,
          ],
        ),
      ),
    );
  }

  Widget iconLike() {
    return Icon(ActiveIcon.love_active_3x, size: 25.0, color: Colors.red);
  }

  Widget iconUnlike() {
    return Icon(NewIcon.love_3x, size: 25.0, color: Colors.black);
  }

  void likeProgram() async {
    print("Like");
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);

    api.likePost(widget.value.idBerita, "", userId).then((response) {
      if (response.statusCode == 201) {
        var stateTotalLike = widget.value.totalLikes;
        var addLikes = stateTotalLike + 1;
        setState(() {
          widget.value.totalLikes = addLikes;
          widget.value.likeThis = true;
          isLoved = true;
        });
      }
    });
  }

  void unlikeProgram() async {
    print("Unlike");
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);
    var stateTotalLike = widget.value.totalLikes;
    if (stateTotalLike > 0) {
      api.unlikeNews(widget.value.idBerita, userId).then((response) {
        if (response.statusCode == 200) {
          var sublike = stateTotalLike - 1;
          setState(() {
            widget.value.totalLikes = sublike;
            widget.value.likeThis = false;
            isLoved = false;
          });
        }
      });
    }
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
    // TODO: implement initState
    print("Data Berita");
    print(jsonEncode(widget.value));
    isLoved = widget.value.likeThis;
    print("IS LOVED");
    print(isLoved);
    super.initState();
  }
}
