import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/utils/textUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
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

class InfoJaringViews extends StatefulWidget {
  int valIndex;

  InfoJaringViews({this.valIndex});

  @override
  _InfoJaringViewsState createState() => _InfoJaringViewsState();
}

class _InfoJaringViewsState extends State<InfoJaringViews> {
  final String noImg =
      "http://www.sclance.com/pngs/no-image-png/no_image_png_935227.png";

  bool isLoved = false;

  var titleBar = Text('Info Jaring',
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
        listInfoJaring[widget.valIndex].title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );

    final createdBy = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        listInfoJaring[widget.valIndex].createdBy,
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );

    final createdDate = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 3.0),
      child: Text(
        'Diterbitkan pada ${listInfoJaring[widget.valIndex].createdDate}',
        style: TextStyle(fontSize: 13),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      child: Text(listInfoJaring[widget.valIndex].description, textAlign: TextAlign.justify,),
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
            items: (listInfoJaring[widget.valIndex].imageUrl == null)
                ? imgNoContent.map((url) {
                    return Container(
                      child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width),
                    );
                  }).toList()
                : imgNoContent.map((url) {
                    return Container(
                      child: CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width),
                    );
                  }).toList(),
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
              badgeContent: (imgNoContent == null)
                  ? Text(
                '$currentImage / ${imgNoContent.length}',
                style: TextStyle(color: whiteColor),
              )
                  : Text(
                '$currentImage / ${imgNoContent.length}',
                style: TextStyle(color: whiteColor),
              ),
            ),
          ),
        ],
      ),
    );

    final postLocation = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
      child: Text(
        "Jakarta, ${listInfoJaring[widget.valIndex].createdDate}",
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
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
            description
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    print("Data Info Jaring");
    print(listInfoJaring[widget.valIndex]);
    setState(() {
      imgNoContent.removeAt(0);
      imgNoContent.add(listInfoJaring[widget.valIndex].imageUrl);
    });
    super.initState();
  }
}
