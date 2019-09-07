import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/active_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/likeUnlikeApi.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';
import 'package:flutter_jaring_ummat/src/views/components/custom_fonts.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/share_program_amal_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/komentar_program_amal_container.dart';

class ProgramAmalContent extends StatefulWidget {
  final ProgramAmalModel programAmal;
  ProgramAmalContent({Key key, @required this.programAmal}) : super(key: key);

  @override
  _ProgramAmalContentState createState() => _ProgramAmalContentState();
}

class _ProgramAmalContentState extends State<ProgramAmalContent> {
  final List<String> imgNoContent = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png"
  ];

  int _current = 0;
  int _currentImage = 1;

  bool isLoved = false;
  bool flag = true;

  String lessDesc;
  String moreDesc;

  String token;

  LikeUnlikeProvider api = new LikeUnlikeProvider();

  Widget titleContent(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: greenColor,
                  child: Text(
                    widget.programAmal.createdBy.substring(0, 1),
                    style: TextStyle(color: whiteColor),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 90.0,
                        child: Text(
                          widget.programAmal.titleProgram,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Text(
                        'oleh ' +
                            widget.programAmal.createdBy +
                            ' • ' +
                            TimeAgoService().timeAgoFormatting(
                                widget.programAmal.createdDate),
                        style: TextStyle(fontSize: 12.0, color: grayColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
          height: 260.0,
          autoPlay: false,
          reverse: false,
          viewportFraction: 1.0,
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          items: (widget.programAmal.imageContent == null)
              ? imgNoContent.map((url) {
                  return Container(
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                }).toList()
              : widget.programAmal.imageContent.map(
                  (url) {
                    return Container(
                      child: CachedNetworkImage(
                        imageUrl: url.imgUrl,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  },
                ).toList(),
          onPageChanged: (index) {
            setState(() {
              _current = index;
              _currentImage = index + 1;
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
            badgeContent: (widget.programAmal.imageContent == null)
                ? Text(
                    '${_currentImage} / ${imgNoContent.length}',
                    style: TextStyle(color: Colors.grey),
                  )
                : Text(
                    '${_currentImage} / ${widget.programAmal.imageContent.length}',
                    style: TextStyle(color: Colors.grey),
                  ),
          ),
        ),
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
              textAlign: TextAlign.justify,
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
                        flag ? "Selengkapnya" : "Perkecil",
                        style: new TextStyle(color: blueColor),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget dividerContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      child: Divider(
        color: Colors.grey,
      ),
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
              Text(
                'Donasi terkumpul',
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: grayColor),
              ),
              Text(
                'Rp. ' +
                    '${CurrencyFormat().currency(widget.programAmal.totalDonation.toDouble())}' +
                    ' / ' +
                    '${CurrencyFormat().currency(widget.programAmal.targetDonation.toDouble())}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                'Batas waktu ' + widget.programAmal.endDate,
                style: TextStyle(fontSize: 11.0, color: grayColor),
              )
            ],
          ),
          RaisedButton(
            onPressed: () {
              (token == null)
                  ? Navigator.of(context).pushNamed('/login')
                  : Navigator.push(
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
            color: greenColor,
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
            if (token == null) {
              Navigator.of(context).pushNamed('/login');
            } else {
              setState(() {
                if (isLoved) {
                  isLoved = false;
                } else {
                  isLoved = true;
                }
              });
              if (isLoved) {
                likeProgram();
              }

              if (!isLoved) {
                unlikeProgram();
              }
            }
          },
          child: Row(
            children: <Widget>[
              Icon(
                (widget.programAmal.userLikeThis)
                    ? ActiveIcon.love_active_3x
                    : (isLoved) ? ActiveIcon.love_active_3x : NewIcon.love_3x,
                size: 20.0,
                color: (widget.programAmal.userLikeThis)
                    ? Colors.red
                    : (isLoved) ? Colors.red : greenColor,
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
          onTap: () {
            print("ID Berita ${this.widget.programAmal.idProgram}");
            if (token == null) {
              Navigator.of(context).pushNamed('/login');
            } else {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return KomentarContainer(
                    programAmal: this.widget.programAmal,
                  );
                },
              );
            }
          },
          child: Row(
            children: <Widget>[
              Icon(
                NewIcon.comment_3x,
                size: 20.0,
                color: greenColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${widget.programAmal.totalComments}' + ' Komentar',
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
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ShareProgramAmal();
              },
            );
          },
          child: Row(
            children: <Widget>[
              Icon(
                NewIcon.share_3x,
                size: 20.0,
                color: greenColor,
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

  @override
  void initState() {
    super.initState();
    // Untuk More Description or Less Description
    if (widget.programAmal.descriptionProgram.length > 150) {
      lessDesc = widget.programAmal.descriptionProgram.substring(0, 150);
      moreDesc = widget.programAmal.descriptionProgram
          .substring(150, widget.programAmal.descriptionProgram.length);
    } else {
      lessDesc = widget.programAmal.descriptionProgram;
      moreDesc = "";
    }
    checkToken();
  }



  void likeProgram() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);

    api.likePost("", widget.programAmal.idProgram, userId).then((response) {
      if (response.statusCode == 201) {
        var stateTotalLike = widget.programAmal.totalLikes;
        var addLikes = stateTotalLike + 1;
        setState(() {
          widget.programAmal.totalLikes = addLikes;
        });
      }
    });
  }

  void unlikeProgram() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);
    var stateTotalLike = widget.programAmal.totalLikes;
    if (stateTotalLike > 0) {
      api.unlikePost(widget.programAmal.idProgram, userId).then((response) {
        if (response.statusCode == 200) {
          var sublike = stateTotalLike - 1;
          setState(() {
            widget.programAmal.totalLikes = sublike;
          });
        }
      });
    }
  }

  void checkToken() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    setState(() {
      token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
  }
}
