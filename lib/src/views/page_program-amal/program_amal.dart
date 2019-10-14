import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ReturnData.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/utils/textUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/app_bar_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/grid_menu_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/lembaga_amal/popular_account.dart';
import 'package:flutter_jaring_ummat/src/views/page_inbox/inbox.dart';
import 'package:flutter_jaring_ummat/src/views/page_info_jaring/info_jaring_views.dart';
import 'package:flutter_jaring_ummat/src/views/page_payment/payment.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_text_data.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/bloc/registerBloc.dart'
    as blocRegister;
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_appbar_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/search_program_amal.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramAmalPage extends StatefulWidget {
  @override
  _ProgramAmalPageState createState() => _ProgramAmalPageState();
}

class _ProgramAmalPageState extends State<ProgramAmalPage> {
  /// Location Inisialisasi
  var location = new Location();

  /*
   * Variable Temp Token
   */
  String _token;

  /*
   * Variable Selected Category & Location
   */
  String selectedCategory = "";
  String _locationSelected;
  int initialTabIndex = 0;
  bool _isFilter = false;

  /*
   * Variable Boolean
   */
  bool hidden = false;
  bool _loadingVisible = false;

  /*
   * Variable Temp
   */
  String emailCustomer;
  String customerName;
  String customerPhone;

  /*
   * Api Provider
   */
  StoriesApiProvider _provider = new StoriesApiProvider();

  /*
   * Tab Controller
   */
  int _tabLength = 6;

