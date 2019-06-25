import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/custom_fonts.dart';

import '../../views/galang_amal.dart';

class ProgramAmalContent extends StatefulWidget {
  final ProgramAmal programAmal;
  ProgramAmalContent({Key key, @required this.programAmal}) : super(key: key);

  @override
  _ProgramAmalContentState createState() => _ProgramAmalContentState();
}

class _ProgramAmalContentState extends State<ProgramAmalContent> {
  int _current = 0;
  bool isLoved = false;
  bool flag = true;
  String lessDesc;
  String moreDesc;

  @override
  void initState() {
    super.initState();
    if (widget.programAmal.descriptionProgram.length > 150) {
      lessDesc = widget.programAmal.descriptionProgram.substring(0, 150);
      moreDesc = widget.programAmal.descriptionProgram
          .substring(150, widget.programAmal.descriptionProgram.length);
    } else {
      lessDesc = widget.programAmal.descriptionProgram;
      moreDesc = "";
    }
  }

  Widget titleContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        widget.programAmal.titleProgram,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      Text(
                        'oleh ' +
                            widget.programAmal.createdBy +
                            ' • ' +
                            TimeAgoService().timeAgoFormatting(
                                widget.programAmal.createdDate),
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          dividerContent(context),
        ],
      ),
    );
  }

  Widget imageContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          height: 230.0,
          autoPlay: false,
          reverse: false,
          viewportFraction: 1.0,
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          items: widget.programAmal.imageContent.map(
            (url) {
              return Container(
                child: CachedNetworkImage(
                  imageUrl: url["imgUrl"],
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              );
            },
          ).toList(),
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Positioned(
          right: 20.0,
          top: 10.0,
          child: Badge(
            badgeColor: Colors.white,
            elevation: 0.0,
            shape: BadgeShape.square,
            borderRadius: 20,
            toAnimate: false,
            badgeContent: Text('${_current} / ${widget.programAmal.imageContent.length}', style: TextStyle(color: Colors.grey)),
          ),
        ),
        Positioned(
          left: 10.0,
          bottom: 15.0,
          child: DotsIndicator(
            dotsCount: widget.programAmal.imageContent.length,
            position: _current,
            decorator: DotsDecorator(
              spacing: const EdgeInsets.all(2.0),
            ),
          ),
        )
      ],
    );
  }

  Widget descriptionContent(BuildContext context) {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: moreDesc.isEmpty
          ? new Text(
              lessDesc,
              style: TextStyle(color: Colors.black),
            )
          : new Column(
              children: <Widget>[
                new Text(
                  flag ? (lessDesc + "...") : (lessDesc + moreDesc),
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black),
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

  Widget dividerContent(BuildContext context) {
    return Divider(
      color: Colors.grey,
    );
  }

  Widget donationContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: 3.0),
              Text(
                'Donasi terkumpul',
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(122, 122, 122, 1.0)),
              ),
              SizedBox(height: 3.0),
              Text(
                'Rp. ' +
                    '${CurrencyFormat().currency(widget.programAmal.targetDonasi)}' +
                    ' / ' +
                    '${CurrencyFormat().currency(widget.programAmal.targetDonasi)}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                'Batas waktu ' + widget.programAmal.endDonasi,
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(122, 122, 122, 1.0)),
              )
            ],
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalangAmalView(
                        programAmal: widget.programAmal,
                      ),
                ),
              );
            },
            textColor: Colors.white,
            padding: EdgeInsets.all(0.0),
            color: Color.fromRGBO(21, 101, 192, 1.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              child: Text('Kirim Donasi'),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          commentAndLikeContent(),
          shareContent(),
        ],
      ),
    );
  }

  Widget commentAndLikeContent() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              if (isLoved) {
                isLoved = false;
              } else {
                isLoved = true;
              }
            });
          },
          child: Row(
            children: <Widget>[
              Icon(
                (isLoved) ? CustomFonts.heart : CustomFonts.heart_empty,
                size: 18.0,
                color: (isLoved) ? Colors.red : null,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                ' ${widget.programAmal.totalLikes} Likes',
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
          onTap: () {},
          child: Row(
            children: <Widget>[
              Icon(
                CustomFonts.chat_bubble_outline,
                size: 18.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${widget.programAmal.totalComment}' + ' Komentar',
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

  Widget shareContent() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          titleContent(context),
          imageContent(context),
          descriptionContent(context),
          dividerContent(context),
          donationContent(context),
          bottomContent(context),
        ],
      ),
    );
  }
}
