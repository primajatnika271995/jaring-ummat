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
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/grid_menu_icon_icons.dart';
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
import 'package:syncfusion_flutter_charts/charts.dart';

class Portofolio extends StatefulWidget {
  @override
  _PortofolioState createState() => _PortofolioState();
}

class _PortofolioState extends State<Portofolio> {
  /*
   * Inisialisasi Protofolio Provider
   */
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
  double valueBackup = 0;
  int valueTotalAktivitas = 0;

  /*
   * Variable Temp Percent
   */

  double zakatPercent = 0;
  double infaqPercent = 0;
  double wakafPercent = 0;
  double shodaqohPercent = 0;
  double donasiPercent = 0;
  double totalPercent = 100;

  double fillPercent;

  /*
   * Boolen for Loading
   */
  bool _loadingVisible = false;

  /*
   * Bar Chart Default Color
   */

  var barColor = Colors.teal;

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
            'Hey $customerName, terimakasih telah berpartisipasi pada beberapa aktivitas amal dan berikut ini sebaran aktivitasmu pada periode berjalan.',
            textAlign: TextAlign.justify,
          ),
        ),
        Container(
          height: 250,
          child: getDefaultDoughnutChart(false),
        ),
      ],
    );

    // Tren Aktivitas Harian / Line Chart

    final trenAktivitas = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text('Tren Aktivitas Amal Harian',
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.bold,
              )),
        ),
        buildBarChart(context),
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
            '3 aktivitas amal terbesarmu berdasarkan nominal. Yuk perbanyak lagi amalmu dengan menekan tombol "+".',
            textAlign: TextAlign.justify,
          ),
