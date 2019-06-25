import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';

// Component
import '../views/components/icon_baru_icons.dart';
import '../views/pembayaran_zakat.dart';

class Portofolio extends StatefulWidget {
  @override
  _PortofolioState createState() => _PortofolioState();
}

class _PortofolioState extends State<Portofolio> with TickerProviderStateMixin {
  final List<charts.Series> periodDonation = _periodDonation();
  final List<charts.Series> higestDonation = _higestDonation();
  final List<charts.Series> seriesList = _createSampleData();

  AnimationController _controller;

  List<String> _metodePembayaran = [
    'BNI Syariah Virtual Account',
  ];

  bool visibilityInformation = false;

  String _selectedPembayaran; // Option 2

  static const List<IconData> icons = const [
    IconBaru.wakaf_small,
    IconBaru.shodaqoh_small,
    IconBaru.infaq_small,
    IconBaru.zakat_small,
    IconBaru.donation_small
  ];

  static const List<Color> bgColor = const [
    Colors.orange,
    Colors.redAccent,
    Colors.blue,
    Colors.deepOrange,
    Colors.deepPurpleAccent,
  ];

  bool isSelected;

  final List<String> _listTitleCategories = [
    "Semua Kategori",
    "Donasi",
    "Zakat",
    "Kemanusiaan"
  ];

  final List<String> _listTotalPrice = [
    "2.506.118",
    "1.861.012",
    "5.320.167",
    "4.332.761"
  ];

  int _selectedIndex = 0;