  @override
  Widget build(BuildContext context) {
    // Title Text
    final titleText = Text('Jejaring',
        style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize));

    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: DefaultTabController(
          length: _tabLength,
          initialIndex: initialTabIndex,
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: whiteColor,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(ProgramAmalTextData.logoApp),
              ),
              title: titleText,
              actions: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: InkWell(
                          onTap: () {
                            if (_isFilter) {
                              hapusFilterLokasi();
                            } else {
                              checkLocation();
                            }
                          },
                          child: Icon(
                            _isFilter
                                ? AppBarIcon.location_inactive
                                : AppBarIcon.location_inactive,
                            size: 25,
                            color: blackColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 5,
                      top: 13,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: _isFilter ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: _isFilter
                            ? Icon(
                                Icons.check,
                                color: whiteColor,
                                size: 10.0,
                              )
                            : Icon(
                                Icons.close,
                                color: whiteColor,
                                size: 10.0,
                              ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Inbox(),
                        ),
                      );
                    },
                    child: Icon(
                      NewIcon.nav_inbox_3x,
                      size: 25,
                      color: blackColor,
                    ),
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
                              }
                              Navigator.of(context)
                                  .pushNamed('/list/account/chats');
                            },
                            child: Icon(NewIcon.chat_3x,
                                size: 25, color: blackColor)),
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
            body: Stack(
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    !hidden
                        ? new SliverAppBar(
                            automaticallyImplyLeading: false,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(60.0),
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
                    SliverAppBar(
                      backgroundColor: whiteColor,
                      elevation: 0,
                      floating: true,
                      pinned: true,
                      expandedHeight: 20,
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(90),
                        child: Container(
                          height: 90.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PopularAccountView(),
                                            ),
                                          );
                                        },
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.yellow[600],
                                              border: Border.all(
                                                  color: softGreyColor,
                                                  width: 3.0),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(20.0))),
                                          padding: EdgeInsets.all(12.0),
                                          child: new Icon(
                                            AllInOneIcon.account_following_3x,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(top: 1.0),
                                      ),
                                      new Text('Akun Mitra')
                                    ],
                                  ),
                                ),
                                Container(
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          requestBill("donasi");
                                        },
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.blue,
                                              border: Border.all(
                                                  color: softGreyColor,
                                                  width: 3.0),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(20.0))),
                                          padding: EdgeInsets.all(12.0),
                                          child: new Icon(
                                            GridMenuIcon.donation_new,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(top: 1.0),
                                      ),
                                      new Text('Donasi')
                                    ],
                                  ),
                                ),
                                Container(
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          requestBill("Zakat");
                                        },
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.red,
                                              border: Border.all(
                                                  color: softGreyColor,
                                                  width: 3.0),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(20.0))),
                                          padding: EdgeInsets.all(12.0),
                                          child: new Icon(
                                            GridMenuIcon.zakat_new,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(top: 1.0),
                                      ),
                                      new Text('Zakat')
                                    ],
                                  ),
                                ),
                                Container(
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          requestBill("infaq");
                                        },
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.deepPurple,
                                              border: Border.all(
                                                  color: softGreyColor,
                                                  width: 3.0),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(20.0))),
                                          padding: EdgeInsets.all(12.0),
                                          child: new Icon(
                                            GridMenuIcon.infaq_new,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(top: 1.0),
                                      ),
                                      new Text('Infaq')
                                    ],
                                  ),
                                ),
                                Container(
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          requestBill("sodaqoh");
                                        },
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.green,
                                              border: Border.all(
                                                  color: softGreyColor,
                                                  width: 3.0),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(20.0))),
                                          padding: EdgeInsets.all(12.0),
                                          child: new Icon(
                                            GridMenuIcon.sodaqoh_new,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(top: 1.0),
                                      ),
                                      new Text('Sodaqoh')
                                    ],
                                  ),
                                ),
                                Container(
                                  child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          requestBill("Wakaf");
                                        },
                                        child: new Container(
                                          decoration: new BoxDecoration(
                                              color: Colors.deepOrangeAccent,
                                              border: Border.all(
                                                  color: softGreyColor,
                                                  width: 3.0),
                                              borderRadius: new BorderRadius
                                                      .all(
                                                  new Radius.circular(20.0))),
                                          padding: EdgeInsets.all(12.0),
                                          child: new Icon(
                                            GridMenuIcon.wakaf_new,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                      new Padding(
                                        padding: EdgeInsets.only(top: 1.0),
                                      ),
                                      new Text('Wakaf')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(190.0),
                        child: Text(''),
                      ),
                      elevation: 20.0,
                      flexibleSpace: new Scaffold(
                        backgroundColor: Colors.white,
                        body: Padding(
                          padding: EdgeInsets.only(
                              left: 13.0, right: 13.0, top: 7.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Info Jaring',
                                      style: TextStyle(
                                          color: blackColor,
                                          fontSize: SizeUtils.titleSize)),
                                  Icon(AllInOneIcon.next_small_2x, size: 20)
                                ],
                              ),
                              Container(
                                height: 200,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: listInfoJaring.length,
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return bantuKamiMain(index);
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    new SliverAppBar(
                      backgroundColor: whiteColor,
                      elevation: 1.0,
                      automaticallyImplyLeading: false,
                      floating: false,
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
                            print(index);
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
//                                      _loadingVisible = true;
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
                                        width: screenWidth(context),
                                        color: whiteColor,
                                        margin: EdgeInsets.only(top: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                                'assets/backgrounds/no_data_accent.png',
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
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
          bookmark: value.bookmarkThis,
        );
      },
    );
  }

  @override
  void initState() {
    bloc.fetchAllProgramAmal(selectedCategory);
    hideStory();
    checkToken();
    lokasiAmal();
    getUser();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void _getCurrLocation() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var currentLocation = await location.getLocation();
    print(currentLocation.latitude);
    print(currentLocation.longitude);

    final coordinate =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var data = await Geocoder.local.findAddressesFromCoordinates(coordinate);
    print(data.first.addressLine);
    setState(() {
      _pref.setString(CURRENT_LOCATION_CITY, data.first.subAdminArea);
      _pref.setString(CURRENT_LOCATION_PROVINSI, data.first.adminArea);
    });
    print("Get Current Location");
    print(data.first.subAdminArea);
    print(data.first.adminArea);
  }

  void hideStory() async {
    await _provider.hideOrShow().then((response) {
      if (response.statusCode == 204) {
        hidden = true;
        setState(() {});
      } else {
        if (response.statusCode == 200) {
          hidden = false;
          setState(() {});
        }
      }
    });
  }

  void checkToken() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    setState(() {
      _token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
  }

  Future<void> checkLocation() async {
    /// Untuk Pengecekan Memilih Filter Atau Tidak, Jika Tidak Check List Di Hapus
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var filter = _pref.getString(FILTER_PROGRAM_AMAL);
    print("Filter Tidak");
    print(filter);
    if (filter == null || filter == "false") {
      blocRegister.bloc.updateLokasiAmal(null);
      setState(() {
        _locationSelected = null;
      });
    }
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
                    height: 510,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                hapusFilterLokasi();
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: const Text(
                              'Dengan mimilih dan mengaktifkan lokasi ini, maka aplikasi Jejaring akan menampilkan data galang amal, akun amil dan berita disekitar lokasi terpilih.',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 7),
                        ListView.builder(
                          itemCount: ProgramAmalTextData.location.length,
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
                                        _locationSelected = ProgramAmalTextData
                                            .locationValue[index];
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          _locationSelected != null &&
                                                  _locationSelected ==
                                                      ProgramAmalTextData
                                                          .locationValue[index]
                                              ? greenColor
                                              : grayColor,
                                      child: Icon(Icons.check,
                                          color: whiteColor, size: 15),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(ProgramAmalTextData.location[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Container(
                            width: screenWidth(context),
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: OutlineButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                cariLokasiLain();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text('Cari Lokasi Lain',
                                  style: TextStyle(color: Colors.deepPurple)),
                              color: grayColor,
                              borderSide:
                                  BorderSide(width: 2, color: Colors.grey[200]),
                            )),
                        Container(
                          width: screenWidth(context),
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_locationSelected == 'SEKARANG') {
                                _getCurrLocation();
                              }
                              filtered();
                              blocRegister.bloc
                                  .updateLokasiAmal(_locationSelected);
                              print(_locationSelected);
                              bloc.fetchAllProgramAmal(selectedCategory);
                              _pref.setString(LOKASI_AMAL, _locationSelected);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Atur Lokasi',
                                style: TextStyle(color: Colors.white)),
                            color: greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        )
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

  void hapusFilterLokasi() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      _locationSelected = null;
      _isFilter = false;
    });
    noFilter();
    blocRegister.bloc.updateLokasiAmal(_locationSelected);
    print(_locationSelected);
    bloc.fetchAllProgramAmal(selectedCategory);
    _pref.setString(LOKASI_AMAL, _locationSelected);
  }

  void getUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      emailCustomer = _pref.getString(EMAIL_KEY);
      customerName = _pref.getString(FULLNAME_KEY);
      customerPhone = _pref.getString(CONTACT_KEY);
    });
  }

  void requestBill(String type) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentPage(
        type: type,
        customerName: customerName,
        customerEmail: emailCustomer,
        customerContact: customerPhone,
        toGalangAmalName: null,
      ),
    ));
  }

  void filtered() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(FILTER_PROGRAM_AMAL, "true");
    setState(() {
      _isFilter = true;
    });
  }

  void noFilter() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(FILTER_PROGRAM_AMAL, "false");
  }

  void lokasiAmal() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    String kotaLahir = _pref.getString(KOTA_LAHIR);
    String provinsiLahir = _pref.getString(PROVINSI_LAHIR);
    String kotaTinggal = _pref.getString(KOTA_TINGGAL);
    String provinsiTinggal = _pref.getString(PROVINSI_TINGGAL);
    var filter = _pref.getString(FILTER_PROGRAM_AMAL);
    filter == 'true' ? _isFilter = true : _isFilter = false;
    print('Lokasi Kota / Provinsi : ');
    print('Kota Lahir: $kotaLahir, Provinsi Lahir: $provinsiLahir');
    print('Kota Tinggal: $kotaTinggal, Provinsi Tinggal: $provinsiTinggal');
    setState(() {
      _locationSelected = _pref.getString(LOKASI_AMAL);
    });
    print("Lokasi Selected $_locationSelected");
  }

  void cariLokasiLain() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => SearchProgramAmal(),
      ),
    )
        .then((value) {
      navigateSearhProgram(context, value);
    });
  }

  void navigateSearhProgram(
      BuildContext context, ProgramAmalReturn value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print("Value ${value.lokasi}");
    setState(() {
      _pref.setString(CURRENT_LOCATION_CITY, value.lokasi);
      _pref.setString(CURRENT_LOCATION_PROVINSI, value.lokasi);
      _locationSelected = null;
      selectedCategory = "";
      initialTabIndex = 1;
      _isFilter = true;
    });
    filtered();
    bloc.fetchAllProgramAmal(selectedCategory);
  }

  Widget bantuKamiMain(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InfoJaringViews(
                valIndex: index,
              ),
            ),
          );
        },
        child: Container(
          height: 200,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(listInfoJaring[index].imageUrl),
                fit: BoxFit.cover),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 20),
                child: Container(
                  width: 280,
                  child: Text(listInfoJaring[index].title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: whiteColor)),
                )),
          ),
        ),
      ),
    );
  }
}
