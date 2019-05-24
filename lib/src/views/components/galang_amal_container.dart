import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_jaring_ummat/src/views/components/custom_fonts.dart';
import 'package:flutter_jaring_ummat/src/views/components/show_alert_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

// Component
import '../../services/time_ago_service.dart';

class GalangAmalContainer extends StatefulWidget {
  final String activityPostId;
  final String profilePictureUrl;
  final String title;
  final String profileName;
  final int postedAt;
  final String description;
  final double totalDonation;
  final double targetDonation;
  final List<dynamic> imgContent;
  final String dueDate;
  final String totalLike;
  final String totalComment;

  GalangAmalContainer({
    Key key,
    this.activityPostId,
    this.profilePictureUrl,
    this.title,
    this.description,
    this.profileName,
    this.imgContent,
    this.postedAt = 0,
    this.totalDonation = 0,
    this.targetDonation = 0,
    this.dueDate,
    this.totalLike,
    this.totalComment,
  });

  @override
  _GalangAmalContainerState createState() => _GalangAmalContainerState();
}

class _GalangAmalContainerState extends State<GalangAmalContainer> {
  int _current = 0;
  bool isLoved = false;
  bool flag = true;

  String description = "Pendidikan Adalah suatu hal yang penting dalam islam,"
      "kata pertama Al-Quran yang diwahyukan kepada Nabi Muhammad "
      "Shallallahu Alaihi Wasalam adalah IQRA atau baca. Dan menuntut "
      "ilmu adalah suatu kewajiban bagi umat Muslim .\n \nMelalui pendidikan "
      "diaharapkan umat muslim dapat menjadi pribadi yang tidak hanya pandai tetapi juga "
      "santun dan mulia. Dan kelak akan menjadi manusia yang bermanfaat untuk bangsa, negara "
      "dan Agamanya.";

  String lessDesc;
  String moreDesc;

  @override
  void initState() {
    super.initState();
    if (description.length > 150) {
      lessDesc = description.substring(0, 150);
      moreDesc = description.substring(150, description.length);
    } else {
      lessDesc = description;
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
//          setContent(),
          new Divider(),
          setBottomContent(),
          new Divider(),
          setTitleParticipan(),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              setParticipan(),
              SizedBox(
                height: 10.0,
              ),
              setParticipan(),
              SizedBox(
                height: 10.0,
              ),
              setParticipan(),
              SizedBox(
                height: 10.0,
              ),
              setParticipan(),
            ],
          ),
        ],
      ),
    );
  }

  Widget getProfilePicture() {
    return Container(
      width: 53.0,
      height: 53.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        image: DecorationImage(
          image: MemoryImage(base64Decode(widget.imgContent[0])),
        ),
      ),
    );
  }

  Widget getTopInformation() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          Text(
            'Oleh ' +
                widget.profileName +
                ' • ' +
                TimeAgoService().timeAgoFormatting(widget.postedAt),
            style: TextStyle(
              fontSize: 11.0,
            ),
          ),
          // Text(
          //   widget.postedAt,
          //   style: TextStyle(
          //     fontSize: 11.0,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget setTopContent() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          getProfilePicture(),
          getTopInformation(),
        ],
      ),
    );
  }

  Widget setMainImage() {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          height: 300.0,
          autoPlay: false,
          reverse: false,
          viewportFraction: 1.0,
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          items: widget.imgContent.map(
            (url) {
              return Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  child: FadeInImage(
                    image: MemoryImage(base64Decode(url)),
                    placeholder: AssetImage('assets/backgrounds/no_image.png'),
                    fit: BoxFit.cover,
                    width: double.infinity,
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
        Positioned(
          left: 10.0,
          bottom: 15.0,
          child: DotsIndicator(
            dotsCount: widget.imgContent.length,
            position: _current,
            decorator: DotsDecorator(
              spacing: const EdgeInsets.all(2.0),
            ),
          ),
        )
      ],
    );
  }

  Widget setDescription() {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: moreDesc.isEmpty
          ? new Text(lessDesc)
          : new Column(
              children: <Widget>[
                new Text(
                  flag ? (lessDesc + "...") : (lessDesc + moreDesc),
                  textAlign: TextAlign.justify,
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

  Widget setTitleParticipan() {
    return Container(
        padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 3.0),
                Text(
                  'Muzaki yang berpartisipasi dalam aksi ini',
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(122, 122, 122, 1.0)),
                ),
                SizedBox(height: 5.0),
              ],
            ),
          ],
        ));
  }

  Widget setParticipan() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: 3.0),
//              Text(
//                'Muzaki yang berpartisipasi dalam aksi ini',
//                style: TextStyle(
//                    fontSize: 11.0,
//                    fontWeight: FontWeight.bold,
//                    color: Color.fromRGBO(122, 122, 122, 1.0)),
//              ),
              SizedBox(height: 10.0),
              setDonatur()
            ],
          ),
        ],
      ),
    );
  }

  Widget setDonatur() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, bottom: 0.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 53.0,
            height: 53.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: MemoryImage(base64Decode(widget.imgContent[1])),
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: 3.0),
              Text(
                'Soleh Indrawan',
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 3.0),
              Text(
                'Semoga bermanfaat untuk adek-adek...',
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(122, 122, 122, 1.0)),
              ),
              Text(
                '19 menit yang lalu',
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(122, 122, 122, 1.0)),
              )
            ],
          ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            'Rp. ' + '120.930',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget setContent() {
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
                'Rp. ' + '4.069.830' + '/' + '25.000.000',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                'Batas waktu ' + '30 Juni 2019',
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(122, 122, 122, 1.0)),
              )
            ],
          ),
          RaisedButton(
            onPressed: () {},
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

  Widget setBottomContent() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 8.0),
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
                '${widget.totalLike}' + ' Likes',
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
            showAlertDialog(context, 'This will show view with comments');
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
                '${widget.totalComment}' + ' Komentar',
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

  Widget setSave() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showAlertDialog(context, 'This will save content');
          },
          child: Row(
            children: <Widget>[
              Icon(
                CustomFonts.bookmark,
                size: 17.0,
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            showAlertDialog(context, 'This will save content');
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
}