  Map<String, double> dataMap = new Map();

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "info") {
        visibilityInformation = visibility;
      }
    });
  }

  TextEditingController nominalZakat = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    dataMap.putIfAbsent("Flutter", () => 5);
    dataMap.putIfAbsent("React", () => 3);
    dataMap.putIfAbsent("Xamarin", () => 2);
    dataMap.putIfAbsent("Ionic", () => 2);
  }

  Widget tambahZakat(BuildContext context, String title, IconData icon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          backgroundColor: Colors.grey[100],
          title: new Center(
            child: Icon(
              icon,
              size: 45.0,
              color: Colors.deepPurpleAccent,
            ),
          ),
          content: SingleChildScrollView(
            child: Container(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text(
                    'Tambah ${title}',
                    style:
                        TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    'Masukkan langsung nominal ${title} atau hitung dulu kewajiban ${title} disini!',
                    style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: TextFormField(
                      controller: nominalZakat,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nominal *',
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    height: 40.0,
                    padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        child: DropdownButton(
                          elevation: 4,
                          isDense: true,
                          iconSize: 15.0,
                          isExpanded: true,
                          hint: Text(
                            'Metode Pembayaran *',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black54),
                          ), // Not necessary for Option 1
                          value: _selectedPembayaran,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedPembayaran = newValue;
                              _changed(true, "info");
                            });
                          },
                          items: _metodePembayaran.map((location) {
                            return DropdownMenuItem(
                              child: new Text(
                                location,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                ),
                              ),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  visibilityInformation
                      ? new Container(
                          child: new Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              new Divider(),
                              SizedBox(
                                height: 10.0,
                              ),
                              new Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: new Text(
                                      '•',
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: new Text(
                                      'Pembayaran dengan BNI Virtual Account sebelumya akan terganti dengan pembayaran terakhir pada zakat ini.',
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              new Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: new Text(
                                      '•',
                                      style: TextStyle(
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: new Text(
                                      'Anda akan mendapatkan Kode Virtual Account setelah klik tombol "Bayar".',
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              new Divider(),
                              RaisedButton(
                                onPressed: () {
                                  print("ON TAP Pembayaran Zakat");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PembayaranZakat(
                                            title: title,
                                            icon: icon,
                                            nominal: nominalZakat.text,
                                          ),
                                    ),
                                  );
                                },
                                color: Color.fromRGBO(21, 101, 192, 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  child: Text(
                                    'Bayar',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : new Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _fabMiniMenuItemList = [
      new FabMiniMenuItem.withText(
          new Icon(IconBaru.wakaf_small), Colors.orange, 10.0, "Wakaf Menu",
          () {
        tambahZakat(context, 'Wakaf', IconBaru.wakaf_small);
      }, "Wakaf", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(new Icon(IconBaru.shodaqoh_small),
          Colors.redAccent, 10.0, "Shodaqoh Menu", () {
        tambahZakat(context, 'Shodaqoh', IconBaru.shodaqoh_small);
      }, "Shodaqoh", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(new Icon(IconBaru.infaq_small), Colors.blue,
          10.0, "Infaq Menu", () {}, "Infaq", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(new Icon(IconBaru.zakat_small),
          Colors.orangeAccent, 10.0, "Zakat Menu", () {
        tambahZakat(context, 'Zakat', IconBaru.zakat_small);
      }, "Zakat", Colors.black, Colors.white, true),
      new FabMiniMenuItem.withText(new Icon(IconBaru.donation_small),
          Colors.deepPurpleAccent, 10.0, "Donasi Menu", () {
        tambahZakat(context, 'Donasi', IconBaru.donation_small);
      }, "Donasi", Colors.black, Colors.white, true),
    ];

    Widget categoryDonation(category, total) {
      return Card(
        color: Colors.grey[200],
        child: Container(
          width: 125.0,
          padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      category,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    Text(
                      total,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black87),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget leftSection() {
      return new Container(
        child: new CircleAvatar(
//      backgroundImage: new NetworkImage(url),
          backgroundColor: Colors.transparent,
          child: Material(
            elevation: 0.0,
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                IconBaru.scan_qr,
                color: Colors.black,
              ),
            ),
          ),
          radius: 24.0,
        ),
      );
    }

    Widget middleSection() {
      return Container(
          width: 130,
          padding: new EdgeInsets.only(left: 8.0),
          child: new Row(
            children: <Widget>[
              new Icon(
                IconBaru.wallet,
                color: Colors.deepPurple,
              ),
              SizedBox(
                width: 6.0,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Saldo jaring Umat',
                    style: new TextStyle(
                        color: Colors.black87,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  new Text(
                    'Rp 120.930',
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ));
    }

    Widget rightSection() {
      return Container(
          width: 130,
          padding: new EdgeInsets.only(left: 8.0),
          child: new Row(
            children: <Widget>[
              new Icon(
                IconBaru.reward_point,
                color: Colors.orange,
              ),
              SizedBox(
                width: 6.0,
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Point Amal',
                    style: new TextStyle(
                        color: Colors.black87,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  new Text(
                    'Rp 59.430',
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ));
    }

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(47.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: new Text(
              'Portofolio Tahun 2019',
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Setting Menu Under Development'),
                  ));
                },
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[600],
                ),
              )
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
                elevation: 1.0,
                automaticallyImplyLeading: false,
                flexibleSpace: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: new Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    color: Colors.white,
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: leftSection(),
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                        ),
                        Expanded(
                          flex: 4,
                          child: middleSection(),
                        ),
                        VerticalDivider(
                          color: Colors.grey,
                        ),
                        Expanded(
                          flex: 4,
                          child: rightSection(),
                        ),
                      ],
                    ),
                  ),
                )),
            new SliverAppBar(
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(160.0),
                child: Text(''),
              ),
              elevation: 0.0,
              flexibleSpace: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                flexibleSpace: new Container(
                  child: new Container(
                    child: Container(
                      padding: EdgeInsets.only(right: 50.0),
                      child: charts.PieChart(
                        seriesList,
                        behaviors: [
                          new charts.DatumLegend(
                            position: charts.BehaviorPosition.end,
                            outsideJustification:
                                charts.OutsideJustification.startDrawArea,
                            horizontalFirst: false,
                            desiredMaxRows: 5,
                            cellPadding: new EdgeInsets.only(
                                right: 4.0, bottom: 20.0, top: 7.0),
                          ),
                        ],
                        defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 30,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside)
                            ]),
                        animate: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            new SliverAppBar(
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(40.0),
                  child: Text(''),
                ),
                elevation: 0.0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                floating: false,
                pinned: true,
                flexibleSpace: PreferredSize(
                    child: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      flexibleSpace: Container(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _listTitleCategories.length,
                          itemBuilder: (context, index) => new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _onSelected(index);
                                    },
                                    child: Card(
                                      color: _selectedIndex != null &&
                                              _selectedIndex == index
                                          ? Colors.lightBlueAccent
                                          : Colors.grey[200],
                                      child: Container(
                                        width: 125.0,
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0.0, 10, 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    _listTitleCategories[index],
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: _selectedIndex !=
                                                                    null &&
                                                                _selectedIndex ==
                                                                    index
                                                            ? Colors.white
                                                            : Colors.grey),
                                                  ),
                                                  Text(
                                                    _listTotalPrice[index],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.0,
                                                        color: _selectedIndex !=
                                                                    null &&
                                                                _selectedIndex ==
                                                                    index
                                                            ? Colors.white
                                                            : Colors.black87),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      ),
                    ),
                    preferredSize: Size.fromHeight(100.0))),
            new SliverList(
              delegate: SliverChildListDelegate([
                new Column(
                  children: <Widget>[_buildListItem()],
                )
              ]),
            )
          ],
        ),
        floatingActionButton: new Stack(
          children: <Widget>[
            new Container(
              child: new FabDialer(_fabMiniMenuItemList, Colors.lightGreen,
                  new Icon(IconBaru.add_donation_zakat_etc)),
            )
          ],
        ));
  }

  Widget setParticipan(var img, var title, var total, var price) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
      padding:
          EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0, top: 10.0),
      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(img),
//                fit: BoxFit.contain,
              )),
            ),
          ),
//          SizedBox(
//            width: 10.0,
//          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: 3.0),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 3.0),
//                        Text(
//                          'Semoga bermanfaat untuk adek-adek...',
//                          style: TextStyle(
//                              fontSize: 11.0,
//                              fontWeight: FontWeight.bold,
//                              color: Color.fromRGBO(122, 122, 122, 1.0)),
//                        ),
                Text(
                  total,
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(122, 122, 122, 1.0)),
                )
              ],
            ),
          ),
