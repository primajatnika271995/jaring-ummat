import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/services/bookmarkApi.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/share_program_amal_container.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/active_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_views.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeritaContent extends StatefulWidget {
  final BeritaModel berita;
  final bool isBookmark;
  BeritaContent({Key key, @required this.berita, this.isBookmark})
      : super(key: key);

  _BeritaContentState createState() =>
      _BeritaContentState(berita: this.berita, isBookmark: this.isBookmark);
}

class _BeritaContentState extends State<BeritaContent> {
  bool isLoved = false;

  BeritaModel berita;
  bool isBookmark;
  _BeritaContentState({this.berita, this.isBookmark});

  final String noImg =
      "http://www.sclance.com/pngs/no-image-png/no_image_png_935227.png";
  var formatter = new DateFormat('dd MMM yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BeritaViews(
                value: berita,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: imageContent(),
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
                      categoryContent(),
                      titleContent(),
                      createdContent(),
                      dateContent(),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(width: 10.0),
                            bookmarkContent(),
                            SizedBox(width: 10.0),
                            shareContent(),
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

  Widget categoryContent() {
    return Text(berita.categoryBerita, style: TextStyle(color: grayColor));
  }

  Widget titleContent() {
    return Container(
      width: MediaQuery.of(context).size.width - 180,
      child: Text(
        berita.titleBerita,
        style: TextStyle(fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget createdContent() {
    return Text(
      'oleh ${berita.createdBy}',
      style: TextStyle(color: grayColor, fontSize: 12),
    );
  }

  Widget dateContent() {
    return Text(
        formatter
            .format(
            DateTime.fromMicrosecondsSinceEpoch(berita.createdDate * 1000))
            .toString(),
        style: TextStyle(fontSize: 11));
  }

  Widget bookmarkContent() {
    return InkWell(
      onTap: () {
        if (isBookmark) {
          print('This Berita bookmarked');
          unbookmarkProgram();
          isBookmark = !isBookmark;
          setState(() {});
        } else if (!isBookmark) {
          print('This Berita unbookmarked');
          bookmarkProgram();
          isBookmark = !isBookmark;
          setState(() {});
        }
      },
      child: isBookmark ? iconBookmark() : iconUnbookmark(),
    );
  }

  Widget shareContent() {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (context) {
          return ShareProgramAmal();
        },
      ),
      child: Icon(NewIcon.share_3x, color: blackColor, size: 25.0),
    );
  }

  Widget imageContent() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, left: 10.0),
      child: Container(
        height: 110.0,
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: (berita.imageContent == null)
                  ? NetworkImage(noImg)
                  : berita.imageContent[0].resourceType == "video"
                  ? NetworkImage(berita.imageContent[0].urlThumbnail)
                  : NetworkImage(berita.imageContent[0].url),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget iconBookmark() {
    return Icon(ActiveIcon.save_active_3x, size: 25, color: greenColor);
  }

  Widget iconUnbookmark() {
    return Icon(NewIcon.save_3x, size: 25, color: blackColor);
  }

  void bookmarkProgram() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);
    BookmarkProvider bookmarkProvider = new BookmarkProvider();
    bookmarkProvider
        .bookmarkProgram(userId, berita.idBerita, 'berita')
        .then((response) {
      print('Response Bookmark Berita : ${response.statusCode}');
      if (response.statusCode == 201) {
        setState(() {
          isBookmark = true;
        });
      }
    });
  }

  void unbookmarkProgram() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);
    BookmarkProvider bookmarkProvider = new BookmarkProvider();
    bookmarkProvider
        .unbookmarkProgram(userId, berita.idBerita)
        .then((response) {
      print('Response Unbookmark Program : ${response.statusCode}');
      if (response.statusCode == 200) {
        setState(() {
          isBookmark = false;
        });
      }
    });
  }
}
