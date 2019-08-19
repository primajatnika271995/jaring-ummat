import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/services/likeUnlikeApi.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/custom_fonts.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/komentar_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/share_berita_container.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeritaContent extends StatefulWidget {
  final BeritaModel berita;
  BeritaContent({Key key, @required this.berita}) : super(key: key);

  _BeritaContentState createState() => _BeritaContentState();
}

class _BeritaContentState extends State<BeritaContent> {
  final List<String> imgNoContent = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png"
  ];

  int _current = 0;
  int _currentImage = 1;

  bool isLoved = false;
  bool flag = true;

  String lessDesc;
  String moreDesc;

  String idUserLogin;
  String token;

  LikeUnlikeProvider api = new LikeUnlikeProvider();
  SharedPreferences _preferences;

  Future<String> getIdUserLogin() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      this.idUserLogin = _preferences.getString(USER_ID_KEY);
    });
  }

  void likeProgram() async {
    _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);

    api.likePost(widget.berita.idBerita, "", userId).then((response) {
      print(response.statusCode);
      if (response.statusCode == 201) {
        var stateTotalLike = widget.berita.totalLikes;
        var addLikes = stateTotalLike + 1;
        setState(() {
          widget.berita.totalLikes = addLikes;
        });
      }
    });
  }

  void unlikeProgram() async {
    _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);
    var stateTotalLike = widget.berita.totalLikes;
    if (stateTotalLike > 0) {
      api.unlikeNews(widget.berita.idBerita, userId).then((response) {
        if (response.statusCode == 200) {
          var sublike = stateTotalLike - 1;
          setState(() {
            widget.berita.totalLikes = sublike;
          });
        }
      });
    }
  }

  void checkToken() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.berita.descriptionBerita.length > 150) {
      lessDesc = widget.berita.descriptionBerita.substring(0, 150);
      moreDesc = widget.berita.descriptionBerita
          .substring(150, widget.berita.descriptionBerita.length);
    } else {
      lessDesc = widget.berita.descriptionBerita;
      moreDesc = "";
    }

    getIdUserLogin();
    checkToken();
  }

  Widget titleContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
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
              Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 90.0,
                      child: Text(
                        widget.berita.titleBerita,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      'oleh ' +
                          widget.berita.createdBy +
                          ' • ' +
                          TimeAgoService()
                              .timeAgoFormatting(widget.berita.createdDate),
                      style: TextStyle(fontSize: 12.0),
                    )
                  ],
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
          height: 260.0,
          autoPlay: false,
          reverse: false,
          viewportFraction: 1.0,
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          items: (widget.berita.imageContent == null)
              ? imgNoContent.map((url) {
                  return Container(
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                }).toList()
              : widget.berita.imageContent.map(
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
            badgeContent: (widget.berita.imageContent == null)
                ? Text(
                    '${_currentImage} / ${imgNoContent.length}',
                    style: TextStyle(color: Colors.grey),
                  )
                : Text(
                    '${_currentImage} / ${widget.berita.imageContent.length}',
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Divider(
        color: Colors.grey,
      ),
    );
  }

  Widget bottomContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 15.0),
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

            if (isLoved) {
              likeProgram();
            }

            if (!isLoved) {
              unlikeProgram();
            }
          },
          child: Row(
            children: <Widget>[
              Icon(
                widget.berita.likeThis
                    ? CustomFonts.heart
                    : (isLoved) ? CustomFonts.heart : CustomFonts.heart_empty,
                size: 18.0,
                color: widget.berita.likeThis
                    ? Colors.red
                    : (isLoved) ? Colors.red : null,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                ' ${widget.berita.totalLikes} Likes',
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
            print("ID Berita ${this.widget.berita.idBerita}");
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return KomentarContainer(
                    berita: this.widget.berita,
                  );
                });
          },
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
                '${widget.berita.totalComment}' + ' Komentar',
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
                return ShareBerita();
              },
            );
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.white)]),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          titleContent(context),
          imageContent(context),
          descriptionContent(context),
          (token == null) ? Container() : dividerContent(context),
          (token == null) ? Container() : bottomContent(context),
        ],
      ),
    );
  }
}
