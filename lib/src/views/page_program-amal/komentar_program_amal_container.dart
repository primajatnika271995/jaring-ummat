import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/commentModel.dart';
import 'package:flutter_jaring_ummat/src/models/listUserLikes.dart';
import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:rubber/rubber.dart';

import 'package:flutter_jaring_ummat/src/bloc/commentBloc.dart' as commentBloc;
import 'package:flutter_jaring_ummat/src/bloc/likesBloc.dart' as likesBloc;
import 'package:shared_preferences/shared_preferences.dart';

class KomentarContainer extends StatefulWidget {
  final ProgramAmal programAmal;
  KomentarContainer({Key key, @required this.programAmal}) : super(key: key);

  @override
  _KomentarContainerState createState() => _KomentarContainerState();
}

class _KomentarContainerState extends State<KomentarContainer>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _rubberAnimationController;
  ScrollController _scrollController = ScrollController();

  SharedPreferences _preferences;
  String profilePictUrl;

  @override
  void initState() {
    commentBloc.bloc.fetchProgramAmalComment(widget.programAmal.id);
    likesBloc.bloc.fetchAllLikesUserProgramAmal(widget.programAmal.id);
    _rubberAnimationController = RubberAnimationController(
        vsync: this,
        dismissable: true,
        lowerBoundValue: AnimationControllerValue(pixel: 750),
        upperBoundValue: AnimationControllerValue(percentage: 4.5),
        duration: Duration(milliseconds: 200));

    getUserProfile();
    // TODO: implement initState
    super.initState();
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
            elevation: 10.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(36.0),
              child: new Divider(
                color: Colors.grey,
              ),
            ),
            flexibleSpace: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${widget.programAmal.totalLikes} Muzakki menyukai akun ini',
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
                  Container(
                    height: 40.0,
                    margin: EdgeInsets.only(left: 10.0),
                    child: StreamBuilder(
                      stream: likesBloc.bloc.allLikeListUserProgramAmal,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ListUserLikes>> snapshot) {
                        print(snapshot.connectionState);
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Center(
                              child: Text('Load Likes Data ...'),
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          return buildListLike(snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }

                        if (snapshot.data == null) {
                          return Container(
                            child: Center(
                              child: Text('0 People like this'),
                            ),
                          );
                        }
                      },
                    ),
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
                            Text(
                              '${widget.programAmal.totalComment} Muzakki berkomentar pada aksi ini',
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
                    stream: commentBloc.bloc.allCommentProgramAmalList,
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
            width: 40.0,
            height: 40.0,
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                image: NetworkImage(profilePictUrl),
                fit: BoxFit.cover,
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
                commentBloc.bloc.saveComment("", widget.programAmal.id);
                await Future.delayed(Duration(milliseconds: 3));
                commentBloc.bloc.fetchProgramAmalComment(widget.programAmal.id);
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

  Widget buildListLike(AsyncSnapshot<List<ListUserLikes>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 40.0,
          height: 50.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          child: CircularProfileAvatar(
            snapshot.data[index].imageProfile[0].imgUrl,
          ),
        );
      },
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
                    flex: 1,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProfileAvatar(
                        snapshot.data[index].contents[0].imgUrl,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 6,
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
                              widget.programAmal.imageContent[0]["imgUrl"],
                            ),
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
                      new Text(widget.programAmal.titleProgram,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      new Text(
                        'Oleh ' +
                            widget.programAmal.createdBy +
                            ' - ' +
                            TimeAgoService().timeAgoFormatting(
                                widget.programAmal.createdDate),
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
            color: Colors.blue,
          ),
          headerHeight: 65,
          upperLayer: contentLayer(),
          menuLayer: buttonLayer(),
          animationController: _rubberAnimationController,
        ),
      ),
    );
  }

  void getUserProfile() async {
    _preferences = await SharedPreferences.getInstance();
    this.profilePictUrl = _preferences.getString(PROFILE_PICTURE_KEY);
  }

  @override
  void dispose() {
    commentBloc.bloc.dispose();
    super.dispose();
  }
}
