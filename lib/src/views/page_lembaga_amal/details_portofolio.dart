import 'dart:convert';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/penerimaanAmalTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/services/portofolioPenerimaanApi.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/barChartModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/portofolioPenerimaanBloc.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class PortofolioLembagaAmal extends StatefulWidget {
  final String idLembaga;
  PortofolioLembagaAmal({this.idLembaga});
  @override
  _PortofolioLembagaAmalState createState() =>
      _PortofolioLembagaAmalState(idLembaga: this.idLembaga);
}

class _PortofolioLembagaAmalState extends State<PortofolioLembagaAmal> {
  String idLembaga;
  _PortofolioLembagaAmalState({this.idLembaga});
  /*
   * Format for Current Month
   */
  static var now = new DateTime.now();
  static var formatter = new DateFormat('MM');
  static String month = formatter.format(now);

  /*
   * From Libs charts_flutter
   */
  static List<BarchartModel> barData;
  List<charts.Series<BarchartModel, String>> _seriesLineData;

  /*
   * Tab Index
   */
  int indexTab = 0;
  String selectedCategory = "all";

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

  List<int> lengthBarChart = [0, 0, 0, 0, 0, 0, 0, 0, 120000, 0, 0, 0];
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
   *  No Image Content
   */
  final String noImg =
      "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png";

  List<PenerimaanAmalTerbesarModel> _listAktivitasPenerimaanAmalTerbaruCache =
  new List<PenerimaanAmalTerbesarModel>();

  @override
  Widget build(BuildContext context) {
    // Sebaran Aktivitas Widget

    final sebaranAktifitas = Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Sebaran penerimaan Amal',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Hey $customerName, terimakasih telah berpartisipasi pada beberapa aktivitas amal dan berikut ini sebaran aktivitas penerimaan amal pada periode berjalan.',
            textAlign: TextAlign.justify,
          ),
//          trailing: IconButton(
//            onPressed: null,
//            icon: Icon(
//              NewIcon.next_small_2x,
//              color: blackColor,
//              size: 20,
//            ),
//          ),
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
          title: Text('Tren Penerimaan Amal',
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
            'Penerimaan amal terbesar',
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
              stream: bloc.penerimaAmalTerbesarStream,
              builder: (context,
                  AsyncSnapshot<List<PenerimaanAmalTerbesarModel>> snapshot) {
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
            'Penerimaan amal terbaru',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('3 aktivitas amal terbarumu pada semua kategori.'),
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
          child: _listAktivitasPenerimaanAmalTerbaruCache == null
              ? Center(
            child: Text('Load Data'),
          )
              : listPenerimaAmalTerbaru(
              _listAktivitasPenerimaanAmalTerbaruCache),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: whiteColor,
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
                        // mySaldoGrid,
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
                      children: <Widget>[trenAktivitas],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[aktivitasTerbesar],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[aktivitasTerbaru],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listPenerimaAmalTerbaru(List<PenerimaanAmalTerbesarModel> snapshot) {
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
              title: Text('${value.nama}',
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

  Widget listPenerimaAmalTerbesar(
      AsyncSnapshot<List<PenerimaanAmalTerbesarModel>> snapshot) {
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
                      : CircularProfileAvatar(value.imageContent)),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: Text(
                  '${value.nama}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('${value.totalAktifitas} Aktivitas',
                  style: TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis),
              SizedBox(
                height: 3,
              ),
              Text(
                'Rp ${CurrencyFormat().data.format(value.totalAmal.toDouble())}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchPenerimaAmalTerbesarLembagaDetails(idLembaga);
    bloc.fetchPenerimaAmalTerbaruLembagaDetails(idLembaga);
    bloc.fetchBarChartLembagaDetails(idLembaga, null, "satu");
    getDataPieChart();
    getAktivitasPenerimaanAmalTerbaruCache();
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
              'Rp ${CurrencyFormat().data.format(valueTotal.toDouble())} \n $valueTotalAktivitas Aktivitas',
              style: TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
      palette: [
        Colors.red,
        Colors.yellow,
        Colors.deepOrange,
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
            print(valueTotal);
            bloc.fetchBarChart("zakat", "satu");
            setState(() {});
            break;
          case 1:
            valueTotal = valueInfaq;
            barColor = Colors.yellow;
            print(valueTotal);
            bloc.fetchBarChart("infaq", "satu");
            setState(() {});
            break;
          case 2:
            valueTotal = valueShodqoh;
            barColor = Colors.redAccent[200];
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
      ),
    ];
  }

  void getDataPieChart() {
    PortofolioPenerimaanProvider provider = new PortofolioPenerimaanProvider();
    provider.pieChartLembagaDetailsApi(idLembaga).then((response) {
      if (response.statusCode == 200) {
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

  getAktivitasPenerimaanAmalTerbaruCache() {
    print('Get Aktivitas Penerimaan Terbaru ===>');
    bloc.aktivitasPenerimaanAmalTerbaruBehaviour.stream
        .forEach((value) {
      if (mounted) {
        setState(() {
          _listAktivitasPenerimaanAmalTerbaruCache = value;
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
