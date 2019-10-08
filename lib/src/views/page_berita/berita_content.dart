import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/active_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_views.dart';

class BeritaContent extends StatefulWidget {
  final BeritaModel berita;

  BeritaContent({Key key, @required this.berita}) : super(key: key);

  _BeritaContentState createState() => _BeritaContentState();
}

class _BeritaContentState extends State<BeritaContent> {
  bool isLoved = false;

  final String noImg =
      "http://www.sclance.com/pngs/no-image-png/no_image_png_935227.png";

  var formatter = new DateFormat('dd MMM yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final imageWidget = Padding(
      padding: EdgeInsets.only(top: 10.0, left: 10.0),
      child: Container(
        height: 110.0,
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: (widget.berita.imageContent == null)
                  ? NetworkImage(noImg)
                  : widget.berita.imageContent[0].resourceType == "video"
                      ? NetworkImage(widget.berita.imageContent[0].urlThumbnail)
                      : NetworkImage(widget.berita.imageContent[0].url),
              fit: BoxFit.cover),
        ),
      ),
    );

    final infoWidget = Padding(
      padding: EdgeInsets.only(left: 15.0, top: 5.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.berita.categoryBerita,
                  style: TextStyle(color: grayColor),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 185.0,
                  child: Text(
                    widget.berita.titleBerita,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Container(
                    child: Text(
                      'oleh ${widget.berita.createdBy}',
                      style: TextStyle(color: grayColor),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  widget.berita.likeThis
                      ? ActiveIcon.love_active_3x
                      : NewIcon.love_3x,
                  color: widget.berita.likeThis ? redColor : blackColor,
                  size: 20,
                ),
                Icon(NewIcon.comment_3x, color: blackColor, size: 20.0),
                Icon(NewIcon.save_3x, color: blackColor, size: 20.0),
              ],
            ),
          ],
        ),
      ),
    );

    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BeritaViews(
                value: widget.berita,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: imageWidget,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.berita.categoryBerita,
                        style: TextStyle(color: grayColor),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 180,
                        child: Text(
                          widget.berita.titleBerita,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Text(
                        'oleh ${widget.berita.createdBy}',
                        style: TextStyle(color: grayColor, fontSize: 12),
                      ),
                      Text(
                          formatter
                              .format(DateTime.fromMicrosecondsSinceEpoch(
                                  widget.berita.createdDate * 1000))
                              .toString(),
                          style: TextStyle(fontSize: 11)),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(NewIcon.save_3x,
                                color: blackColor, size: 20.0),
                            SizedBox(width: 10.0),
                            Icon(NewIcon.share_3x,
                                color: blackColor, size: 20.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
