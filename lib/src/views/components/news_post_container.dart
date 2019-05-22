import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:rubber/rubber.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

// Component
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/custom_fonts.dart';
import '../../config/preferences.dart';
import '../../services/comment_service.dart';
import '../../models/comment_list_model.dart';
import '../../models/user_id_details_model.dart';

class ActivityNewsContainer extends StatefulWidget {
  final String newsId;
  final String iconImg;
  final String profileName;
  final List<dynamic> imgContent;
  final String category;
  final String title;
  final int postedAt;
  final String excerpt;

  ActivityNewsContainer(
      {this.newsId,
      this.iconImg,
      this.profileName,
      this.imgContent,
      this.category,
      this.title,
      this.postedAt = 0,
      this.excerpt});

  @override
  _ActivityNewsContainerState createState() => _ActivityNewsContainerState();
}

class _ActivityNewsContainerState extends State<ActivityNewsContainer>
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
  var _listComment = List<CommentList>();

  // Variable User Details

  String fullname;
  UserDetailsbyID detailsUser;

  // Rubber
  RubberAnimationController _controller;
  ScrollController _scrollController = ScrollController();

  Future<List<CommentList>> getListComment() async {
    await commentService.listCommentBerita(widget.newsId).then((response) {
      print("INI RESPONSE CODE ListComment ==>");
      print(response.statusCode);
      if (response.statusCode == 200) {
        Iterable list = response.data;
        setState(() {
          _listComment =
              list.map((model) => CommentList.fromJson(model)).toList();
        });

        print("INI ISI SALAH SATU KOMENTAR ==>");
        print(_listComment[0].komentar);
      }
    });
  }

  Future<void> saveKomentar() async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);
    var komentar = _controllerKomentar.text;
    var idNews = widget.newsId;
    var idProgram = '';
    var idStory = '';

    print("INI userID KEY ==>");
    print(idUser);

    print("INI newsID  ==>");
    print(idNews);

    print("INI komentar ==>");
    print(_controllerKomentar.text);

    commentService
        .saveComment(idNews, idProgram, idStory, idUser, komentar)
        .then((response) {
      print(response.statusCode);
      if (response.statusCode == 201) {
        setState(() {
          _controllerKomentar.text = '';
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

    if (widget.excerpt.length > 150) {
      lessDesc = widget.excerpt.substring(0, 150);
      moreDesc = widget.excerpt.substring(150, widget.excerpt.length);
    } else {
      lessDesc = widget.excerpt;
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
          setBottomContent()
        ],
      ),
    );
  }

  // TOP CONTENT BERITA

  Widget setTopContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 53.0,
            height: 53.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: MemoryImage(base64Decode(widget.iconImg)),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                Text(
                  'oleh ' +
                      widget.profileName +
                      ' • ' +
                      TimeAgoService().timeAgoFormatting(widget.postedAt),
                  style: TextStyle(fontSize: 12.0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CENTER CONTENT IMAGE

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

  // WIDGET FOR SHARE BERITA

  Widget setTopContentShare() {
    return Container(
      color: Colors.blueAccent,
      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 53.0,
            height: 53.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: MemoryImage(base64Decode(widget.imgContent[0])),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: Colors.white),
                ),
                Text(
                  'oleh ' +
                      widget.profileName +
                      ' - ' +
                      TimeAgoService().timeAgoFormatting(widget.postedAt),
                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                ),
              ],
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
                '0' + ' Likes',
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
            print("INI ID BERITA ==>");
            print(widget.newsId);
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
                '0' + ' Komentar',
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
            backgroundColor: Colors.transparent,
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
                  FutureBuilder(
                    future: getListComment(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Column(
                                children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                                    .map(
                                      (_) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 48.0,
                                                  height: 48.0,
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 2.0),
                                                      ),
                                                      Container(
                                                        width: 40.0,
                                                        height: 8.0,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        default:
                          return ListView.builder(
                            reverse: true,
                            itemCount: _listComment.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var comment = _listComment[index];
                              print("INI HASIL FUTURE BUILDER =>");
                              print(comment.idUser);
//                            commentService.userById(comment.idUser).then((response) {
//                              print("INI RESPONSE AMBIL DETAILS USERS BY ID");
//                              print(response.data);
//                              if (response.statusCode == 200) {
//                                setState(() {
//                                  detailsUser = UserDetailsbyID.fromJson(response.data);
//                                  print("INI NAMA NYA =>");
//                                  print(detailsUser.fullname);
//                              }
//                                );
//                                }
//                            }
//                            );
                              return Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage('https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
                                                  fit: BoxFit.contain,
                                                ),),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // SizedBox(height: 3.0),
                                              Text(
                                                comment.idUser,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(height: 3.0),
                                              Container(
                                                width: 270.0,
                                                child: Text(
                                                  comment.komentar,
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          122, 122, 122, 1.0)),
                                                ),
                                              ),
                                              Text(
                                                TimeAgoService()
                                                    .timeAgoFormatting(
                                                        comment.createdDate),
                                                style: TextStyle(
                                                    fontSize: 11.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color.fromRGBO(
                                                        122, 122, 122, 1.0)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              );
                            },
                          );
                      }
                    },
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
                  saveKomentar();
                  setState(() {
                    getListComment();
                  });
                },
              ),
            ],
            centerTitle: true,
            automaticallyImplyLeading: true,
            titleSpacing: 0.0,
            title: Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: 1.0),
                child: TextFormField(
//                      autofocus: true,
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
                                    MemoryImage(base64Decode(widget.iconImg)),
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

//  Widget modalSheetComent() {
//    showModalBottomSheet(
//      context: context,
//      builder: (context) {
//        return Container(
//          height: 500.0,
//          child: Scaffold(
//            resizeToAvoidBottomPadding: false,
//            resizeToAvoidBottomInset: false,
//            appBar: new AppBar(
//              backgroundColor: Colors.blueAccent,
//              automaticallyImplyLeading: false,
//              centerTitle: false,
//              title: new Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  new Text(
//                    widget.title,
//                    style: TextStyle(fontSize: 15.0),
//                  ),
//                  new Text(
//                    'Oleh ${widget.profileName} - ${TimeAgoService().timeAgoFormatting(widget.postedAt)}',
//                    style: TextStyle(fontSize: 11.0),
//                  )
//                ],
//              ),
//              leading: new Container(
//                color: Colors.blueAccent,
//                padding: EdgeInsets.all(1.0),
//                child: new Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Container(
//                      width: 40.0,
//                      height: 40.0,
//                      margin:
//                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(30.0),
//                        image: DecorationImage(
//                          image:
//                              MemoryImage(base64Decode(widget.imgContent[0])),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            body: ListView(
//              shrinkWrap: true,
//              children: <Widget>[
//                SizedBox(
//                  height: 10.0,
//                ),
//                Container(
//                  padding:
//                      EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          SizedBox(height: 3.0),
//                          Text(
//                            '26.116 Muzakki menyukai akun ini',
//                            style: TextStyle(
//                                fontSize: 11.0,
//                                fontWeight: FontWeight.bold,
//                                color: Color.fromRGBO(122, 122, 122, 1.0)),
//                          ),
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                SizedBox(
//                  height: 10.0,
//                ),
//                new Container(
//                  padding:
//                      EdgeInsets.only(left: 10.0, bottom: 0.0, right: 10.0),
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        width: 50.0,
//                        height: 50.0,
//                        decoration: BoxDecoration(
//                          image: DecorationImage(
//                            image: NetworkImage(
//                                'https://37e04m2dcg7asf2fw4bk96r1-wpengine.netdna-ssl.com/wp-content/uploads/2015/07/dr-arnold-profile-in-circlePS-400.png'),
//                            fit: BoxFit.contain,
//                          ),
//                        ),
//                      ),
//                      Container(
//                        width: 50.0,
//                        height: 50.0,
//                        decoration: BoxDecoration(
//                          image: DecorationImage(
//                            image: NetworkImage(
//                                'https://37e04m2dcg7asf2fw4bk96r1-wpengine.netdna-ssl.com/wp-content/uploads/2015/07/dr-arnold-profile-in-circlePS-400.png'),
//                            fit: BoxFit.contain,
//                          ),
//                        ),
//                      ),
//                      Container(
//                        width: 50.0,
//                        height: 50.0,
//                        decoration: BoxDecoration(
//                          image: DecorationImage(
//                            image: NetworkImage(
//                                'https://37e04m2dcg7asf2fw4bk96r1-wpengine.netdna-ssl.com/wp-content/uploads/2015/07/dr-arnold-profile-in-circlePS-400.png'),
//                            fit: BoxFit.contain,
//                          ),
//                        ),
//                      ),
//                      SizedBox(
//                        width: 10.0,
//                      ),
//                      GestureDetector(
//                        onTap: () {},
//                        child: new Text(
//                          'tampilkan semua',
//                          style: TextStyle(
//                              color: Colors.blueAccent, fontSize: 12.0),
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//                new Divider(),
//              ],
//            ),
//            bottomNavigationBar: BottomAppBar(
//              child: new Container(
//                height: 50.0,
//                child: AppBar(
//                  backgroundColor: Colors.white,
//                  leading: Container(
//                    width: 100.0,
//                    height: 100.0,
//                    margin: EdgeInsets.all(10.0),
//                    decoration: BoxDecoration(
//                      image: DecorationImage(
//                        image: AssetImage("assets/users/orang.png"),
////                      fit: BoxFit.contain,
//                      ),
//                    ),
//                  ),
//                  actions: <Widget>[
//                    IconButton(
//                      icon: Icon(
//                        Icons.send,
//                        color: Colors.black,
//                      ),
//                      onPressed: () {
//                        saveKomentar();
//                        setState(() {
//                          getListComment();
//                        });
//                      },
//                    ),
//                  ],
//                  centerTitle: true,
//                  automaticallyImplyLeading: false,
//                  titleSpacing: 0.0,
//                  title: Container(
//                    child: Padding(
//                      padding: EdgeInsets.only(
//                          bottom: MediaQuery.of(context).viewInsets.bottom),
//                      child: TextFormField(
//                        controller: _controllerKomentar,
////                      autofocus: true,
//                        textInputAction: TextInputAction.done,
//                        autocorrect: false,
//                        style: TextStyle(
//                          fontSize: 12.0,
//                          color: Colors.black,
//                        ),
//                        decoration: InputDecoration(
//                          contentPadding: EdgeInsets.only(
//                              top: 7.0, bottom: 7.0, left: -15.0),
//                          icon: Icon(Icons.search, size: 18.0),
//                          border: InputBorder.none,
//                          hintText: 'Tulis komentar anda disini...',
//                        ),
//                      ),
//                    ),
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                      color: Colors.grey[200],
//                    ),
//                    padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
//                  ),
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }

  Widget modalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          child: new Column(
            children: <Widget>[
              setTopContentShare(),
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

  Widget setSave() {
    return Row(
      children: <Widget>[
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
}
