import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_views.dart';

class BeritaContent extends StatefulWidget {
  final BeritaModel berita;
  BeritaContent({Key key, @required this.berita}) : super(key: key);

  _BeritaContentState createState() => _BeritaContentState();
}

class _BeritaContentState extends State<BeritaContent> {
  final String noImg =
      "http://www.sclance.com/pngs/no-image-png/no_image_png_935227.png";

  @override
  Widget build(BuildContext context) {
    final imageWidget = Padding(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      child: Container(
        height: 120.0,
        width: 180.0,
        child: (widget.berita.imageContent == null)
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(noImg, fit: BoxFit.cover),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(widget.berita.imageContent[0].imgUrl,
                    fit: BoxFit.cover),
              ),
      ),
    );

    final infoWidget = Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 200.0,
              child: new Text(
                widget.berita.titleBerita,
                style: TextStyle(fontWeight: FontWeight.bold),
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
          children: <Widget>[
            imageWidget,
            infoWidget,
          ],
        ),
      ),
    );
  }
}
