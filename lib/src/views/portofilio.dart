import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:bezier_chart/bezier_chart.dart';

import '../views/components/icon_baru_icons.dart';
import '../views/pembayaran_zakat.dart';

class Portofolio extends StatefulWidget {
  @override
  _PortofolioState createState() => _PortofolioState();
}

class _PortofolioState extends State<Portofolio> with TickerProviderStateMixin {
  List<charts.Series<AktivitasAmal, String>> _seriesPieData;
  AnimationController _controller;

  int indexTab = 0;

  TextEditingController nominalZakat = new TextEditingController();

  var aktivitasData = [
    new AktivitasAmal('Donasi', 40, Color(0xFF3A5F99)),
    new AktivitasAmal('Zakat', 20, Color(0xFFDB7E27)),
    new AktivitasAmal('Wakaf', 10, Color(0xFFDEDE71)),
    new AktivitasAmal('Shodaqoh', 35, Color(0xFFDB4B1F)),
    new AktivitasAmal('Infaq', 15, Color(0xFF2938C2)),
  ];

  _generateData() {
    _seriesPieData.add(
      charts.Series(
        domainFn: (AktivitasAmal aktivitas, _) => aktivitas.task,
        measureFn: (AktivitasAmal aktivitas, _) => aktivitas.taskvalue,
        colorFn: (AktivitasAmal aktivitas, _) =>
            charts.ColorUtil.fromDartColor(aktivitas.colorval),
        id: 'Aktivitas Amal',
        data: aktivitasData,
        labelAccessorFn: (AktivitasAmal row, _) => '${row.taskvalue}',
      ),
    );
  }

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
  bool isSelected;

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

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _seriesPieData = List<charts.Series<AktivitasAmal, String>>();
    _generateData();
    super.initState();
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
        new Icon(
          IconBaru.wakaf_small,
        ),
        Colors.orange,
        10.0,
        "Wakaf Menu",
        () {
          tambahZakat(
            context,
            'Wakaf',
            IconBaru.wakaf_small,
          );
        },
        "Wakaf",
        Colors.black,
        Colors.white,
        true,
      ),
      new FabMiniMenuItem.withText(
        new Icon(
          IconBaru.shodaqoh_small,
        ),
        Colors.redAccent,
        10.0,
        "Shodaqoh Menu",
        () {
          tambahZakat(
            context,
            'Shodaqoh',
            IconBaru.shodaqoh_small,
          );
        },
        "Shodaqoh",
        Colors.black,
        Colors.white,
        true,
      ),
      new FabMiniMenuItem.withText(
        new Icon(
          IconBaru.infaq_small,
        ),
        Colors.blue,
        10.0,
        "Infaq Menu",
        () {},
        "Infaq",
        Colors.black,
        Colors.white,
        true,
      ),
      new FabMiniMenuItem.withText(
        new Icon(
          IconBaru.zakat_small,
        ),
        Colors.orangeAccent,
        10.0,
        "Zakat Menu",
        () {
          tambahZakat(
            context,
            'Zakat',
            IconBaru.zakat_small,
          );
        },
        "Zakat",
        Colors.black,
        Colors.white,
        true,
      ),
      new FabMiniMenuItem.withText(
          new Icon(
            IconBaru.donation_small,
          ),
          Colors.deepPurpleAccent,
          10.0,
          "Donasi Menu", () {
        tambahZakat(
          context,
          'Donasi',
          IconBaru.donation_small,
        );
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
                      color: Colors.black,
                      fontSize: 11.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  new Text(
                    'Rp 120.930',
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
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
                    color: Colors.black,
                    fontSize: 11.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                new Text(
                  'Rp 59.430',
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: DefaultTabController(
        length: 6,
        initialIndex: indexTab,
        child: Scaffold(
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
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Setting Menu Under Development'),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                elevation: 1.0,
                automaticallyImplyLeading: false,
                flexibleSpace: AppBar(
                  elevation: 3.0,
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
                ),
              ),
              new SliverAppBar(
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(160.0),
                  child: Text(''),
                ),
                flexibleSpace: AppBar(
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          right: 50.0,
                          top: 20.0,
                          left: 20.0,
                        ),
                        child: charts.PieChart(
                          _seriesPieData,
                          behaviors: [
                            new charts.DatumLegend(
                              position: charts.BehaviorPosition.end,
                              outsideJustification:
                                  charts.OutsideJustification.startDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 5,
                              cellPadding: new EdgeInsets.only(
                                  right: 24.0, bottom: 4.0, top: 10.0),
                              entryTextStyle: charts.TextStyleSpec(
                                color: charts.Color.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 20,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside,
                              ),
                            ],
                          ),
                          animate: true,
                          animationDuration: Duration(seconds: 2),
                        ),
                      ),
                      Positioned(
                        left: 70.0,
                        top: 100.0,
                        child: const Text(
                          "Total Aktivitas Amal",
                          style: TextStyle(color: Colors.grey, fontSize: 10.0),
                        ),
                      ),
                      Positioned(
                        left: 69.0,
                        top: 113.0,
                        child: const Text(
                          "Rp",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                      ),
                      Positioned(
                        left: 84.0,
                        top: 113.0,
                        child: const Text(
                          "8.950.420",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10.0,
                        top: 10.0,
                        child: const Text(
                          "Sebaran Aktivitas Amal",
                          style: TextStyle(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10.0,
                        top: 10.0,
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            "Selanjutnya",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new SliverAppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                flexibleSpace: AppBar(
                  elevation: 3.0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 4.0, color: Colors.blueAccent),
                    ),
                    labelColor: Colors.black,
                    onTap: (int index) {
                      print(index);
                      if (index == 0) {
                        setState(() {
                          print(aktivitasData.length);
                          aktivitasData.clear();
                          aktivitasData.add(
                            new AktivitasAmal('Donasi', 40, Color(0xFF3A5F99)),
                          );
                          aktivitasData.add(

                            new AktivitasAmal('Zakat', 20, Color(0xFFDB7E27)),
                          );
                          aktivitasData.add(
                            new AktivitasAmal('Wakaf', 10, Color(0xFFDEDE71)),
                          
                          );
                          aktivitasData.add(
                            new AktivitasAmal('Infaq', 15, Color(0xFF2938C2)),
                          );
                          aktivitasData.add(

                             new AktivitasAmal('Shodaqoh', 35, Color(0xFFDB4B1F)),
                          );
                          print(aktivitasData.length);
                          // _generateData();
                        });
                      }
                      if (index == 1) {
                        setState(() {
                          print(aktivitasData.length);
                          aktivitasData.clear();
                          aktivitasData.add(
                            new AktivitasAmal('Donasi', 40, Color(0xFF3A5F99)),
                          );
                          print(aktivitasData.length);
                          // _generateData();
                        });
                      }
                      if (index == 2) {
                        setState(() {
                          print(aktivitasData.length);
                          aktivitasData.clear();
                          aktivitasData.add(
                            new AktivitasAmal('Zakat', 20, Color(0xFFDB7E27)),
                          );
                          print(aktivitasData.length);
                          // _generateData();
                        });
                      }
                      if (index == 3) {
                        setState(() {
                          print(aktivitasData.length);
                          aktivitasData.clear();
                          aktivitasData.add(
                            new AktivitasAmal('Wakaf', 10, Color(0xFFDEDE71)),
                          );
                          print(aktivitasData.length);
                          // _generateData();
                        });
                      }
                      if (index == 4) {
                        setState(() {
                          print(aktivitasData.length);
                          aktivitasData.clear();
                          aktivitasData.add(
                            new AktivitasAmal(
                                'Shodaqoh', 35, Color(0xFFDB4B1F)),
                          );
                          print(aktivitasData.length);
                          // _generateData();
                        });
                      }
                      if (index == 5) {
                        setState(() {
                          print(aktivitasData.length);
                          aktivitasData.clear();
                          aktivitasData.add(
                            new AktivitasAmal('Infaq', 15, Color(0xFF2938C2)),
                          );
                          print(aktivitasData.length);
                          // _generateData();
                        });
                      }
                    },
                    tabs: <Widget>[
                      new Tab(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Total',
                              style: TextStyle(
                                color: Color(0xFF3A5F99),
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                const Text(
                                  'Rp',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                  ),
                                ),
                                const Text(
                                  '8.950.420',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      new Tab(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Donasi',
                              style: TextStyle(
                                color: Color(0xFF3A5F99),
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                const Text(
                                  'Rp',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                  ),
                                ),
                                const Text(
                                  '2.506.116',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      new Tab(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Zakat',
                              style: TextStyle(
                                color: Color(0xFFDB7E27),
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                const Text(
                                  'Rp',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                  ),
                                ),
                                const Text(
                                  '2.506.116',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      new Tab(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Wakaf',
                              style: TextStyle(
                                color: Color(0xFFDEDE71),
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                const Text(
                                  'Rp',
                                  style: TextStyle(fontSize: 11.0),
                                ),
                                const Text(
                                  '2.506.116',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      new Tab(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Shodaqoh',
                              style: TextStyle(
                                color: Color(0xFFDB4B1F),
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                const Text(
                                  'Rp',
                                  style: TextStyle(fontSize: 11.0),
                                ),
                                const Text(
                                  '2.506.116',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      new Tab(
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Infaq',
                              style: TextStyle(
                                color: Color(0xFF2938C2),
                              ),
                            ),
                            new Row(
                              children: <Widget>[
                                const Text(
                                  'Rp',
                                  style: TextStyle(fontSize: 11.0),
                                ),
                                const Text(
                                  '2.506.116',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              new SliverList(
                delegate: SliverChildListDelegate(
                  [
                    new Column(
                      children: <Widget>[_buildListItem()],
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: new Stack(
            children: <Widget>[
              new Container(
                child: new FabDialer(
                  _fabMiniMenuItemList,
                  Colors.lightGreen,
                  new Icon(IconBaru.add_donation_zakat_etc),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget setParticipan(var img, var title, var total, var price) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
      padding:
          EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0, top: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(img),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 3.0),
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 3.0),
                Text(
                  total,
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(
                      122,
                      122,
                      122,
                      1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                  height: 170,
                  child: BezierChart(
                    bezierChartScale: BezierChartScale.CUSTOM,
                    xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
                    footerValueBuilder: (double value) {
                      return "${formatAsIntOrDouble(value)}\ndays";
                    },
                    series: const [
                      BezierLine(
                        lineColor: Colors.blue,
                        label: "m",
                        data: const [
                          DataPoint<double>(value: 10, xAxis: 0),
                          DataPoint<double>(value: 90, xAxis: 5),
                          DataPoint<double>(value: 50, xAxis: 10),
                          DataPoint<double>(value: 100, xAxis: 15),
                          DataPoint<double>(value: 75, xAxis: 20),
                          DataPoint<double>(value: 0, xAxis: 25),
                          DataPoint<double>(value: 5, xAxis: 30),
                          DataPoint<double>(value: 45, xAxis: 35),
                        ],
                      ),
                    ],
                    config: BezierChartConfig(
                      footerHeight: 40,
                      verticalIndicatorStrokeWidth: 3.0,
                      verticalIndicatorColor: Colors.black,
                      displayYAxis: true,
                      showDataPoints: true,
                      bubbleIndicatorColor: Colors.white.withOpacity(0.9),
                      xLinesColor: Colors.black,
                      showVerticalIndicator: true,
                      verticalIndicatorFixedPosition: false,
                      backgroundGradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      snap: false,
                    ),
                  ),
                ),
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
}

class AktivitasAmal {
  String task;
  double taskvalue;
  Color colorval;

  AktivitasAmal(this.task, this.taskvalue, this.colorval);
}
