import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';
import 'package:rubber/rubber.dart';
import 'package:intl/intl.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Component
import '../../services/currency_format_service.dart';
import '../../config/preferences.dart';
import '../../services/comment_service.dart';
import '../../models/user_id_details_model.dart';
import 'custom_fonts.dart';
import 'show_alert_dialog.dart';

class ActivityPostContainer extends StatefulWidget {
  final String activityPostId;
  final String idUserLike;
  final String profilePictureUrl;
  final String title;
  final String profileName;
  final int postedAt;
  final String description;
  final double totalDonation;
  final double targetDonation;
  final List<dynamic> imgContent;
  final String dueDate;
  final String totalLikes;
  final String totalComment;

  ActivityPostContainer({
    Key key,
    this.activityPostId,
    this.idUserLike,
    this.profilePictureUrl,
    this.title,
    this.description,
    this.profileName,
    this.imgContent,
    this.postedAt = 0,
    this.totalDonation = 0,
    this.targetDonation = 0,
    this.dueDate,
    this.totalLikes = "0",
    this.totalComment,
  });

  @override
  State<StatefulWidget> createState() {
    return ActivityPostState();
  }
}

class ActivityPostState extends State<ActivityPostContainer>
    with SingleTickerProviderStateMixin {
  // Picture Carousel Index
  int _current = 0;

  // Likes bool
  bool isLoved = false;

  // Flag for less & more bool
  bool flag = true;
  String lessDesc;
  String moreDesc;

  // SHared Preferences
  SharedPreferences _preferences;

  // Komentar Field Controller
  TextEditingController _controllerKomentar = new TextEditingController();

  // Service Callback
  CommentService commentService = new CommentService();
//  var _listComment = List<CommentList>();

  // Variable User Details

  String fullname;
  UserDetailsbyID detailsUser;

  // Rubber
  RubberAnimationController _controller;
  ScrollController _scrollController = ScrollController();

  final formatCurrency = new NumberFormat.simpleCurrency();

  static var tagetDonasi;
  static var totalDonasi;

//  Stream<List<CommentList>> getListComment() async* {
//    await commentService.listCommentProgram(widget.activityPostId).then((response) {
//      print("INI RESPONSE CODE ListProgram ==>");
//      print(response.statusCode);
//      if (response.statusCode == 200) {
//        Iterable list = response.data;
//        setState(() {
//          _listComment =
//              list.map((model) => CommentList.fromJson(model)).toList();
//        });
//
//        print("INI ISI SALAH SATU KOMENTAR ==>");
//        print(_listComment[0].komentar);
//      }
//    });
//  }

  Future<void> saveKomentar() async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);
    var komentar = _controllerKomentar.text;
    var idNews = '';
    var idProgram = widget.activityPostId;
    var idStory = '';

    print("INI userID KEY ==>");
    print(idUser);

    print("INI programID  ==>");
    print(idProgram);

    print("INI komentar ==>");
    print(_controllerKomentar.text);

    commentService
        .saveComment(idNews, idProgram, idStory, idUser, komentar)
        .then((response) {
      print(response.statusCode);
      if (response.statusCode == 201) {

        setState(() {
          _controllerKomentar.clear();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = RubberAnimationController(
        vsync: this,
        dismissable: true,
        lowerBoundValue: AnimationControllerValue(pixel: 650),
        upperBoundValue: AnimationControllerValue(percentage: 4.5),
        duration: Duration(milliseconds: 200));

    if (widget.description.length > 150) {
      lessDesc = widget.description.substring(0, 150);
      moreDesc = widget.description.substring(150, widget.description.length);
    } else {
      lessDesc = widget.description;
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
                    image: url == null ? AssetImage('assets/backgrounds/no_image.png') : MemoryImage(base64Decode(url)),
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

  // RUBBER LAYER

  Widget _getLowerLayer() {
    return Container(
      decoration: BoxDecoration(color: Colors.red),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            floating: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            expandedHeight: 50.0,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(56.0),
              child: Text(''),
            ),
            flexibleSpace: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
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
                    padding:
                    EdgeInsets.only(left: 10.0, bottom: 0.0, right: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: new Text(
                            'tampilkan semua',
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 12.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  new Divider(),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                  Container(
                    padding:
                    EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            Text(
                              '0 Muzakki berkomentar pada aksi ini',
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
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _getMenuLayer() {
    return Container(
      height: 50,
      child: Center(
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
                // on Send Method
                onPressed: () {
                  setState(() {
                    saveKomentar();
                  });
                },
              ),
            ],
            centerTitle: true,
            automaticallyImplyLeading: false,

            titleSpacing: 0.0,
            title: Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: 1.0),
                child: TextFormField(
                  onFieldSubmitted: (text) {
                    saveKomentar();
                  },
                  controller: _controllerKomentar,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.only(top: 7.0, bottom: 7.0, left: 4.0),
                    // icon: Icon(Icons.search, size: 18.0),
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
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  Widget modalSheetComent() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomPadding: true,
          resizeToAvoidBottomInset: true,
          body: Container(
            child: RubberBottomSheet(
              scrollController: _scrollController,
              lowerLayer: _getLowerLayer(),
              header: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: new Column(
                        children: <Widget>[
                          Container(
                            width: 40.0,
                            height: 40.0,
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                image:
                                MemoryImage(base64Decode(widget.imgContent[0])),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(widget.title,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          new Text(
                            'Oleh ' +
                                widget.profileName +
                                ' - ' +
                                TimeAgoService()
                                    .timeAgoFormatting(widget.postedAt),
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                color: Colors.blueAccent,
              ),
              headerHeight: 55,
              upperLayer: _getUpperLayer(),
              menuLayer: _getMenuLayer(),
              animationController: _controller,
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
                      width: 53.0,
                      height: 53.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image:
                              MemoryImage(base64Decode(widget.imgContent[0])),
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
                                TimeAgoService()
                                    .timeAgoFormatting(widget.postedAt),
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
                            'mencerdaskan kehidupan bangsa.'
                            'Semoga semakin banyak aksi amal semacam ini.',
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
                'Rp. ' +
                    '${CurrencyFormat().currency(widget.totalDonation)}' +
                    ' / ' +
                    '${CurrencyFormat().currency(widget.targetDonation)}',
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
              print(widget.title);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalangAmalView(
                        title: widget.title,
                        imgContent: widget.imgContent,
                        profileName: widget.profileName,
                        dueDate: widget.dueDate,
                        activityPostId: widget.activityPostId,
                        description: widget.description,
                        postedAt: widget.postedAt,
                        profilePictureUrl: widget.profilePictureUrl,
                        targetDonation: widget.targetDonation,
                        totalComment: widget.totalComment,
                        totalDonation: widget.totalDonation,
                        totalLike: widget.totalLikes,
                      ),
                ),
              );
//              Navigator.pushNamed(context, '/galang-amal');
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
                widget.totalLikes + ' Likes',
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
            print("INI ID PROGRAM AMAL ==>");
            print(widget.activityPostId);
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
