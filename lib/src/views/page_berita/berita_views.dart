import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_baru_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';

class BeritaViews extends StatefulWidget {
  final String judulBerita;
  final String createdBy;
  final int createdDate;
  final String mainImageUrl;
  final String descriptionBerita;
  final int totalLikesBerita;
  final int totalCommentBerita;
  BeritaViews(
      {this.judulBerita,
      this.createdBy,
      this.createdDate,
      this.mainImageUrl,
      this.descriptionBerita,
      this.totalLikesBerita,
      this.totalCommentBerita});

  @override
  _BeritaViewsState createState() => _BeritaViewsState();
}

class _BeritaViewsState extends State<BeritaViews> {
  var titleBar = Text(
    'Berita',
    style: TextStyle(color: blackColor),
  );

  @override
  Widget build(BuildContext context) {
    final title = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        widget.judulBerita,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );

    final createdBy = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        widget.createdBy,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );

    final createdDate = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 3.0),
      child: Text(
          'Diterbitkan pada ${DateTime.fromMicrosecondsSinceEpoch(widget.createdDate)}'),
    );

    final description = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Text(widget.descriptionBerita),
    );

    final mainImage = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 250.0,
            width: MediaQuery.of(context).size.width,
            child: Image.network(widget.mainImageUrl, fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 20.0,
            right: 80.0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                NewIcon.sound_on_3x,
                color: whiteColor,
                size: 30.0,
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 30.0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                NewIcon.full_screen_3x,
                color: whiteColor,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
    );

    final postLocation = Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: const Text(
        'Jakarta, 30 Agustus 2019',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      child: Icon(NewIcon.love_3x, color: greenColor),
                    ),
                    Text('${widget.totalLikesBerita} suka'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 0.0, right: 0.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(NewIcon.comment_3x, color: greenColor),
                    ),
                    Text('${widget.totalCommentBerita} komentar'),
                  ],
                ),
              ),
            ],
          ),
          Icon(NewIcon.share_3x, color: greenColor),
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
          child: Icon(NewIcon.back_big_3x, color: greenColor),
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
