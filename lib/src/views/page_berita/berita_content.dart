import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/custom_fonts.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/komentar_container.dart';
import 'package:rounded_modal/rounded_modal.dart';

class BeritaContent extends StatefulWidget {
  final Berita berita;
  BeritaContent({Key key, @required this.berita}) : super(key: key);

  _BeritaContentState createState() => _BeritaContentState();
}

class _BeritaContentState extends State<BeritaContent> {
  int _current = 0;
  bool isLoved = false;
  bool flag = true;
  String lessDesc;
  String moreDesc;

  @override
  void initState() {
    super.initState();
    if (widget.berita.description.length > 150) {
      lessDesc = widget.berita.description.substring(0, 150);
      moreDesc = widget.berita.description
          .substring(150, widget.berita.description.length);
    } else {
      lessDesc = widget.berita.description;
      moreDesc = "";
    }
  }

  Widget titleContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: 53.0,
              height: 53.0,
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
                    widget.berita.title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
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
          ),
        ],
      ),
    );
  }

  Widget imageContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          height: 200.0,
          autoPlay: false,
          reverse: false,
          viewportFraction: 1.0,
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          items: widget.berita.imageContent.map(
            (url) {
              return Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl:
                        'https://cdns.klimg.com/dream.co.id/resized/244x122/news/2015/07/03/16104/di-dubai-muslim-dan-non-muslim-bersama-membangun-masjid-1507034.jpg',
                    errorWidget: (content, url, error) => new Icon(Icons.error),
                  ),
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
      ],
    );
  }

  Widget descriptionContent(BuildContext context) {
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

  Widget dividerContent(BuildContext context) {
    return Divider(
      color: Colors.grey,
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
            print("ID Berita ${this.widget.berita.id}");
            showRoundedModalBottomSheet(
                radius: 10.0,
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
    return Card(
      elevation: 5.0,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            titleContent(context),
            imageContent(context),
            descriptionContent(context),
            dividerContent(context),
            bottomContent(context),
          ],
        ),
      ),
    );
  }
}
