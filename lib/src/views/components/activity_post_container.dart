import 'package:bottom_sheet_stateful/bottom_sheet_stateful.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'custom_fonts.dart';
import 'dart:convert';
import 'show_alert_dialog.dart';
import 'package:intl/intl.dart';
import '../../services/currency_format_service.dart';

class ActivityPostContainer extends StatefulWidget {
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

  ActivityPostContainer({
    Key key,
    this.activityPostId,
    this.profilePictureUrl,
    this.title,
    this.description,
    this.profileName,
    this.imgContent,
    this.postedAt = 0,
    this.totalDonation = 0.0,
    this.targetDonation = 0.0,
    this.dueDate,
    this.totalLike,
    this.totalComment,
  });

  @override
  State<StatefulWidget> createState() {
    return ActivityPostState();
  }
}

class ActivityPostState extends State<ActivityPostContainer> {

  final List<String> imgList = [
    'https://kitabisa-userupload-01.s3-ap-southeast-1.amazonaws.com/_production/campaign/25635/31_25635_1492972987_931779_f.png',
    'http://images1.prokal.co/websampit/files/berita/2015/12/11/pembangunan-masjid-raya-seranau-lewati-target.jpg',
  ];

  bool isLoved = false;
  bool flag = true;

  String lessDesc;
  String moreDesc;

  final formatCurrency = new NumberFormat.simpleCurrency();

  BSAttribute _bsAttribute;

  static var tagetDonasi;
  static var totalDonasi;

  @override
  void initState() {
    super.initState();

    _bsAttribute = BSAttribute();

    if (widget.description.length > 150) {
      lessDesc = widget.description.substring(0, 150);
      moreDesc = widget.description.substring(150, widget.description.length);
    } else {
      lessDesc = widget.description;
      moreDesc = "";
    }

  }

  void _bsCallback(double width, double height) {
    print(
        "bs1 callback-> width: ${width.toString()}, height: ${height.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: setTopContent(),
          ),
          setMainImage(),
          setDescription(),
          setContent(),
          new Divider(),
          setBottomContent(),
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

  Widget getLikesMessageProfile(var img) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(img),
        fit: BoxFit.contain,
      )),
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
            'Oleh ' + widget.profileName + ' • ' + TimeAgoService().timeAgoFormatting(widget.postedAt),
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

  Widget modalSheetComent() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          appBar: new AppBar(
            backgroundColor: Colors.blueAccent,
            centerTitle: false,
            title: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  'Bantuan Dana Pendidikan Siswa SD Tunas',
                  style: TextStyle(fontSize: 15.0),
                ),
                new Text(
                  'Oleh Bamuis BNI - 30 menit yang lalu',
                  style: TextStyle(fontSize: 11.0),
                )
              ],
            ),
            leading: new Container(
              color: Colors.blueAccent,
              padding: EdgeInsets.all(1.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: (widget.profilePictureUrl != '')
                            ? NetworkImage(widget.profilePictureUrl)
                            : AssetImage("assets/users/bamuis_min.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 3.0),
                        Text(
                          '26.116 Muzakki menyukai akun ini',
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              new Container(
                padding: EdgeInsets.only(left: 10.0, bottom: 0.0, right: 10.0),
                child: Row(
                  children: <Widget>[
                    getLikesMessageProfile(
                        'https://www.iphonesavvy.com/sites/default/files/%5Bcurrent-date%3Afile_path%5D/jan-profile-circle.png'),
                    getLikesMessageProfile(
                        'https://37e04m2dcg7asf2fw4bk96r1-wpengine.netdna-ssl.com/wp-content/uploads/2015/07/dr-arnold-profile-in-circlePS-400.png'),
                    getLikesMessageProfile(
                        'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
                    getLikesMessageProfile(
                        'https://joinyena.com/wp-content/uploads/2018/01/profile-circle.png'),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: new Text(
                        'tampilkan semua',
                        style:
                        TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                      ),
                    )
                  ],
                ),
              ),
              new Divider(),
              Container(
                padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 3.0),
                        Text(
                          '8.127 Muzakki berkomentar pada aksi ini',
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                  ],
                ),
              ),
              setParticipan('Abdul R Arraisi',
                  'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
              SizedBox(
                height: 10.0,
              ),
              setParticipan('Rika Amalia Puteri',
                  'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
              SizedBox(
                height: 10.0,
              ),
              setParticipan('Nanra Sukedy',
                  'https://joinyena.com/wp-content/uploads/2018/01/profile-circle.png'),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: new Container(
              height: 50.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/users/orang.png"),
//                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                    onPressed: () => {},
                  ),
                ],
                centerTitle: true,
                automaticallyImplyLeading: true,
                titleSpacing: 0.0,
                title: Container(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextFormField(
//                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.only(top: 7.0, bottom: 7.0, left: -15.0),
                        icon: Icon(Icons.search, size: 18.0),
                        border: InputBorder.none,
                        hintText: 'Tulis komentar anda disini...',
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: Colors.grey[200],
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget modalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          child: new Column(
            children: <Widget>[
              new Container(
                color: Colors.blueAccent,
                padding: EdgeInsets.all(10.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: (widget.profilePictureUrl != '')
                              ? NetworkImage(widget.profilePictureUrl)
                              : AssetImage("assets/users/bamuis_min.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                            ),
                          ),
                          Text(
                            'Oleh ' +
                                widget.profileName +
                                ' - ' +
                                TimeAgoService().timeAgoFormatting(widget.postedAt),
                            style:
                                TextStyle(fontSize: 11.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget setParticipan(var name, var profilePict) {
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
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 10.0, bottom: 0.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(profilePict),
                        fit: BoxFit.contain,
                      )),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(height: 3.0),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          width: 270.0,
                          child: Text(
                            'Beramal dibidang pendidikan berarti kita ikut '
                                'mencerdaskan kehidupan bangsa. Semoga '
                                'semakin banyak aksi amal semacam ini.',
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(122, 122, 122, 1.0)),
                          ),
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
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
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
            textAlign: TextAlign.center,
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
                'Rp. ' + '${CurrencyFormat().currency(widget.totalDonation)}' + ' / ' + '${CurrencyFormat().currency(widget.targetDonation)}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                'Batas waktu ' + widget.dueDate,
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(122, 122, 122, 1.0)),
              )
            ],
          ),
          RaisedButton(
            onPressed: () {
              print(widget.activityPostId);
              Navigator.pushNamed(context, '/galang-amal');
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
                widget.totalLike + ' Likes',
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
            modalSheetComent();
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
                widget.totalComment + ' Komentar',
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
}
