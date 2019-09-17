import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/app_bar_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/data_search.dart';
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
  /*
   * Shared Preferences Variable
   */
  SharedPreferences _preferences;
  String _token;

  /*
   * Variable Selected Category & Location
   */
  String selectedCategory = "";
  int _locationSelected;

  /*
   * List Category for Location
   */
  static List<String> location = [
    'Lokasi Saat Ini',
    'Lokasi Tempat Tinggal',
    'Lokasi Tempat Lahir',
  ];

  /*
   * Variable for Boolean
   */
  bool hidden = false;
  bool _loadingVisible = false;

  StoriesApiProvider _provider = new StoriesApiProvider();

  final String appbarLogo = "assets/icon/logo_muzakki_jejaring.png";

  final titleText = Text(
    'Jejaring',
    style: TextStyle(color: Colors.black),
  );

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        body: DefaultTabController(
          length: 6,
          child: Scaffold(
            backgroundColor: softGreyColor,
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: whiteColor,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(appbarLogo),
              ),
              title: titleText,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: InkWell(
                    onTap: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                    child: Icon(NewIcon.search_small_2x,
                        size: 20, color: blackColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: InkWell(
                    onTap: () {
                      checkLocation();
                    },
                    child: Icon(AppBarIcon.location_inactive,
                        size: 20, color: blackColor),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            if (_token == null) {
                              Navigator.of(context).pushNamed('/login');
                            } else {
                              Navigator.of(context)
                                  .pushNamed('/list/account/chats');
                            }
                          },
                          child: Icon(NewIcon.chat_3x,
                              size: 20, color: blackColor),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 13,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
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
                  elevation: 0.0,
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  flexibleSpace: AppBar(
                    backgroundColor: whiteColor,
                    elevation: 1.0,
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
                              selectedCategory = "";
                            });
                            break;
                          case 2:
                            setState(() {
                              selectedCategory = "Keagamaan";
                            });
                            break;
                          case 3:
                            setState(() {
                              selectedCategory = "Kemanusiaan";
                            });
                            break;
                          case 4:
                            setState(() {
                              selectedCategory = "Pendidikan";
                            });
                            break;
                          case 5:
                            setState(() {
                              selectedCategory = "Lingkungan";
                            });
                            break;
                          case 6:
                            setState(() {
                              selectedCategory = "Kesehatan";
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
                          text: 'Keagamaan',
                        ),
                        new Tab(
                          text: 'Kemanusiaan',
                        ),
                        new Tab(
                          text: 'Pendidikan',
                        ),
                        new Tab(
                          text: 'Lingkungan',
                        ),
                        new Tab(
                          text: 'Kesehatan',
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

  void checkLocation() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Container(
                    height: 470,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              iconSize: 20,
                              color: greenColor,
                              icon: Icon(NewIcon.close_2x),
                            ),
                          ],
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/backgrounds/location_accent.png'))),
                        ),
                        const Text('Pilih Lokasi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeUtils.titleSize)),
                        const Text(
                            'Dengan mimilih dan mengaktifkan lokasi ini, maka aplikasi Jejaring akan menampilkan data galang amal, akun amil dan berita disekitar lokasi terpilih.',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.center),
                        SizedBox(height: 7),
                        ListView.builder(
                          itemCount: location.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(
                                top: 3, bottom: 3, left: 55),
                            child: Container(
                              // color: Colors.pink,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _locationSelected = index;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          _locationSelected != null &&
                                                  _locationSelected == index
                                              ? greenColor
                                              : grayColor,
                                      child: Icon(Icons.check,
                                          color: whiteColor, size: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(location[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth(context),
                          padding: EdgeInsets.only(top: 10),
                          child: RaisedButton(
                            onPressed: () {
                              print(_locationSelected);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Atur Lokasi',
                                style: TextStyle(color: Colors.white)),
                            color: greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            },
          );
        });
  }
}
