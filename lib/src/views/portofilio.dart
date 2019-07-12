import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:toast/toast.dart';

import '../views/components/icon_baru_icons.dart';
import '../views/pembayaran_zakat.dart';
import 'components/indicator_container.dart';

class Portofolio extends StatefulWidget {
  @override
  _PortofolioState createState() => _PortofolioState();
}

class _PortofolioState extends State<Portofolio> with TickerProviderStateMixin {
  AnimationController _controller;

  static const snackBarDuration = Duration(seconds: 3);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime backButtonPressTime;

  List<PieChartSectionData> pieChartRawSections;
  List<PieChartSectionData> showingSections;

  StreamController<PieTouchResponse> pieTouchedResultStreamController;
  StreamController<LineTouchResponse> controller;

  int touchedIndex;
  int indexTab = 0;

  String nameIndex = 'Total';

  var itemsLine = [
    new LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 1.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [Color(0xFF3A5F99)],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        dotColor: Colors.grey,
      ),
      belowBarData: BelowBarData(
        show: false,
      ),
    ),
    new LineChartBarData(
      spots: [
        FlSpot(1, 2.1),
        FlSpot(3, 3.5),
        FlSpot(5, 0.4),
        FlSpot(7, 1.4),
        FlSpot(10, 0.2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
      isCurved: true,
      colors: [Color(0xFFDEDE71)],
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        dotColor: Colors.grey,
      ),
      belowBarData: BelowBarData(
        show: false,
      ),
    ),
  ];

  var items = [
    new PieChartSectionData(
      color: Color(0xFF3A5F99),
      value: 40,
      title: "40%",
      radius: 25,
      titleStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    ),
    new PieChartSectionData(
      color: Color(0xFFDB7E27),
      value: 30,
      title: "30%",
      radius: 25,
      titleStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    ),
    new PieChartSectionData(
      color: Color(0xFFDEDE71),
      value: 15,
      title: "15%",
      radius: 25,
      titleStyle: TextStyle(
          fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    ),
    new PieChartSectionData(
      color: Color(0xFFDB4B1F),
      value: 15,
      title: "15%",
      radius: 25,
      titleStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    ),
    new PieChartSectionData(
      color: Color(0xFF2938C2),
      value: 15,
      title: "15%",
      radius: 25,
      titleStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
      ),
    ),
  ];

  TextEditingController nominalZakat = new TextEditingController();

  List<String> _metodePembayaran = [
    'BNI Syariah Virtual Account',
  ];

  bool visibilityInformation = false;

  String _selectedPembayaran;

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
  bool isSelected;

  Map<String, double> dataMap = new Map();

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
    controller = StreamController();
    super.initState();

    pieChartRawSections = items;
    showingSections = pieChartRawSections;

    pieTouchedResultStreamController = StreamController();
    pieTouchedResultStreamController.stream.distinct().listen((details) {
      print(details);
      if (details == null) {
        return;
      }

      touchedIndex = -1;
      if (details.sectionData != null) {
        touchedIndex = showingSections.indexOf(details.sectionData);
      }

      setState(() {
        if (details.touchInput is FlLongPressEnd) {
          touchedIndex = -1;
          showingSections = List.of(pieChartRawSections);
        } else {
          showingSections = List.of(pieChartRawSections);

          if (touchedIndex != -1) {
            final TextStyle style = showingSections[touchedIndex].titleStyle;
            showingSections[touchedIndex] =
                showingSections[touchedIndex].copyWith(
              titleStyle: style.copyWith(
                fontSize: 15,
              ),
              radius: 30,
            );
          }
        }
      });
    });
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

    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        key: scaffoldKey,
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
                            top: 20.0,
                            left: 20.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: FlChart(
                                    chart: PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchResponseStreamSink:
                                              pieTouchedResultStreamController
                                                  .sink,
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 5,
                                        centerSpaceRadius: 55,
                                        sections: showingSections,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    const Text(
                                      "Total Aktivitas Amal",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13.0),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          "Rp",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.0),
                                        ),
                                        const Text(
                                          "8.950.420",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Indicator(
                                      color: Color(0xff0293ee),
                                      text: "Donasi",
                                      size: 10.0,
                                      isSquare: false,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Indicator(
                                      color: Color(0xfff8b250),
                                      text: "Zakat",
                                      size: 10.0,
                                      isSquare: false,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Indicator(
                                      color: Color(0xFFDEDE71),
                                      text: "Wakaf",
                                      size: 10.0,
                                      isSquare: false,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Indicator(
                                      color: Color(0xFFDB4B1F),
                                      text: "Shodaqoh",
                                      size: 10.0,
                                      isSquare: false,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Indicator(
                                      color: Color(0xFF2938C2),
                                      text: "Infaq",
                                      size: 10.0,
                                      isSquare: false,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 28,
                              ),
                            ],
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
                        if (index == 0) {
                          setState(() {
                            this.nameIndex = 'Total';
                            items.clear();
                            itemsLine.clear();

                            itemsLine.add(
                              new LineChartBarData(
                                spots: [
                                  FlSpot(1, 1),
                                  FlSpot(3, 1.5),
                                  FlSpot(5, 1.4),
                                  FlSpot(7, 3.4),
                                  FlSpot(10, 2),
                                  FlSpot(12, 1.2),
                                  FlSpot(13, 1.8),
                                ],
                                isCurved: true,
                                colors: [Colors.blueAccent],
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  dotColor: Colors.grey,
                                ),
                                belowBarData: BelowBarData(
                                  show: false,
                                ),
                              ),
                            );

                            itemsLine.add(
                              new LineChartBarData(
                                spots: [
                                  FlSpot(1, 2.1),
                                  FlSpot(3, 3.5),
                                  FlSpot(5, 0.4),
                                  FlSpot(7, 1.4),
                                  FlSpot(10, 0.2),
                                  FlSpot(12, 2.2),
                                  FlSpot(13, 1.8),
                                ],
                                isCurved: true,
                                colors: [Color(0xFFDEDE71)],
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  dotColor: Colors.grey,
                                ),
                                belowBarData: BelowBarData(
                                  show: false,
                                ),
                              ),
                            );

                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFF2938C2),
                                value: 15,
                                title: "15%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFFDB7E27),
                                value: 30,
                                title: "30%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFF3A5F99),
                                value: 40,
                                title: "40%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFFDEDE71),
                                value: 15,
                                title: "15%",
                                radius: 25,
                                titleStyle: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffffffff)),
                              ),
                            );
                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFFDB4B1F),
                                value: 15,
                                title: "15%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
                          });
                        }
                        if (index == 1) {
                          setState(() {
                            this.nameIndex = 'Donasi';
                            items.clear();
                            itemsLine.clear();

                            itemsLine.add(
                              new LineChartBarData(
                                spots: [
                                  FlSpot(1, 2.0),
                                  FlSpot(3, 1.0),
                                  FlSpot(5, 0.4),
                                  FlSpot(7, 4.4),
                                  FlSpot(10, 1),
                                  FlSpot(12, 3.2),
                                  FlSpot(13, 2.8),
                                ],
                                isCurved: true,
                                colors: [Color(0xFF3A5F99)],
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  dotColor: Colors.green,
                                ),
                                belowBarData: BelowBarData(
                                  show: false,
                                ),
                              ),
                            );

                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFF3A5F99),
                                value: 30,
                                title: "30%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
                          });
                        }
                        if (index == 2) {
                          setState(() {
                            this.nameIndex = 'Zakat';
                            items.clear();
                            itemsLine.clear();

                            itemsLine.add(
                              new LineChartBarData(
                                spots: [
                                  FlSpot(1, 4.0),
                                  FlSpot(3, 0.5),
                                  FlSpot(5, 2.4),
                                  FlSpot(7, 1.4),
                                  FlSpot(10, 2.9),
                                  FlSpot(12, 4.2),
                                  FlSpot(13, 2.1),
                                ],
                                isCurved: true,
                                colors: [Color(0xFFDB7E27)],
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  dotColor: Colors.redAccent,
                                ),
                                belowBarData: BelowBarData(
                                  show: false,
                                ),
                              ),
                            );

                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFFDB7E27),
                                value: 30,
                                title: "30%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
                          });
                        }
                        if (index == 3) {
                          setState(() {
                            this.nameIndex = 'Wakaf';
                            items.clear();
                            itemsLine.clear();

                            itemsLine.add(
                              new LineChartBarData(
                                spots: [
                                  FlSpot(1, 0.1),
                                  FlSpot(3, 3.2),
                                  FlSpot(5, 2.4),
                                  FlSpot(7, 4.4),
                                  FlSpot(10, 2.2),
                                  FlSpot(12, 0.2),
                                  FlSpot(13, 1.8),
                                ],
                                isCurved: true,
                                colors: [Color(0xFFDEDE71)],
                                barWidth: 3,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  dotColor: Colors.redAccent,
                                ),
                                belowBarData: BelowBarData(
                                  show: false,
                                ),
                              ),
                            );

                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFFDEDE71),
                                value: 15,
                                title: "15%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
                          });
                        }
                        if (index == 4) {
                          setState(() {
                            this.nameIndex = 'Shodaqoh';
                            items.clear();
                            itemsLine.clear();

                            itemsLine.add(
                              new LineChartBarData(
                                spots: [
                                  FlSpot(1, 1),
                                  FlSpot(3, 0.5),
                                  FlSpot(5, 3.4),
                                  FlSpot(7, 1.4),
                                  FlSpot(10, 2.9),
                                  FlSpot(12, 4.0),
                                  FlSpot(13, 4.8),
                                ],
                                isCurved: true,
                                colors: [Color(0xFFDB4B1F)],
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  dotColor: Colors.indigo,
                                ),
                                belowBarData: BelowBarData(
                                  show: false,
                                ),
                              ),
                            );

                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFFDB4B1F),
                                value: 15,
                                title: "15%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
                          });
                        }
                        if (index == 5) {
                          setState(() {
                            this.nameIndex = 'Infaq';
                            items.clear();
                            itemsLine.clear();

                            itemsLine.add(
                              new LineChartBarData(
                                spots: [
                                  FlSpot(1, 1.8),
                                  FlSpot(3, 0.5),
                                  FlSpot(5, 4.4),
                                  FlSpot(7, 2.4),
                                  FlSpot(10, 1.2),
                                  FlSpot(12, 2.2),
                                  FlSpot(13, 3.8),
                                ],
                                isCurved: true,
                                colors: [Color(0xFF2938C2)],
                                barWidth: 4,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: true,
                                  dotColor: Colors.limeAccent,
                                ),
                                belowBarData: BelowBarData(
                                  show: false,
                                ),
                              ),
                            );

                            items.add(
                              new PieChartSectionData(
                                color: Color(0xFF2938C2),
                                value: 15,
                                title: "15%",
                                radius: 25,
                                titleStyle: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            );
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
                Text(
                  "${nameIndex} terkumpul per periode",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 170,
                  width: MediaQuery.of(context).size.width,
                  child: FlChart(
                    chart: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(
                          touchResponseSink: controller.sink,
                          touchTooltipData: TouchTooltipData(
                            tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                          ),
                        ),
                        gridData: FlGridData(
                          show: false,
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: SideTitles(
                            getTitles: (value) {
                              switch (value.toInt()) {
                                case 2:
                                  return "SEPT";
                                case 7:
                                  return "OCT";
                                case 12:
                                  return "DEC";
                              }
                              return "";
                            },
                            textStyle: TextStyle(
                              color: Color(0xff72719b),
                              fontSize: 15,
                            ),
                            margin: 10.0,
                          ),
                          leftTitles: SideTitles(
                              textStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 1:
                                    return "1m";
                                  case 2:
                                    return "2m";
                                  case 3:
                                    return "3m";
                                  case 4:
                                    return "5m";
                                }
                                return "";
                              },
                              margin: 5.0,
                              reservedSize: 20.0),
                        ),
                        borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xff4e4965),
                                width: 4,
                              ),
                              left: BorderSide(
                                color: Colors.transparent,
                              ),
                              right: BorderSide(
                                color: Colors.transparent,
                              ),
                              top: BorderSide(
                                color: Colors.transparent,
                              ),
                            )),
                        minX: 0,
                        maxX: 14,
                        maxY: 4,
                        minY: 0,
                        lineBarsData: itemsLine,
                      ),
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

  Future<bool> onBackPressed() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      Toast.show('Press again to leave', context,
          duration: 3, backgroundColor: Colors.grey);
      return false;
    }

    return true;
  }
}
