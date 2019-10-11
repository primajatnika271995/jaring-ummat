import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';

import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/lembaga_amal/details_lembaga.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

const double _ITEM_HEIGHT = 70.0;

class PopularAccountView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PopularAccountState();
  }
}

class PopularAccountState extends State<PopularAccountView>
    with TickerProviderStateMixin {
  final String noImg =
      "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png";

  ScrollController scrollController;
  TabController _tabController;

  SharedPreferences _preferences;
  String _token;

  String selectedCategory = "";
  bool isFollowed = false;

  @override
  Widget build(BuildContext context) {
    Widget buttonsWidget = new Container(
      color: Colors.white,
      child: new TabBar(
        isScrollable: true,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 4.0, color: Colors.blueAccent),
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        onTap: (int index) {
          switch (index) {
            case 0:
              setState(() {
                selectedCategory = "";
              });
              break;
            case 1:
              setState(() {
                selectedCategory = "Keagamaan";
              });
              break;
            case 2:
              setState(() {
                selectedCategory = "Kemanusiaan";
              });
              break;
            case 3:
              setState(() {
                selectedCategory = "Pendidikan";
              });
              break;
            case 4:
              setState(() {
                selectedCategory = "Lingkungan";
              });
              break;
            case 5:
              setState(() {
                selectedCategory = "Kesehatan";
              });
              break;
            default:
              setState(() {
                selectedCategory = "";
              });
          }
          bloc.fetchAllLembagaAmal(selectedCategory);
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
        controller: _tabController,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: whiteColor,
        // leading: new Icon(NewIcon.back_big_3x, color: greenColor),
        title: const Text(
          'Mitra Jejaring',
          style: TextStyle(color: Colors.black, fontSize: SizeUtils.titleSize),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(left: 30.0),
            icon: Icon(NewIcon.search_big_3x),
            color: blackColor,
            iconSize: 25.0,
            onPressed: () {
              print('_search_');
            },
          ),
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            icon: Icon(NewIcon.account_following_3x),
            color: blackColor,
            iconSize: 25.0,
            onPressed: () {},
          ),
        ],
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: new Padding(
        padding: new EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 4.0,
        ),
        child: new Column(
          children: <Widget>[
            buttonsWidget,
            new Expanded(
              child: StreamBuilder(
                stream: bloc.allLembagaAmalList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<LembagaAmalModel>> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      Center(
                        child: CircularProgressIndicator(),
                      );
                      return Text('');
                      break;
                    default:
                      if (snapshot.hasData) {
                        Center(
                          child: CircularProgressIndicator(),
                        );
                        return buildListLembagaAmal(snapshot);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      Center(
                        child: CircularProgressIndicator(),
                      );
                      return Container(
                        width: 500.0,
                        margin: EdgeInsets.only(top: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListLembagaAmal(AsyncSnapshot<List<LembagaAmalModel>> snapshot) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.separated(
        separatorBuilder: (context, position) {
          return Padding(
            padding: EdgeInsets.only(left: 80.0),
            child: new SizedBox(
              height: 10.0,
              child: new Center(
                child: new Container(
                    margin:
                    new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                    height: 5.0,
                    color: softGreyColor),
              ),
            ),
          );
        },
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          var value = snapshot.data[index];
          isFollowed = snapshot.data[index].followThisAccount;
          return ListTile(
            onTap: () {
              print(value.lembagaAmalEmail);
              print(value.lembagaAmalName);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsLembaga(
                    value: value,
                  ),
                ),
              );
            },
            leading: Container(
              width: 55.0,
              height: 55.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: (value.imageContent == null)
                      ? NetworkImage(noImg)
                      : NetworkImage(value.imageContent),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              value.lembagaAmalName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('${value.totalFollowers} Pengikut'),
                Text('${value.totalPostProgramAmal} Galang Amal'),
              ],
            ),
            trailing: (isFollowed)
                ? buttonUnfollow(value.idLembagaAmal)
                : buttonFollow(value.idLembagaAmal),
          );
        },
      ),
    );
  }

  Widget buttonFollow(String idAccount) {
    return OutlineButton(
      onPressed: () async {
        if (_token == null) {
          Navigator.of(context).pushNamed('/login');
        } else {
          bloc.followAccount(idAccount);
          await Future.delayed(Duration(milliseconds: 1));
          bloc.fetchAllLembagaAmal(selectedCategory);
          setState(() {
            isFollowed = true;
          });
        }
      },
      color: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Text(
          'Follow',
          style:
          TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buttonUnfollow(String idAccountAmil) {
    return OutlineButton(
      borderSide: BorderSide(color: greenColor),
      onPressed: () {
        setState(() async {
          if (_token == null) {
            Navigator.of(context).pushNamed('/login');
          } else {
            bloc.unfollow(idAccountAmil);
            await Future.delayed(Duration(milliseconds: 1));
            bloc.fetchAllLembagaAmal(selectedCategory);
            setState(() {
              isFollowed = false;
            });
          }
        });
      },
      color: greenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Text(
          'Following',
          style: TextStyle(color: greenColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void initState() {
    bloc.fetchAllLembagaAmal(selectedCategory);
    scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 6);

    checkToken();
    super.initState();
  }

  void checkToken() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
