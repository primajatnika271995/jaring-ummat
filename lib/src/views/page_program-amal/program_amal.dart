import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_appbar_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';

class ProgramAmalPage extends StatefulWidget {
  @override
  _ProgramAmalPageState createState() => _ProgramAmalPageState();
}

class _ProgramAmalPageState extends State<ProgramAmalPage> {
  SharedPreferences _preferences;
  String _token;
  String selectedCategory = "";

  bool hidden = false;
  bool _loadingVisible = false;

  StoriesApiProvider _provider = new StoriesApiProvider();

  final String appbarLogo = "assets/icon/main_logo.png";

  final titleText = Text(
    'Jejaring',
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
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Image.asset(appbarLogo),
              ),
              title: titleText,
              actions: <Widget>[
                IconButton(
                  padding: EdgeInsets.only(left: 20.0),
                  icon: Icon(NewIcon.search_big_3x),
                  color: greenColor,
                  iconSize: 20.0,
                  onPressed: () {
                    print('_search_');
                  },
                ),
                IconButton(
                  padding: EdgeInsets.only(right: 10.0),
                  icon: Icon(NewIcon.chat_3x),
                  color: greenColor,
                  iconSize: 20.0,
                  onPressed: () {
                    if (_token == null) {
                      Navigator.of(context).pushNamed('/login');
                    } else {
                      Navigator.of(context).pushNamed('/list/account/chats');
                    }
                  },
                ),
              ],
            ),
            body: CustomScrollView(
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
                  elevation: 2.0,
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
                        borderSide: BorderSide(width: 4.0, color: greenColor),
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

  void checkToken() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
  }

  void hideStory() async {
    await _provider.response().then((response) {
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
}
