import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';
import 'components/container_profile_account.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart'
    as lembagaAmalBloc;

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

  @override
  void initState() {
    super.initState();
    lembagaAmalBloc.bloc.fetchAllLembagaAmal();
    _scrollController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 8);
  }

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
                stream: lembagaAmalBloc.bloc.allLembagaAmalList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<LembagaAmal>> snapshot) {
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

  Widget buildListLembagaAmal(AsyncSnapshot<List<LembagaAmal>> snapshot) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 8.0),
      itemBuilder: (context, index) {
        return ContainerProfileAccount(
          profileId: snapshot.data[index].id,
          name: snapshot.data[index].namaLembaga,
          totalFollowers: snapshot.data[index].totalFollow,
          totalEvents: snapshot.data[index].totalPost,
          imgIcon: snapshot.data[index].imageContent[0].imgUrl,
          isFollowed: false,
        );
      },
      itemCount: snapshot.data.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
    );
  }
}
