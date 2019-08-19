import 'package:flutter/material.dart';

import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart';

const double _ITEM_HEIGHT = 70.0;

class PopularAccountView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PopularAccountState();
  }
}

class PopularAccountState extends State<PopularAccountView>
    with TickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  String selectedCategory = "";

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
          bloc.fetchAllLembagaAmal(selectedCategory);
        },
        tabs: <Widget>[
          new Tab(
            text: 'Semua Kategori',
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
          )
        ],
        controller: _tabController,
      ),
    );
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: new Icon(Icons.arrow_back, color: Colors.grey[600]),
          actions: <Widget>[
            SizedBox(
              width: 5.0,
            ),
            SizedBox(
              width: 0.0,
            ),
            Icon(
              AppBarIcons.ic_action,
              color: Colors.white,
            ),
            SizedBox(
              width: 5.0,
            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: true,
          titleSpacing: 0.0,
          title: Container(
            child: TextFormField(
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  top: 7.0,
                  bottom: 7.0,
                  left: -15.0,
                ),
                icon: Icon(
                  Icons.search,
                  size: 18.0,
                ),
                border: InputBorder.none,
                hintText: 'Cari lembaga amal atau produk lainnya',
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  30.0,
                ),
              ),
              color: Colors.grey[200],
            ),
            padding: EdgeInsets.fromLTRB(
              15.0,
              0.5,
              15.0,
              0.5,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(
          47.0,
        ),
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
                  if (snapshot.hasData) {
                    return buildListLembagaAmal(snapshot);
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListLembagaAmal(AsyncSnapshot<List<LembagaAmalModel>> snapshot) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0),
      itemBuilder: (context, index) {
        var value = snapshot.data[index];
        return Container(
          margin: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 0.0),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0)),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(2.0, 10.0, 10.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: (value.imageContent == null)
                              ? NetworkImage(
                                  'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg')
                              : NetworkImage(value.imageContent[0].imgUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          value.lembagaAmalName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          '${value.totalFollowers} Pengikut',
                          style: TextStyle(fontSize: 11.0),
                        ),
                        Text(
                          '${value.totalPostProgramAmal} Aksi Galang Amal',
                          style: TextStyle(fontSize: 11.0),
                        ),
                        Text(
                          '${value.totalPostBerita} Berita',
                          style: TextStyle(fontSize: 11.0),
                        ),
                      ],
                    ),
                  ],
                ),
                (value.followThisAccount)
                    ? buttonUnfollow(value.idLembagaAmal)
                    : buttonFollow(value.idLembagaAmal),
              ],
            ),
          ),
        );
      },
      itemCount: snapshot.data.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }

  Widget buttonFollow(String idAccount) {
    return RaisedButton(
      onPressed: () async {
        await bloc.followAccount(idAccount);
        await Future.delayed(Duration(milliseconds: 3));
        setState(() async {
          await bloc.fetchAllLembagaAmal(selectedCategory);
        });
      },
      color: Color.fromRGBO(21, 101, 192, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Text(
          'Follow',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buttonUnfollow(String idAccountAmil) {
    return RaisedButton(
      onPressed: () {
        setState(() async {
          bloc.unfollow(idAccountAmil);
          await Future.delayed(Duration(milliseconds: 3));
          bloc.fetchAllLembagaAmal(selectedCategory);
        });
      },
      color: Color.fromRGBO(165, 219, 98, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
          child: Icon(
        Icons.check,
        color: Colors.white,
      )),
    );
  }

  @override
  void initState() {
    bloc.fetchAllLembagaAmal(selectedCategory);
    _scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 8);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
