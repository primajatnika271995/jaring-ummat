import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/models/commentModel.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:rubber/rubber.dart';

import 'package:flutter_jaring_ummat/src/bloc/commentBloc.dart' as commentBloc;

class KomentarContainer extends StatefulWidget {
  final Berita berita;

  KomentarContainer({Key key, @required this.berita}) : super(key: key);
  @override
  _KomentarContainerState createState() => _KomentarContainerState();
}

class _KomentarContainerState extends State<KomentarContainer>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _rubberAnimationController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    commentBloc.bloc.fetchNewsComment(widget.berita.id);
    _rubberAnimationController = RubberAnimationController(
        vsync: this,
        dismissable: true,
        lowerBoundValue: AnimationControllerValue(pixel: 750),
        upperBoundValue: AnimationControllerValue(percentage: 4.5),
        duration: Duration(milliseconds: 200));
  }

  Widget lowerLayer() {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
    );
  }

  Widget contentLayer() {
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
                              '${widget.berita.totalLikes} Muzakki menyukai akun ini',
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
                  new Divider(
                    color: Colors.grey,
                  ),
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
                              '${widget.berita.totalComment} Muzakki berkomentar pada aksi ini',
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
                  StreamBuilder(
                    stream: commentBloc.bloc.allCommentNewsList,
                    builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
                      if (snapshot.hasData) {
                        return buildListComment(snapshot);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return Container(
                        child: Center(
                          child: Text('Load Comment ...'),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 230.0,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget buttonLayer() {
    return BottomAppBar(
      child: new Container(
        height: 50.0,
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/users/orang.png"),
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: () async {
                commentBloc.bloc.saveComment(widget.berita.id, "");
                await Future.delayed(Duration(milliseconds: 3));
                commentBloc.bloc.fetchNewsComment(widget.berita.id);
              },
            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: true,
          titleSpacing: 0.0,
          title: Container(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: TextField(
                onChanged: commentBloc.bloc.updateComment,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
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
    );
  }

  Widget buildListComment(AsyncSnapshot<List<Comment>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/users/orang.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(height: 3.0),
                        Text(
                          snapshot.data[index].fullname,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          width: 270.0,
                          child: Text(
                            snapshot.data[index].komentar,
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(122, 122, 122, 1.0)),
                          ),
                        ),
                        Text(
                          TimeAgoService().timeAgoFormatting(
                              snapshot.data[index].createdDate),
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.normal,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: RubberBottomSheet(
          scrollController: _scrollController,
          lowerLayer: lowerLayer(),
          header: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: new Column(
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                widget.berita.imageContent[0]["imgUrl"]),
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
                      new Text(widget.berita.title,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      new Text(
                        'Oleh ' +
                            widget.berita.createdBy +
                            ' - ' +
                            TimeAgoService()
                                .timeAgoFormatting(widget.berita.createdDate),
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
          headerHeight: 65,
          upperLayer: contentLayer(),
          menuLayer: buttonLayer(),
          animationController: _rubberAnimationController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    commentBloc.bloc.dispose();
    super.dispose();
  }
}
