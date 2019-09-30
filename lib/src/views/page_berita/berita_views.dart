import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:intl/intl.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_baru_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/komentar_container.dart';

class BeritaViews extends StatefulWidget {
  final BeritaModel value;
  BeritaViews({this.value});

  @override
  _BeritaViewsState createState() => _BeritaViewsState();
}

class _BeritaViewsState extends State<BeritaViews> {
  final String noImg =
      "http://www.sclance.com/pngs/no-image-png/no_image_png_935227.png";
  var titleBar = Text(
    'Berita',
    style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize),
  );

  var formatter = new DateFormat('dd MMMM yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final title = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        widget.value.titleBerita,
        style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
      ),
    );

    final createdBy = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        widget.value.createdBy,
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );

    final createdDate = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 3.0),
      child: Text(
        'Diterbitkan pada ' +
            formatter.format(
              DateTime.fromMicrosecondsSinceEpoch(
                  widget.value.createdDate * 1000),
            ),
        style: TextStyle(fontSize: 12),
      ),
    );

    final description = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Text(widget.value.descriptionBerita, style: TextStyle(fontSize: 14),),
    );

    final mainImage = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 250.0,
            width: MediaQuery.of(context).size.width,
            child: widget.value.imageContent == null
                ? Image.network(noImg, fit: BoxFit.cover)
                : Image.network(widget.value.imageContent[0].imgUrl,
                    fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0.0,
            right: 45.0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                NewIcon.sound_on_3x,
                color: whiteColor,
                size: 25.0,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: 10.0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                NewIcon.full_screen_3x,
                color: whiteColor,
                size: 25.0,
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
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
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
                    Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(NewIcon.love_3x, color: blackColor, size: 20),
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
                            color: blackColor, size: 20),
                      ),
                      Text('${widget.value.totalComment} komentar'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Icon(NewIcon.share_3x, color: blackColor, size: 20),
        ],
      ),
    );

    return Scaffold(
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
}
