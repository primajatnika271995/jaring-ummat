import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/active_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/likeUnlikeApi.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/share_program_amal_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/komentar_program_amal_container.dart';

class ProgramAmalContent extends StatefulWidget {
  final ProgramAmalModel programAmal;
  final bool bookmark;
  ProgramAmalContent({Key key, @required this.programAmal, this.bookmark}) : super(key: key);

  @override
  _ProgramAmalContentState createState() => _ProgramAmalContentState(bookmark: this.bookmark);
}

class _ProgramAmalContentState extends State<ProgramAmalContent> {
  bool isLoved = false;
  bool flag = true;
  bool bookmark;

  _ProgramAmalContentState({this.bookmark});

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

  String lessDesc;
  String moreDesc;

  String token;

  LikeUnlikeProvider api = new LikeUnlikeProvider();

  Widget titleContent(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: greenColor,
                  child: widget.programAmal.user.imageUrl == null
                      ? Text(
                          widget.programAmal.createdBy.substring(0, 1),
                          style: TextStyle(color: whiteColor),
                        )
                      : CircularProfileAvatar(widget.programAmal.user.imageUrl),
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
          SizedBox(
            height: 4,
          ),
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
            badgeContent: (widget.programAmal.imageContent == null)
                ? Text(
                    '$currentImage / ${imgNoContent.length}',
                    style: TextStyle(color: whiteColor),
                  )
                : Text(
                    '$currentImage / ${widget.programAmal.imageContent.length}',
                    style: TextStyle(color: whiteColor),
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
                style: TextStyle(fontSize: 13.0, color: grayColor),
              ),
              Text(
                'Rp. ' +
                    '${CurrencyFormat().data.format(widget.programAmal.totalDonation.toDouble())}' +
                    ' / ' +
                    '${CurrencyFormat().data.format(widget.programAmal.targetDonation.toDouble())}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                'Batas waktu ' + widget.programAmal.endDate.toString(),
                style: TextStyle(fontSize: 13.0, color: grayColor),
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
                size: 25.0,
                color: (widget.programAmal.userLikeThis)
                    ? Colors.red
                    : (isLoved) ? Colors.red : blackColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                ' ${widget.programAmal.totalLikes} Likes',
                style: TextStyle(
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
                size: 25.0,
                color: blackColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${widget.programAmal.totalComments}' + ' Komentar',
                style: TextStyle(
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
        InkWell(
          onTap: () {
            bookmark = !bookmark;
            setState(() {});
          },
          child: bookmark ? iconBookmark() : iconUnbookmark(),
        ),
        SizedBox(width: 5),
        InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (context) {
              return ShareProgramAmal();
            },
          ),
          child: Icon(
            NewIcon.share_3x,
            size: 25,
            color: blackColor,
          ),
        ),
        SizedBox(width: 5),
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

  Widget iconBookmark() {
    return Icon(ActiveIcon.save_active_3x, size: 25, color: greenColor);
  }

  Widget iconUnbookmark() {
    return Icon(NewIcon.save_3x, size: 25, color: blackColor);
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

  void likeProgram() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);

    api.likePost("", widget.programAmal.idProgram, userId).then((response) {
      if (response.statusCode == 201) {
        var stateTotalLike = widget.programAmal.totalLikes;
        var addLikes = stateTotalLike + 1;
        setState(() {
          widget.programAmal.totalLikes = addLikes;
          widget.programAmal.userLikeThis = true;
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
            widget.programAmal.userLikeThis = false;
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
