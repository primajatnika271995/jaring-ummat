import 'dart:async';
import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/aktivitasTerbaruModel.dart';
import 'package:flutter_jaring_ummat/src/models/aktivitasTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/barChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/services/portofolioApi.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/indicator_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/views/page_payment/payment.dart';
import 'package:flutter_jaring_ummat/src/views/page_portofolio/portofolio_text_data.dart';
import 'package:flutter_jaring_ummat/src/views/page_virtual_account/input_bill.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_jaring_ummat/src/bloc/portofolioBloc.dart';

class Portofolio extends StatefulWidget {
  @override
  _PortofolioState createState() => _PortofolioState();
}

class _PortofolioState extends State<Portofolio> {
  /// Inisialisasi Protofolio Provider
  PortofolioProvider provider = new PortofolioProvider();

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
   * From Libs charts_flutter
   */
  static List<BarchartModel> barData;

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
  int valueTotalAktivitas = 0;

  /*
   * Variable Temp Percent
   */

  double zakatPercent = 0;
  double infaqPercent = 0;
  double wakafPercent = 0;
  double shodaqohPercent = 0;
  double donasiPercent = 0;

  double fillPercent;

  /*
   * Boolen for Loading
   */
  bool _loadingVisible = false;

  /*
   * Bar Chart Default Color
   */

  var barColor = Colors.deepPurple;

  /*
   * Variable No Content Image
   */
  final String noImg =
      "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png";

  Icon _ic = new Icon(Icons.add);

  List<AktivitasTerbesarModel> _listAktivitasTerbaruCache =
      new List<AktivitasTerbesarModel>();