//          SizedBox(
//            width: 115.0,
//          ),
          Expanded(
            flex: 3,
            child: Text(
              'Rp. ' + price,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget setAktivitasAmal(Icon icon, var img, var title, var total, var price) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
      padding:
          EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0, top: 10.0),
      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 3,
              child: new Row(
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    child: icon,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(img),
//                fit: BoxFit.contain,
                    )),
                  ),
                ],
              )),
//          SizedBox(
//            width: 10.0,
//          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: 3.0),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 3.0),
//                        Text(
//                          'Semoga bermanfaat untuk adek-adek...',
//                          style: TextStyle(
//                              fontSize: 11.0,
//                              fontWeight: FontWeight.bold,
//                              color: Color.fromRGBO(122, 122, 122, 1.0)),
//                        ),
                Text(
                  total,
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(122, 122, 122, 1.0)),
                )
              ],
            ),
          ),
//          SizedBox(
//            width: 115.0,
//          ),
          Expanded(
            flex: 3,
            child: Text(
              'Rp. ' + price,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem() {
    return Column(
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
          itemBuilder: (context, index) {
            return new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Donasi Terkumpul per periode",
                    style: TextStyle(fontSize: 12)),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: 170,
                    child:
                        charts.TimeSeriesChart(periodDonation, animate: false)),
                SizedBox(
                  height: 10.0,
                ),
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "3 Besar Aktivitas Amal Pada Amil",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10.0,
                ),
                setParticipan('assets/users/bamuis-bni.png', 'Bamuis BNI',
                    '24 Aktivitas', '1.201.498'),
                SizedBox(
                  height: 10.0,
                ),
                setParticipan('assets/users/dewan-dakwah.png', 'Dewan Da\'wah',
                    '9 Aktivitas', '1.019.024'),
                SizedBox(
                  height: 10.0,
                ),
                setParticipan('assets/users/logo yayasan.png',
                    'Yayasan  Hasanah Titik', '21 Aktivitas', '893.167'),
                SizedBox(
                  height: 10.0,
                ),
                Divider(),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "3 Besar Aktivitas Amal Terbaru",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 10.0,
                ),
                setAktivitasAmal(
                    Icon(
                      IconBaru.donation_small,
                      color: Colors.purple,
                    ),
                    'assets/users/bamuis-bni.png',
                    'Bamius BNI',
                    'Donasi - 11 menit yang lalu',
                    '100.000'),
                SizedBox(
                  height: 10.0,
                ),
                setAktivitasAmal(
                    Icon(IconBaru.zakat_small, color: Colors.deepOrange),
                    'assets/users/bamuis-bni.png',
                    'Inisiatif Zakat Indonesia',
                    'Zakat - 11 menit yang lalu',
                    '319.308'),
                SizedBox(
                  height: 10.0,
                ),
                setAktivitasAmal(
                    Icon(IconBaru.infaq_small, color: Colors.blueAccent),
                    'assets/users/bamuis-bni.png',
                    'Rumah Amal Salman',
                    'Infaq - 11 menit yang lalu',
                    '25.000'),
                SizedBox(
                  height: 10.0,
                ),
              ],
            );
          },
          itemCount: 1,
          shrinkWrap: true, // todo comment this out and check the result
          physics:
              ClampingScrollPhysics(), // todo comment this out and check the result
        ),
      ],
    );
  }

  static List<charts.Series<HigestDonation, String>> _higestDonation() {
    final data = [
      new HigestDonation('Yayasan', 50),
      new HigestDonation('Sekolah', 90),
      new HigestDonation('Dhuafa', 75),
      new HigestDonation('Anak Yatim', 120),
      new HigestDonation('Kesehatan', 80),
    ];

    return [
      new charts.Series<HigestDonation, String>(
        id: 'higest',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (HigestDonation sales, _) => sales.type,
        measureFn: (HigestDonation sales, _) => sales.total,
        data: data,
      )
    ];
  }

  static List<charts.Series<PeriodDonation, DateTime>> _periodDonation() {
    final data1 = [
      new PeriodDonation(new DateTime(2017, 9, 19), 15000),
      new PeriodDonation(new DateTime(2017, 9, 26), 45000),
      new PeriodDonation(new DateTime(2017, 10, 3), 30000),
      new PeriodDonation(new DateTime(2017, 10, 15), 60000),
      new PeriodDonation(new DateTime(2017, 10, 23), 75000),
    ];

    return [
      new charts.Series<PeriodDonation, DateTime>(
        id: 'data1',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        labelAccessorFn: (PeriodDonation sales, _) =>
            '${sales.time}: ${sales.total}',
        domainFn: (PeriodDonation sales, _) => sales.time,
        measureFn: (PeriodDonation sales, _) => sales.total,
        data: data1,
      ),
    ];
  }

  static List<charts.Series<LinearSales, String>> _createSampleData() {
    final data = [
      new LinearSales('Zakat', 100),
      new LinearSales('Donasi', 75),
      new LinearSales('Pendidikan', 25),
      new LinearSales('Sosial', 5),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Portofolio',
        domainFn: (LinearSales sales, _) => sales.name,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      ),
    ];
  }
}

class PeriodDonation {
  final DateTime time;
  final int total;

  PeriodDonation(this.time, this.total);
}

class HigestDonation {
  final String type;
  final int total;

  HigestDonation(this.type, this.total);
}

class LinearSales {
  final String name;
  final int sales;

  LinearSales(this.name, this.sales);
}