//          trailing: IconButton(
//            onPressed: () {},
//            icon: Icon(NewIcon.next_small_2x),
//            color: blackColor,
//            iconSize: 20,
//          ),
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
//          trailing: IconButton(
//            onPressed: null,
//            icon: Icon(NewIcon.next_small_2x),
//            color: blackColor,
//            iconSize: 20,
//          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15),
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
              onPressed: () {},
              icon: Icon(AllInOneIcon.detail_2x),
              color: blackColor,
              iconSize: 25,
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
            setState(() {});
          },
          onClose: () {
            _ic = Icon(Icons.add);
            setState(() {});
          },
          backgroundColor: greenColor,
          children: [
            SpeedDialChild(
                child: Icon(GridMenuIcon.donation_new),
                backgroundColor: Colors.blueAccent,
                label: 'Donasi',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
//                  requestBill("donasi");
                  Navigator.of(context).pushNamed("/home");
                }),
            SpeedDialChild(
                child: Icon(GridMenuIcon.wakaf_new),
                backgroundColor: Colors.green,
                label: 'Wakaf',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
                  requestBill("wakaf");
                }),
            SpeedDialChild(
                child: Icon(GridMenuIcon.sodaqoh_new),
                backgroundColor: Colors.deepPurpleAccent,
                label: 'Sodaqoh',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
                  requestBill("sodaqoh");
                }),
            SpeedDialChild(
                child: Icon(GridMenuIcon.infaq_new),
                backgroundColor: Colors.redAccent,
                label: 'Infaq',
                labelStyle: TextStyle(color: whiteColor),
                labelBackgroundColor: Colors.black,
                onTap: () {
                  requestBill("infaq");
                }),
            SpeedDialChild(
                child: Icon(GridMenuIcon.zakat_new),
                backgroundColor: Colors.yellow[600],
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
              SizedBox(
                height: 5,
              ),
              CircleAvatar(
                backgroundColor: greenColor,
                child: (value.imageContent == null)
                    ? CircularProfileAvatar(noImg)
                    : CircularProfileAvatar(value.imageContent),
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
                'Rp ${CurrencyFormat().data.format(value.totalAmal.toDouble())}',
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
                  '${value.category} - ${TimeAgoService().timeAgoFormatting(value.requestedDate)}',
                  style: TextStyle(fontSize: 12)),
              trailing: Text(
                  'Rp ${CurrencyFormat().data.format(value.totalAmal.toDouble())}',
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
    getDataPieChart();
    bloc.fetchAktivitasTerbesar();
    bloc.fetchAktivitasTerbaru();
    bloc.fetchBarChart(null, "satu");
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

  Widget getDefaultDoughnutChart(bool isTileView) {
    return SfCircularChart(
      legend: Legend(
        isVisible: isTileView ? false : true,
        position: LegendPosition.right,
        itemPadding: 15,
        isResponsive: true,
        padding: 2,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      series: getDoughnutSeries(isTileView),
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Container(
            child: Text(
              'Rp ${CurrencyFormat().data.format(valueTotal.toDouble())} \n $valueTotalAktivitas Aktivitas \n ${totalPercent.toInt()} %',
              style: TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
      palette: [
        Colors.red,
        Colors.yellow,
        Colors.orange,
        Colors.deepPurpleAccent,
        Colors.blue,
        Colors.teal
      ],
      tooltipBehavior: TooltipBehavior(enable: false),
      onLegendTapped: (LegendTapArgs value) {
        print(value.pointIndex);
        switch (value.pointIndex) {
          case 5:
            valueTotal = valueBackup;
            barColor = Colors.teal;
            print(valueTotal);
            bloc.fetchBarChart("", "satu");
            setState(() {});
            break;
        }
      },
      onPointTapped: (PointTapArgs value) {
        print(value.pointIndex);
        switch (value.pointIndex) {
          case 0:
            valueTotal = valueZakat;
            barColor = Colors.red;
            totalPercent = zakatPercent;
            print(valueTotal);
            bloc.fetchBarChart("zakat", "satu");
            setState(() {});
            break;
          case 1:
            valueTotal = valueInfaq;
            barColor = Colors.yellow;
            totalPercent = infaqPercent;
            print(valueTotal);
            bloc.fetchBarChart("infaq", "satu");
            setState(() {});
            break;
          case 2:
            valueTotal = valueShodqoh;
            barColor = Colors.orange;
            totalPercent = shodaqohPercent;
            print(valueTotal);
            bloc.fetchBarChart("sodaqoh", "satu");
            setState(() {});
            break;
          case 3:
            valueTotal = valueWakaf;
            barColor = Colors.deepPurple;
            print(valueTotal);
            bloc.fetchBarChart("wakaf", "satu");
            setState(() {});
            break;
          case 4:
            valueTotal = valueDonasi;
            barColor = Colors.blue;
            totalPercent = donasiPercent;
            print(valueTotal);
            bloc.fetchBarChart("donasi", "satu");
            setState(() {});
            break;
        }
      },
    );
  }

  List<DoughnutSeries<_DoughnutData, String>> getDoughnutSeries(
      bool isTileView) {
    final List<_DoughnutData> chartData = <_DoughnutData>[
      _DoughnutData('Zakat', zakatPercent, '$zakatPercent %'),
      _DoughnutData('Infaq', infaqPercent, '$infaqPercent %'),
      _DoughnutData('Sodaqoh', shodaqohPercent, '$shodaqohPercent %'),
      _DoughnutData('Wakaf', wakafPercent, '$wakafPercent %'),
      _DoughnutData('Donasi', donasiPercent, '$donasiPercent %'),
      _DoughnutData('Total', 0, ''),
    ];
    return <DoughnutSeries<_DoughnutData, String>>[
      DoughnutSeries<_DoughnutData, String>(
        radius: '100%',
        innerRadius: '67%',
        legendIconType: LegendIconType.circle,
        explode: true,
        explodeOffset: '10%',
        enableSmartLabels: true,
        dataSource: chartData,
        xValueMapper: (_DoughnutData data, _) => data.xData,
        yValueMapper: (_DoughnutData data, _) => data.yData,
        dataLabelMapper: (_DoughnutData data, _) => data.text,
        dataLabelSettings: DataLabelSettings(
          isVisible: false,
          textStyle: ChartTextStyle(color: Colors.white),
        ),
      )
    ];
  }

  void getDataPieChart() {
    PortofolioProvider provider = new PortofolioProvider();
    provider.pieChartApi().then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("ini response pie chart ==>");
        print(response.statusCode);
        var data =
            SebaranAktifitasAmalModel.fromJson(json.decode(response.body));

        valueTotal = data.totalSemua.toDouble();
        valueBackup = data.totalSemua.toDouble();
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
    return Container(
      height: 150,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          isVisible: false,
          minimum: 0,
          maximum: valueBackup,
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0),
        ),
        series: <ColumnSeries<SalesData, String>>[
          ColumnSeries(
            dataSource: <SalesData>[
              SalesData('Jan', snapshot[0].total.toDouble()),
              SalesData('Feb', snapshot[1].total.toDouble()),
              SalesData('Mar', snapshot[2].total.toDouble()),
              SalesData('Apr', snapshot[3].total.toDouble()),
              SalesData('Mei', snapshot[4].total.toDouble()),
              SalesData('Jun', snapshot[5].total.toDouble()),
              SalesData('Jul', snapshot[6].total.toDouble()),
              SalesData('Ags', snapshot[7].total.toDouble()),
              SalesData('Sep', snapshot[8].total.toDouble()),
              SalesData('Okt', snapshot[9].total.toDouble()),
              SalesData('Nov', snapshot[10].total.toDouble()),
              SalesData('Des', snapshot[11].total.toDouble()),
            ],
            isTrackVisible: true,
            borderRadius: BorderRadius.circular(5),
            trackColor: Colors.grey[200],
            color: barColor,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(
              isVisible: false,
              textStyle: ChartTextStyle(color: Colors.white),
            ),
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          canShowMarker: false,
          header: '',
          format: 'Total bulan point.x : point.y',
        ),
      ),
    );
  }
}

class SalesData {
  final String year;
  final double sales;

  SalesData(this.year, this.sales);
}

class _DoughnutData {
  final String xData;
  final num yData;
  final String text;

  _DoughnutData(this.xData, this.yData, this.text);
}
