import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ReturnData.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/utils/textUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita.dart';
import 'package:flutter_jaring_ummat/src/views/page_info_jaring/info_jaring_views.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/popular_account.dart';
import 'package:flutter_jaring_ummat/src/views/page_payment/payment.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_text_data.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/bloc/registerBloc.dart' as blocRegister;
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

class DonasiOnlyScreen extends StatefulWidget {
  final ProgramAmalReturn value;
  DonasiOnlyScreen({this.value});

  @override
  _DonasiOnlyScreenState createState() => _DonasiOnlyScreenState(value: this.value);
}

class _DonasiOnlyScreenState extends State<DonasiOnlyScreen> {
  ProgramAmalReturn value;
  _DonasiOnlyScreenState({this.value});

  /*
   * Location Inisialisasi
   */
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
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: DefaultTabController(
          length: _tabLength,
          initialIndex: initialTabIndex,
          child: appBar(),
        ),
      ),
    );
  }

  Widget appBar() {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(AllInOneIcon.back_small_2x),
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 20,
          color: Colors.black,
        ),
        title: Text(
          'Donasi',
          style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize),
        ),
      ),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              categoryTab(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: <Widget>[
                        StreamBuilder(
                          stream: bloc.allProgramAmal,
                          builder: (context,
                              AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  Widget categoryTab() {
    return SliverAppBar(
      backgroundColor: whiteColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      floating: false,
      pinned: true,
      flexibleSpace: SizedBox(
        height: 48,
        child: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4.0, color: greenColor),
            ),
            labelColor: blackColor,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: Colors.grey[400],
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
    );
  }

  Widget buildList(AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: new SizedBox(
            height: 10.0,
            child: new Center(
              child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.grey[200]),
            ),
          ),
        );
      },
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.data[index];
        return ProgramAmalContent(
          programAmal: value,
          bookmark: value.bookmarkThis,
          likes: value.userLikeThis,
        );
      },
    );
  }

  @override
  void initState() {
    print('init state donasi only');
//    bloc.fetchAllProgramAmal(selectedCategory);
//    hideStory();
    checkToken();
//    lokasiAmal();
    getUser();
    navigateSearhProgram(context, value);
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

  void navigateSearhProgram(BuildContext context, ProgramAmalReturn value) async {
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
}
