import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';

import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/popular_account_container.dart';

class PopularAccountView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PopularAccountState();
  }
}

class PopularAccountState extends State<PopularAccountView>
    with TickerProviderStateMixin {
  ScrollController scrollController;
  TabController _tabController;

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
          new Tab(text: 'Populer'),
          new Tab(text: 'Keagamaan'),
          new Tab(text: 'Kemanusiaan'),
          new Tab(text: 'Pendidikan'),
          new Tab(text: 'Lingkungan'),
          new Tab(text: 'Kesehatan'),
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
          'Mitra Jaring',
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
                            Image.asset('assets/backgrounds/no_data_accent.png',
                                height: 250),
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
          return PopularAccountContainer(
            value: value,
            isFollow: isFollowed,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    bloc.fetchAllLembagaAmal(selectedCategory);
    scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 6);

    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
