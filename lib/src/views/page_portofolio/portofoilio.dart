import 'dart:async';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/services/portofolioApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/views/page_portofolio/portofolio_text_data.dart';
import 'package:flutter_jaring_ummat/src/views/page_virtual_account/input_bill.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_jaring_ummat/src/bloc/requestVABloc.dart';
import 'package:flutter_jaring_ummat/src/bloc/portofolioBloc.dart'
    as blocPotofolio;

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
   * Variable Temp
   */
  String emailCustomer;
  String customerName;
  String customerPhone;

  /*
   * Variable Temp Pie Chart
   */
  double valueZakat = 0;
  double valueInfaq = 0;
  double valueShodqoh = 0;
  double valueWakaf = 0;
  double valueDonasi = 0;
  double valueTotal = 0;

  /*
   * Variable Temp Percent
   */

  double zakatPercent = 0;
  double infaqPercent = 0;
  double wakafPercent = 0;
  double shodaqohPercent = 0;
  double donasiPercent = 0;

  /*
   * Boolen for Loading
   */
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
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
          margin: EdgeInsets.only(right: 6),
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
                  child: Icon(ProfileInboxIcon.balance_2x,
                      color: whiteColor, size: 20),
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
                      style: TextStyle(color: grayColor),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Rp ', style: TextStyle(color: grayColor)),
                        TextSpan(
                          text: '1.250',
                          style: TextStyle(
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
          margin: EdgeInsets.only(left: 6),
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
                  child: Icon(ProfileInboxIcon.point_2x,
                      color: whiteColor, size: 20),
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
                      style: TextStyle(color: grayColor),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Rp ', style: TextStyle(color: grayColor)),
                        TextSpan(
                          text: '75',
                          style: TextStyle(
                              fontSize: 14,
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
        valueTotal == 0
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Text(
                      'Belum ada data untuk Portofolio, \n silahkan melakukan kegiatan.',
                      textAlign: TextAlign.center),
                ),
              )
            : Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: AspectRatio(
                      aspectRatio: 1.3,
                      child: showingSections == null
                          ? Center(
                              child: Text('Loading data ...'),
                            )
                          : FlChart(
                              chart: PieChart(
                                PieChartData(
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 5,
                                  centerSpaceRadius: 45,
                                  sections: showingSections,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
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
                                  text: 'Rp ',
                                  style: TextStyle(color: grayColor)),
                              TextSpan(
                                text:
                                    '${CurrencyFormat().currency(valueTotal)}',
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
        body: LoadingScreen(
          inAsyncCall: _loadingVisible,
          child: DefaultTabController(
            length: 6,
            initialIndex: indexTab,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(320),
                    child: Text(''),
                  ),
                  flexibleSpace: Container(
                    child: Column(
                      children: <Widget>[
                        mySaldoGrid,
                        sebaranAktifitas,
                      ],
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
                          case 0:
                            print('Total Data');
                            getDataPieChart();
                            break;
                          case 1:
                            print('Zakat Data');
                            var items = [
                              PieChartSectionData(
                                  color: Colors.yellow,
                                  value: valueZakat == 0.0 ? 1 : valueZakat,
                                  title:
                                      "${zakatPercent.toString().substring(0, 3)}%",
                                  radius: 26,
                                  titleStyle: TextStyle(
                                      fontSize: 12, color: whiteColor)),
                            ];
                            setState(() {
                              pieChartRawSections = items;
                              showingSections = pieChartRawSections;
                            });
                            break;
                          case 2:
                            print('Infaq Data');
                            var items = [
                              PieChartSectionData(
                                  color: Colors.redAccent,
                                  value: valueInfaq == 0.0 ? 1 : valueInfaq,
                                  title:
                                      "${infaqPercent.toString().substring(0, 3)}%",
                                  radius: 26,
                                  titleStyle: TextStyle(
                                      fontSize: 12, color: whiteColor)),
                            ];
                            setState(() {
                              pieChartRawSections = items;
                              showingSections = pieChartRawSections;
                            });
                            break;
                          case 3:
                            print('Sodaqoh Data');
                            var items = [
                              PieChartSectionData(
                                  color: Colors.deepPurple,
                                  value: valueShodqoh == 0.0 ? 1 : valueShodqoh,
                                  title:
                                      "${shodaqohPercent.toString().substring(0, 3)}%",
                                  radius: 26,
                                  titleStyle: TextStyle(
                                      fontSize: 12, color: whiteColor)),
                            ];
                            setState(() {
                              pieChartRawSections = items;
                              showingSections = pieChartRawSections;
                            });
                            break;
                          case 4:
                            print('Wakaf Data');
                            var items = [
                              PieChartSectionData(
                                  color: Colors.greenAccent,
                                  value: valueWakaf == 0.0 ? 1 : valueWakaf,
                                  title:
                                      "${wakafPercent.toString().substring(0, 3)}%",
                                  radius: 26,
                                  titleStyle: TextStyle(
                                      fontSize: 12, color: whiteColor)),
                            ];
                            setState(() {
                              pieChartRawSections = items;
                              showingSections = pieChartRawSections;
                            });
                            break;
                          case 5:
                            print('Zakat Data');
                            var items = [
                              PieChartSectionData(
                                  color: Colors.blue,
                                  value: valueZakat == 0.0 ? 1 : valueZakat,
                                  title:
                                      "${zakatPercent.toString().substring(0, 3)}%",
                                  radius: 26,
                                  titleStyle: TextStyle(
                                      fontSize: 12, color: whiteColor)),
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
                                  color: Colors.black,
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
                                  Text(
                                    '${CurrencyFormat().currency(valueTotal)}',
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
                                  color: Colors.yellow,
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
                                  Text(
                                    '${CurrencyFormat().currency(valueZakat)}',
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
                                  color: Colors.redAccent,
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
                                  Text(
                                    '${CurrencyFormat().currency(valueInfaq)}',
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
                                  color: Colors.deepPurple,
                                ),
                              ),
                              new Row(
                                children: <Widget>[
                                  const Text(
                                    'Rp',
                                    style: TextStyle(fontSize: 11.0),
                                  ),
                                  Text(
                                    '${CurrencyFormat().currency(valueShodqoh)}',
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
                                  color: Colors.greenAccent,
                                ),
                              ),
                              new Row(
                                children: <Widget>[
                                  const Text(
                                    'Rp',
                                    style: TextStyle(fontSize: 11.0),
                                  ),
                                  Text(
                                    '${CurrencyFormat().currency(valueWakaf)}',
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
                                'Donasi',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              new Row(
                                children: <Widget>[
                                  const Text(
                                    'Rp',
                                    style: TextStyle(fontSize: 11.0),
                                  ),
                                  Text(
                                    '${CurrencyFormat().currency(valueDonasi)}',
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
        ),
        floatingActionButton: SpeedDial(
          heroTag: 'Dial',
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: greenColor,
          children: [
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.donation_3x),
                backgroundColor: Colors.blueAccent,
                onTap: () {
                  requestBill("donasi");
                }),
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.wakaf_3x),
                backgroundColor: Colors.green,
                onTap: () {
                  requestBill("wakaf");
                }),
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.sodaqoh_3x),
                backgroundColor: Colors.deepPurpleAccent,
                onTap: () {
                  requestBill("sodaqoh");
                }),
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.infaq_3x),
                backgroundColor: Colors.redAccent,
                onTap: () {
                  requestBill("infaq");
                }),
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.zakat_3x),
                backgroundColor: Colors.yellow,
                onTap: () {
                  requestBill("zakat");
                }),
          ],
        ));
  }

  void requestBill(String type) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => InputBill(
        type: type,
        customerName: customerName,
        customerEmail: emailCustomer,
        customerPhone: customerPhone,
        programName: null,
      ),
    ));
  }

  @override
  void initState() {
    super.initState();

    getDataPieChart();
    getUser();
  }

  void getUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      emailCustomer = _pref.getString(EMAIL_KEY);
      customerName = _pref.getString(FULLNAME_KEY);
      customerPhone = _pref.getString(CONTACT_KEY);
    });
  }

  void getDataPieChart() {
    PortofolioProvider provider = new PortofolioProvider();
    provider.pieChartApi().then((response) {
      if (response.statusCode == 200) {
        var data =
            SebaranAktifitasAmalModel.fromJson(json.decode(response.body));

        valueTotal = data.totalSemua.toDouble();
        valueDonasi = data.totalDonasi.toDouble();
        valueWakaf = data.totalWakaf.toDouble();
        valueShodqoh = data.totalSodaqoh.toDouble();
        valueInfaq = data.totalInfaq.toDouble();
        valueZakat = data.totalZakat.toDouble();

        zakatPercent = data.totalZakatPercent;
        infaqPercent = data.totalInfaqPercent;
        shodaqohPercent = data.totalSodaqohPercent;
        wakafPercent = data.totalWakafPercent;
        donasiPercent = data.totalDonasiPercent;

        final zakatData = PieChartSectionData(
            color: Colors.orangeAccent,
            value: data.totalZakatPercent,
            title: "${data.totalZakatPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final infaqData = PieChartSectionData(
            color: Colors.red,
            value: data.totalInfaqPercent,
            title: "${data.totalInfaqPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final sodaqohData = PieChartSectionData(
            color: Colors.purpleAccent,
            value: data.totalSodaqohPercent,
            title: "${data.totalSemuaPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final wakafData = PieChartSectionData(
            color: Colors.green,
            value: data.totalWakafPercent,
            title: "${data.totalWakafPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final donasiData = PieChartSectionData(
            color: Colors.blue,
            value: data.totalDonasiPercent,
            title: "${data.totalDonasiPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final items = [
          zakatData,
          infaqData,
          sodaqohData,
          wakafData,
          donasiData
        ];
        pieChartRawSections = items;
        showingSections = pieChartRawSections;
      }
    });
  }
}
