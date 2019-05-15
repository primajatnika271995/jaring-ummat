import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/custom_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';

class ActivityNewsContainer extends StatefulWidget {
  final String newsId;
  final String iconImg;
  final String profileName;
  final List<dynamic> imgContent;
  final String category;
  final String title;
  final int postedAt;
  final String excerpt;

  ActivityNewsContainer(
      {this.newsId,
      this.iconImg,
      this.profileName,
      this.imgContent,
      this.category,
      this.title,
      this.postedAt = 0,
      this.excerpt});

  @override
  _ActivityNewsContainerState createState() => _ActivityNewsContainerState();
}

class _ActivityNewsContainerState extends State<ActivityNewsContainer> {
  bool isLoved = false;
  bool flag = true;

  String lessDesc;
  String moreDesc;

  @override
  void initState() {
    super.initState();

    if (widget.excerpt.length > 150) {
      lessDesc = widget.excerpt.substring(0, 150);
      moreDesc = widget.excerpt.substring(150, widget.excerpt.length);
    } else {
      lessDesc = widget.excerpt;
      moreDesc = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: <Widget>[
          setTopContent(),
          setMainImage(),
          setDescription(),
          setBottomContent()
        ],
      ),
    );
  }

  Widget setTopContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[getNewsIcons(), getNewsTitle()],
      ),
    );
  }

  Widget setTopContentShare() {
    return Container(
      color: Colors.blueAccent,
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[getNewsIconsShare(), getNewsTitleShare()],
      ),
    );
  }

  Widget setMainImage() {
    return CarouselSlider(
      height: 300.0,
      autoPlay: true,
      viewportFraction: 1.0,
      aspectRatio: MediaQuery.of(context).size.aspectRatio,
      items: widget.imgContent.map(
        (url) {
          return Container(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(0.0)),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(base64Decode(url)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget setBottomContent() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          setCommentandLikes(),
          setSave(),
        ],
      ),
    );
  }

  Widget setCommentandLikes() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              isLoved = true;
            });
          },
          child: Row(
            children: <Widget>[
              Icon(
                (isLoved) ? CustomFonts.heart : CustomFonts.heart_empty,
                size: 13.0,
                color: (isLoved) ? Colors.red : null,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '0' + ' Likes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {
//            modalSheetComment();
          },
          child: Row(
            children: <Widget>[
              Icon(
                CustomFonts.chat_bubble_outline,
                size: 13.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '0' + ' Komentar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget modalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          child: new Column(
            children: <Widget>[
              setTopContentShare(),
              SizedBox(
                height: 30.0,
              ),
              new Container(
                child: new Text(
                  'Bagikan Melalui Facebook',
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              new Divider(),
              SizedBox(
                height: 30.0,
              ),
              new Container(
                child: new Text(
                  'Bagikan Melalui WhatsApp',
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              new Divider(),
              SizedBox(
                height: 30.0,
              ),
              new Container(
                child: new Text(
                  'Bagikan Melalui Email',
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              new Divider(),
              SizedBox(
                height: 30.0,
              ),
              new Container(
                child: new Text(
                  'Salin Link galang amal ini',
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget setSave() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            modalSheet();
          },
          child: Row(
            children: <Widget>[
              Icon(
                Icons.share,
                size: 17.0,
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget setDescription() {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: moreDesc.isEmpty
          ? new Text(
              lessDesc,
              style: TextStyle(color: Colors.black45),
            )
          : new Column(
              children: <Widget>[
                new Text(
                  flag ? (lessDesc + "...") : (lessDesc + moreDesc),
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black45),
                ),
                new InkWell(
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget getNewsIcons() {
    return Container(
      width: 53.0,
      height: 53.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
          image: MemoryImage(base64Decode(widget.iconImg)),
        ),
      ),
    );
  }

  Widget getNewsTitle() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            widget.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
          Text(
            'oleh ' +
                widget.profileName +
                ' • ' +
                TimeAgoService().timeAgoFormatting(widget.postedAt),
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }

  Widget getNewsIconsShare() {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.iconImg), fit: BoxFit.contain)),
    );
  }

  Widget getNewsTitleShare() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            widget.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Colors.white),
          ),
          Text(
            'oleh ' +
                widget.profileName +
                ' - ' +
                TimeAgoService().timeAgoFormatting(widget.postedAt),
            style: TextStyle(fontSize: 12.0, color: Colors.white),
          )
        ],
      ),
    );
  }
}