  @override
  Widget build(BuildContext context) {
    // Title Bar Widget

    final titleBar = Text(
      'Dashboard Amal',
      style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize),
    );

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
                      style: TextStyle(color: grayColor, fontSize: 12),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Rp ', style: TextStyle(color: grayColor)),
                        TextSpan(
                          text: '1.250',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: blackColor),
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
                  backgroundColor: Colors.yellow[300],
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
                      style: TextStyle(color: grayColor, fontSize: 12),
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
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.27,
                      // width: MediaQuery.of(context).size.width * 0.20,
                      height: 150,
                      child: showingSections == null
                          ? Center(
                              child: Text('Loading data ...'),
                            )
                          : FlChart(
                              chart: PieChart(
                                PieChartData(
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 1,
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
                            'Sebaran penerimaan amal',
                            style: TextStyle(fontSize: 13, color: grayColor),
                          ),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: 'Rp ',
                                  style: TextStyle(color: grayColor)),
                              TextSpan(
                                text: valueTotal <= 10
                                    ? '0'
                                    : '${CurrencyFormat().currency(valueTotal)}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: blackColor),
                              ),
                            ]),
                          ),
                          Text(
                            '/ $valueTotalAktivitas Aktivitas Amal',
                            style: TextStyle(color: grayColor, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            InkWell(
              onTap: () {
                print('Zakat Data');
                var items = [
                  PieChartSectionData(
                      color: Colors.yellow,
                      value: valueZakat == 0.0 ? 1 : valueZakat,
                      title: "${zakatPercent.toString().substring(0, 3)}%",
                      radius: 26,
                      titleStyle: TextStyle(fontSize: 12, color: whiteColor)),
                ];
                bloc.fetchBarChart("zakat", "satu");

                setState(() {
                  valueTotal = valueZakat + 1.0;
                  barColor = Colors.yellow;
                  pieChartRawSections = items;
                  showingSections = pieChartRawSections;
                });
              },
              child: Indicator(
                color: Colors.yellowAccent,
                text: 'Zakat',
                isSquare: false,
              ),
            ),
            InkWell(
              onTap: () {
                print('Infaq Data');
                var items = [
                  PieChartSectionData(
                      color: Colors.redAccent,
                      value: valueInfaq == 0.0 ? 1 : valueInfaq,
                      title: "${infaqPercent.toString().substring(0, 3)}%",
                      radius: 26,
                      titleStyle: TextStyle(fontSize: 12, color: whiteColor)),
                ];
                bloc.fetchBarChart("infaq", "satu");
                setState(() {
                  barColor = Colors.red;
                  valueTotal = valueInfaq + 1.0;
                  pieChartRawSections = items;
                  showingSections = pieChartRawSections;
                });
              },
              child: Indicator(
                color: Colors.redAccent,
                text: 'Infaq',
                isSquare: false,
              ),
            ),
            InkWell(
              onTap: () {
                print('Sodaqoh Data');
                var items = [
                  PieChartSectionData(
                      color: Colors.green,
                      value: valueShodqoh == 0.0 ? 1 : valueShodqoh,
                      title: "${shodaqohPercent.toString().substring(0, 3)}%",
                      radius: 26,
                      titleStyle: TextStyle(fontSize: 12, color: whiteColor)),
                ];
                bloc.fetchBarChart("sodaqoh", "satu");
                setState(() {
                  barColor = Colors.green;
                  valueTotal = valueShodqoh + 1.0;
                  pieChartRawSections = items;
                  showingSections = pieChartRawSections;
                });
              },
              child: Indicator(
                color: Colors.green,
                text: 'Sodaqoh',
                isSquare: false,
              ),
            ),
            InkWell(
              onTap: () {
                print('Wakaf Data');
                var items = [
                  PieChartSectionData(
                      color: Colors.deepPurple,
                      value: valueWakaf == 0.0 ? 1 : valueWakaf,
                      title: "${wakafPercent.toString().substring(0, 3)}%",
                      radius: 26,
                      titleStyle: TextStyle(fontSize: 12, color: whiteColor)),
                ];
                bloc.fetchBarChart("wakaf", "satu");
                setState(() {
                  barColor = Colors.deepPurple;
                  valueTotal = valueWakaf + 1.0;
                  pieChartRawSections = items;
                  showingSections = pieChartRawSections;
                });
              },
              child: Indicator(
                color: Colors.deepPurpleAccent,
                text: 'Wakaf',
                isSquare: false,
              ),
            ),
            InkWell(
              onTap: () {
                print('Donasi Data');
                var items = [
                  PieChartSectionData(
                      color: Colors.blue,
                      value: valueDonasi == 0.0 ? 1 : valueDonasi,
                      title: "${donasiPercent.toString().substring(0, 3)}%",
                      radius: 26,
                      titleStyle: TextStyle(fontSize: 12, color: whiteColor)),
                ];
                bloc.fetchBarChart("donasi", "satu");
                setState(() {
                  barColor = Colors.blue;
                  valueTotal = valueDonasi + 1.0;
                  pieChartRawSections = items;
                  showingSections = pieChartRawSections;
                });
              },
              child: Indicator(
                color: Colors.blue,
                text: 'Donasi',
                isSquare: false,
              ),
            ),
          ],
        ),
      ],
    );

    // Tren Aktivitas Harian / Line Chart

    final trenAktivitas = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text('Tren Aktivitas Amal Harian',
              style: TextStyle(color: blackColor)),
        ),
        buildBarChart(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('Jan'),
              const Text('Des'),
            ],
          ),
        ),
      ],
    );

    // Sebaran Aktivitas Terbesar Widget

    final aktivitasTerbesar = Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text(
            'Aktivitas Terbesar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
              '3 aktivitas amal terbesarmu berdasarkan nominal. Yuk perbanyak lagi amalmu dengan menekan tombol "+".'),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(NewIcon.next_small_2x),
            color: blackColor,
            iconSize: 20,
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: StreamBuilder(
              stream: bloc.aktivitasTerbesar,
              builder: (context,
                  AsyncSnapshot<List<AktivitasTerbesarModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading');
                    break;
                  default:
                    if (snapshot.hasData) {
                      return listPenerimaAmalTerbesar(snapshot);
                    }
                    return GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[200], width: 3),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(child: Text('No Data')),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[200], width: 3),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(child: Text('No Data')),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[200], width: 3),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(child: Text('No Data')),
                        ),
                      ],
                    );
                }
              }),
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
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: _listAktivitasTerbaruCache == null
              ? Center(
                  child: Text('Load Data'),
                )
              : listPenerimaAmalTerbaru(_listAktivitasTerbaruCache),
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
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          mySaldoGrid,
                          sebaranAktifitas,
                        ],
                      ),
                    ),
                  ]),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      child: Column(
                        children: <Widget>[
                          trenAktivitas,
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          aktivitasTerbesar,
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          aktivitasTerbaru,
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          heroTag: 'Dial',
          child: _ic,
          onOpen: () {
            _ic = Icon(Icons.close);
          },
          onClose: () {
            _ic = Icon(Icons.add);
          },
          backgroundColor: greenColor,
          children: [
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.donation_3x),
                backgroundColor: Colors.blueAccent,
                label: 'Donasi',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
//                  requestBill("donasi");
                  Navigator.of(context).pushNamed("/home");
                }),
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.wakaf_3x),
                backgroundColor: Colors.green,
                label: 'Wakaf',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
                  requestBill("wakaf");
                }),
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.sodaqoh_3x),
                backgroundColor: Colors.deepPurpleAccent,
                label: 'Sodaqoh',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
                  requestBill("sodaqoh");
                }),
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.infaq_3x),
                backgroundColor: Colors.redAccent,
                label: 'Infaq',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
                  requestBill("infaq");
                }),
            SpeedDialChild(
                child: Icon(ProfileInboxIcon.zakat_3x),
                backgroundColor: Colors.yellow,
                label: 'Zakat',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
                  requestBill("zakat");
                }),
          ],
        ));
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

  Widget listPenerimaAmalTerbesar(
      AsyncSnapshot<List<AktivitasTerbesarModel>> snapshot) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: snapshot.data.length <= 3 ? snapshot.data.length : 3,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (constext, index) {
        var value = snapshot.data[index];
        return Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200], width: 3),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: greenColor,
                child: (value.imageContent == null)
                    ? CircularProfileAvatar(noImg)
                    : CircularProfileAvatar(value.imageContent),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: Text(
                  '${value.lembagaAmalName}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('${value.totalAktifitas} Aktivitas',
                  style: TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis),
              SizedBox(
                height: 7,
              ),
              Text(
                'Rp ${CurrencyFormat().currency(value.totalAmal.toDouble())}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listPenerimaAmalTerbaru(List<AktivitasTerbesarModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length <= 3 ? snapshot.length : 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var value = snapshot[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200], width: 3),
              borderRadius: BorderRadius.circular(13),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: value.category == "zakat"
                    ? Colors.yellow
                    : value.category == "infaq"
                        ? Colors.redAccent
                        : value.category == "sodaqoh"
                            ? Colors.deepPurple
                            : value.category == "wakaf"
                                ? Colors.green
                                : value.category == "donasi"
                                    ? Colors.blue
                                    : Colors.blue,
                child: Icon(
                  value.category == "zakat"
                      ? ProfileInboxIcon.zakat_3x
                      : value.category == "infaq"
                          ? ProfileInboxIcon.infaq_3x
                          : value.category == "sodaqoh"
                              ? ProfileInboxIcon.sodaqoh_3x
                              : value.category == "wakaf"
                                  ? ProfileInboxIcon.wakaf_3x
                                  : value.category == "donasi"
                                      ? ProfileInboxIcon.donation_3x
                                      : ProfileInboxIcon.donation_3x,
                  color: whiteColor,
                  size: 20,
                ),
              ),
              title: Text('${value.lembagaAmalName}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Text(
                  '${TimeAgoService().timeAgoFormatting(value.requestedDate)}',
                  style: TextStyle(fontSize: 12)),
              trailing: Text(
                  'Rp ${CurrencyFormat().currency(value.totalAmal.toDouble())}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchAktivitasTerbesar();
    bloc.fetchAktivitasTerbaru();
    bloc.fetchBarChart(null, "satu");
    getDataPieChart();
    getAktivitasTerbaruCache();
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
        valueTotalAktivitas = data.totalAktifitas;

        zakatPercent = data.totalZakatPercent;
        infaqPercent = data.totalInfaqPercent;
        shodaqohPercent = data.totalSodaqohPercent;
        wakafPercent = data.totalWakafPercent;
        donasiPercent = data.totalDonasiPercent;

        final zakatData = PieChartSectionData(
            color: Colors.orangeAccent,
            value: data.totalZakatPercent,
            title: data.totalZakatPercent == 0.0
                ? null
                : "${data.totalZakatPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final infaqData = PieChartSectionData(
            color: Colors.red,
            value: data.totalInfaqPercent,
            title: data.totalInfaqPercent == 0.0
                ? null
                : "${data.totalInfaqPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final sodaqohData = PieChartSectionData(
            color: Colors.purpleAccent,
            value: data.totalSodaqohPercent,
            title: data.totalSodaqohPercent == 0.0
                ? null
                : "${data.totalSemuaPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final wakafData = PieChartSectionData(
            color: Colors.green,
            value: data.totalWakafPercent,
            title: data.totalWakafPercent == 0.0
                ? null
                : "${data.totalWakafPercent.toString().substring(0, 2)}%",
            radius: 26,
            titleStyle: TextStyle(fontSize: 12, color: whiteColor));

        final donasiData = PieChartSectionData(
            color: Colors.blue,
            value: data.totalDonasiPercent,
            title: data.totalDonasiPercent == 0.0
                ? null
                : "${data.totalDonasiPercent.toString().substring(0, 2)}%",
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

  getAktivitasTerbaruCache() {
    print('Get Aktivitas Terbaru ===>');
    bloc.aktivitasTerbaruBehaviour.stream.forEach((value) {
      if (mounted) {
        setState(() {
          _listAktivitasTerbaruCache = value;
        });
      }
    });
  }

  Widget buildBarChart(BuildContext context) {
    return StreamBuilder(
      stream: bloc.barChartStream,
      builder: (context, AsyncSnapshot<List<BarchartModel>> snapshot) {
        if (snapshot.hasData) {
          return barChartBuild(context, snapshot.data);
        }
        return Center(
          child: Text('loading'),
        );
      },
    );
  }

  Widget barChartBuild(BuildContext context, List<BarchartModel> snapshot) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: 110,
            width: screenWidth(context),
            child: ListView.builder(
              itemCount: 12,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var data = snapshot[index];
                var percent = (data.total / valueTotal) * 100;
                fillPercent = percent;

                final Color background = Colors.grey[200];
                final Color fill = barColor;
                final List<Color> gradient = [
                  background,
                  background,
                  fill,
                  fill,
                ];
                // final double fillPercent = 80;
                final double fillStop = (100 - fillPercent) / 100;
                final List<double> stops = [0.0, fillStop, fillStop, 1.0];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradient,
                        stops: stops,
                        end: Alignment.bottomCenter,
                        begin: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: screenWidth(context, dividedBy: 16.8),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
