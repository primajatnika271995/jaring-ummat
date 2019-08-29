import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_baru_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/add_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/app_bar_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_story/createStory.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/home_page_icons_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_appbar_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramAmalPage extends StatefulWidget {
  @override
  _ProgramAmalPageState createState() => _ProgramAmalPageState();
}

class _ProgramAmalPageState extends State<ProgramAmalPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;
  Animation<double> _animation3;

  int _angle = 90;
  bool _isRotated = true;

  SharedPreferences _preferences;
  String _token;
  String selectedCategory = "";

  bool hidden = false;
  bool _loadingVisible = false;

  final String appbarLogo = "assets/icon/logo_mitra_jejaring.png";

  StoriesApiProvider _provider = new StoriesApiProvider();

  final titleText = Text(
    'Mitra Jejaring',
    style: TextStyle(
        color: Colors.black, fontSize: 22.0, fontFamily: 'Arab-Dances'),
  );

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        body: DefaultTabController(
          length: 8,
          child: Scaffold(
            backgroundColor: softGreyColor,
            appBar: AppBar(
              titleSpacing: 0.0,
              backgroundColor: whiteColor,
              elevation: 0.0,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(appbarLogo),
              ),
              title: titleText,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(AppBarIcon.location_inactive,
                        size: 20.0, color: greenColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7.0),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(NewIcon.search_big_3x,
                        size: 20.0, color: greenColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      if (_token == null) {
                        Navigator.of(context).pushNamed('/login');
                      } else {
                        Navigator.of(context).pushNamed('/list/account/chats');
                      }
                    },
                    child: Icon(NewIcon.chat_3x,
                        size: 20.0, color: greenColor),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    !hidden
                        ? new SliverAppBar(
                            automaticallyImplyLeading: false,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(100.0),
                              child: Text(''),
                            ),
                            elevation: 20.0,
                            flexibleSpace: new Scaffold(
                              backgroundColor: Colors.white,
                              body: new UserStoryAppBar(),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildListDelegate([]),
                          ),
                    new SliverAppBar(
                      backgroundColor: whiteColor,
                      elevation: 1.0,
                      automaticallyImplyLeading: false,
                      floating: true,
                      pinned: true,
                      flexibleSpace: AppBar(
                        backgroundColor: whiteColor,
                        elevation: 2.0,
                        automaticallyImplyLeading: false,
                        bottom: TabBar(
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                            borderSide:
                                BorderSide(width: 4.0, color: greenColor),
                          ),
                          labelColor: blackColor,
                          unselectedLabelColor: grayColor,
                          onTap: (int index) {
                            switch (index) {
                              case 1:
                                setState(() {
                                  selectedCategory = "Pendidikan";
                                });
                                break;
                              case 2:
                                setState(() {
                                  selectedCategory = "Kemanusiaan";
                                });
                                break;
                              case 3:
                                setState(() {
                                  selectedCategory = "Amal";
                                });
                                break;
                              case 4:
                                setState(() {
                                  selectedCategory = "Pembangunan Mesjid";
                                });
                                break;
                              case 5:
                                setState(() {
                                  selectedCategory = "Zakat";
                                });
                                break;
                              case 6:
                                setState(() {
                                  selectedCategory = "Sosial";
                                });
                                break;
                              case 7:
                                setState(() {
                                  selectedCategory = "lain-lain";
                                });
                                break;
                              default:
                                setState(() {
                                  selectedCategory = "";
                                });
                            }
                            bloc.fetchAllProgramAmal(selectedCategory);
                          },
                          tabs: <Widget>[
                            new Tab(
                              text: 'Populer',
                            ),
                            new Tab(
                              text: 'Pendidikan',
                            ),
                            new Tab(
                              text: 'Kemanusiaan',
                            ),
                            new Tab(
                              text: 'Amal',
                            ),
                            new Tab(
                              text: 'Pembangunan Masjid',
                            ),
                            new Tab(
                              text: 'Zakat',
                            ),
                            new Tab(
                              text: 'Bakti Sosial',
                            ),
                            new Tab(
                              text: 'lain-lain',
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            children: <Widget>[
                              StreamBuilder(
                                stream: bloc.allProgramAmal,
                                builder: (context,
                                    AsyncSnapshot<List<ProgramAmalModel>>
                                        snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      _loadingVisible = true;
                                      return Text('');
                                      break;
                                    default:
                                      if (snapshot.hasData) {
                                        _loadingVisible = false;
                                        return buildList(snapshot);
                                      } else if (snapshot.hasError) {
                                        return Text(snapshot.error.toString());
                                      }
                                      _loadingVisible = false;
                                      return Container(
                                        width: 500.0,
                                        margin: EdgeInsets.only(top: 30.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/icon/no-content.svg',
                                              height: 250.0,
                                            ),
                                            Text(
                                              'Oops..',
                                              style: TextStyle(
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            Text(
                                              'There\'s nothing \'ere, yet.',
                                              style: TextStyle(
                                                fontFamily: 'Proxima',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      break;
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// FloatingBar
                new Positioned(
                  bottom: 200.0,
                  right: 24.0,
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new ScaleTransition(
                          scale: _animation3,
                          alignment: FractionalOffset.center,
                          child: new Container(
                            margin: new EdgeInsets.only(right: 16.0),
                            child: new Text(
                              '',
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        new ScaleTransition(
                          scale: _animation3,
                          alignment: FractionalOffset.center,
                          child: new Material(
                            color: greenColor,
                            type: MaterialType.circle,
                            elevation: 6.0,
                            child: new GestureDetector(
                              child: new Container(
                                width: 40.0,
                                height: 40.0,
                                child: new InkWell(
                                  onTap: () {
                                    if (_angle == 45.0) {
                                      if (_token == null) {
                                        Navigator.of(context)
                                            .pushNamed('/login');
                                      } else {
                                        Navigator.of(context)
                                            .pushNamed('/create/galang-amal');
                                      }
                                    }
                                  },
                                  child: new Center(
                                    child: new Icon(
                                      AddIconInAmil.add_image,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Positioned(
                  bottom: 144.0,
                  right: 24.0,
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new ScaleTransition(
                          scale: _animation2,
                          alignment: FractionalOffset.center,
                          child: new Container(
                            margin: new EdgeInsets.only(right: 16.0),
                            child: new Text(
                              '',
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        new ScaleTransition(
                          scale: _animation2,
                          alignment: FractionalOffset.center,
                          child: new Material(
                            color: greenColor,
                            type: MaterialType.circle,
                            elevation: 6.0,
                            child: new GestureDetector(
                              child: new Container(
                                width: 40.0,
                                height: 40.0,
                                child: new InkWell(
                                  onTap: () {
                                    if (_angle == 45.0) {}
                                  },
                                  child: new Center(
                                    child: new Icon(
                                      AddIconInAmil.add_news,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Positioned(
                  bottom: 88.0,
                  right: 24.0,
                  child: new Container(
                    child: new Row(
                      children: <Widget>[
                        new ScaleTransition(
                          scale: _animation,
                          alignment: FractionalOffset.center,
                          child: new Container(
                            margin: new EdgeInsets.only(right: 16.0),
                            child: new Text(
                              '',
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        new ScaleTransition(
                          scale: _animation,
                          alignment: FractionalOffset.center,
                          child: new Material(
                            color: greenColor,
                            type: MaterialType.circle,
                            elevation: 6.0,
                            child: new GestureDetector(
                              child: new Container(
                                width: 40.0,
                                height: 40.0,
                                child: new InkWell(
                                  onTap: () {
                                    if (_angle == 45.0) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CreateStory(),
                                        ),
                                      );
                                    }
                                  },
                                  child: new Center(
                                    child: new Icon(
                                      AddIconInAmil.add_story,
                                      color: whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: new Material(
                    color: redColor,
                    type: MaterialType.circle,
                    elevation: 6.0,
                    child: new GestureDetector(
                      child: new Container(
                        width: 56.0,
                        height: 56.00,
                        child: new InkWell(
                          onTap: _rotate,
                          child: new Center(
                            child: new RotationTransition(
                              turns: new AlwaysStoppedAnimation(_angle / 360),
                              child: new Icon(
                                Icons.add,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.data[index];
        return ProgramAmalContent(
          programAmal: value,
        );
      },
    );
  }

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );

    _animation2 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.linear),
    );

    _animation3 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.8, 1.0, curve: Curves.linear),
    );
    _controller.reverse();

    bloc.fetchAllProgramAmal(selectedCategory);
    hideStory();
    checkToken();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void _rotate() {
    setState(() {
      if (_isRotated) {
        _angle = 45;
        _isRotated = false;
        _controller.forward();
      } else {
        _angle = 90;
        _isRotated = true;
        _controller.reverse();
      }
    });
  }

  void hideStory() async {
    await _provider.responses().then((response) {
      if (response.statusCode == 204) {
        setState(() {
          hidden = true;
        });
      } else {
        if (response.statusCode == 200) {
          setState(() {
            hidden = false;
          });
        }
      }
    });
  }

  void checkToken() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
  }
}
