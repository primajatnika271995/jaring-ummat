import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_fab_dialer/flutter_fab_dialer.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_portofolio/portofolio_text_data.dart';
import 'package:flutter_jaring_ummat/src/views/page_virtual_account/request_va.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_jaring_ummat/src/bloc/requestVABloc.dart';

class Portofolio extends StatefulWidget {
  @override
  _PortofolioState createState() => _PortofolioState();
}

class _PortofolioState extends State<Portofolio> {
  /*
   * Format for Current Month
   */
  static var now = new DateTime.now();
  static var formatter = new DateFormat('MM');
  static String month = formatter.format(now);

  /*
   * Fl Pie Charts
   */
  List<PieChartSectionData> pieChartRawSections;
  List<PieChartSectionData> showingSections;

  /*
   * Tab Index
   */
  int indexTab = 0;

  /*
   * Text Field Money Formatter
   */
  var nominalCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');

  /*
   * Variable Temp
   */
  String emailCustomer;
  String customerName;
  String customerPhone;

  /*
   * Variable Temp Pie Chart
   */
  double valueZakat = 10;
  double valueInfaq = 20;
  double valueShodqoh = 30;
  double valueWakaf = 40;
  double valueDonasi = 50;

  @override
  Widget build(BuildContext context) {
    /*
   * FabMenu List
   */
    var fabMenuList = [
      FabMiniMenuItem.noText(Icon(ProfileInboxIcon.zakat_3x), Colors.yellow, 0,
          "Zakat", () => showPayment('zakat'), true),
      FabMiniMenuItem.noText(Icon(ProfileInboxIcon.infaq_3x), Colors.redAccent,
          0, "Infaq", () => showPayment('infaq'), true),
      FabMiniMenuItem.noText(
          Icon(ProfileInboxIcon.sodaqoh_3x),
          Colors.deepPurple,
          0,
          "shodaqoh",
          () => showPayment('shodaqoh'),
          true),
      FabMiniMenuItem.noText(Icon(ProfileInboxIcon.wakaf_3x), Colors.green, 0,
          "Wakaf", () => showPayment('wakaf'), true),
      FabMiniMenuItem.noText(Icon(ProfileInboxIcon.donation_3x), Colors.blue, 0,
          "Donasi", () => showPayment('donasi'), true),
    ];

    // Title Bar Widget

    final titleBar = Text('Portofolio ${PortofolioTextData.listMonth[9]} 2019',
        style: TextStyle(color: blackColor));

    // My Saldo Widget

    final mySaldoGrid = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      childAspectRatio: 2.4,
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200], width: 3),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Icon(ProfileInboxIcon.balance_2x, color: whiteColor, size: 20),
                ),
                SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Saldo Jejaring',
                      style: TextStyle(fontSize: 14, color: grayColor),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Rp', style: TextStyle(color: grayColor)),
                        TextSpan(
                          text: '1.250',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: blackColor),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200], width: 3),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Icon(ProfileInboxIcon.point_2x, color: whiteColor, size: 20),
                ),
                SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Point Amal',
                      style: TextStyle(fontSize: 14, color: grayColor),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Rp', style: TextStyle(color: grayColor)),
                        TextSpan(
                          text: '75',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: blackColor),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // Sebaran Aktivitas Widget

    final sebaranAktifitas = Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Sebaran Aktivitas Amal',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              'Hey $customerName, terimakasih telah berpartisipasi pada beberapa aktivitas amal dan berikut ini sebaran aktivitasmu pada periode berjalan.'),
          trailing: IconButton(
            onPressed: null,
            icon: Icon(
              NewIcon.next_small_2x,
              color: blackColor,
              size: 20,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                height: 200,
                width: 200,
                child: FlChart(
                  chart: PieChart(
                    PieChartData(
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        centerSpaceRadius: 65,
                        sections: showingSections),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Total pada periode berjalan',
                      style: TextStyle(fontSize: 13, color: grayColor),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Rp', style: TextStyle(color: grayColor)),
                        TextSpan(
                          text: '1.800.301',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: blackColor),
                        ),
                      ]),
                    ),
                    Text(
                      '/ 34 Aktivitas Amal',
                      style: TextStyle(color: grayColor, fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );

    // Sebaran Aktivitas Terbesar Widget

    final aktivitasTerbesar = Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Aktivitas Terbesar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              '3 aktivitas amal terbesarmu berdasarkan nominal. Yuk perbanyak lagi amalmu dengan menekan tombol "+".'),
          trailing: IconButton(
            onPressed: null,
            icon: Icon(NewIcon.next_small_2x),
            color: blackColor,
            iconSize: 20,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200], width: 3),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200], width: 3),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200], width: 3),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final aktivitasTerbaru = Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Aktivitas Terbaru',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('3 aktivitas amal terbarumu pada semua kategori.'),
          trailing: IconButton(
            onPressed: null,
            icon: Icon(NewIcon.next_small_2x),
            color: blackColor,
            iconSize: 20,
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: titleBar,
        actions: <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(NewIcon.refresh_2x),
            color: blackColor,
            iconSize: 20,
          ),
        ],
      ),
      body: DefaultTabController(
        length: 6,
        initialIndex: indexTab,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(370),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      mySaldoGrid,
                      sebaranAktifitas,
                    ],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              backgroundColor: whiteColor,
              automaticallyImplyLeading: false,
              floating: true,
              pinned: true,
              flexibleSpace: AppBar(
                elevation: 1,
                backgroundColor: whiteColor,
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 4.0, color: Colors.blueAccent),
                  ),
                  labelColor: blackColor,
                  onTap: (index) {
                    switch (index) {
                      case 1:
                        print('Zakat Data');
                        var items = [
                          PieChartSectionData(
                              color: Color(0xFF3A5F99),
                              value: 80,
                              title: "40%",
                              radius: 35,
                              titleStyle:
                                  TextStyle(fontSize: 14, color: whiteColor)),
                        ];
                        setState(() {
                          pieChartRawSections = items;
                          showingSections = pieChartRawSections;
                        });
                        break;
                      default:
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
                            'Zakat',
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
                            'Infaq',
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
                            'Sodaqoh',
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
                            'Wakaf',
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
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(180),
                child: Container(
                  child: Column(
                    children: <Widget>[aktivitasTerbesar],
                  ),
                ),
              ),
            ),
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Column(
                    children: <Widget>[aktivitasTerbaru],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: new Stack(
        children: <Widget>[
          new Container(
            child: new FabDialer(
              fabMenuList,
              greenColor,
              new Icon(NewIcon.close_2x),
            ),
          ),
        ],
      ),
    );
  }

  void showPayment(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Text('Masukan nominal $type yang akan dikirimkan',
            textAlign: TextAlign.center),
        content: Container(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nominalCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Silahkan isi nominal'),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: bloc.streamRequest,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      onPressed: () {
                        bloc.requestVA(
                            context,
                            nominalCtrl.numberValue,
                            emailCustomer,
                            customerName,
                            customerPhone,
                            null,
                            type);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45)),
                      child: Text(
                        'Request',
                        style: TextStyle(color: whiteColor),
                      ),
                      color: greenColor,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    getUser();

    final zakatData = PieChartSectionData(
        color: Colors.orangeAccent,
        value: valueZakat,
        title: "$valueZakat%",
        radius: 35,
        titleStyle: TextStyle(fontSize: 12, color: whiteColor));

    final infaqData = PieChartSectionData(
        color: Colors.red,
        value: valueInfaq,
        title: "$valueInfaq%",
        radius: 35,
        titleStyle: TextStyle(fontSize: 12, color: whiteColor));

    final sodaqohData = PieChartSectionData(
        color: Colors.purpleAccent,
        value: valueShodqoh,
        title: "$valueShodqoh%",
        radius: 35,
        titleStyle: TextStyle(fontSize: 12, color: whiteColor));

    final wakafData = PieChartSectionData(
        color: Colors.green,
        value: valueWakaf,
        title: "$valueZakat%",
        radius: 35,
        titleStyle: TextStyle(fontSize: 12, color: whiteColor));

    final donasiData = PieChartSectionData(
        color: blueColor,
        value: valueDonasi,
        title: "$valueDonasi%",
        radius: 35,
        titleStyle: TextStyle(fontSize: 12, color: whiteColor));

    final items = [zakatData, infaqData, sodaqohData, wakafData, donasiData];
    pieChartRawSections = items;
    showingSections = pieChartRawSections;
  }

  void getUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      emailCustomer = _pref.getString(EMAIL_KEY);
      customerName = _pref.getString(FULLNAME_KEY);
      customerPhone = _pref.getString(CONTACT_KEY);
    });
  }
}
