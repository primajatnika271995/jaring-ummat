import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_kalkulator_zakat/zakat_fitrah.dart';
import 'package:flutter_jaring_ummat/src/views/page_kalkulator_zakat/zakat_maal.dart';
import 'package:flutter_jaring_ummat/src/views/page_kalkulator_zakat/zakat_profesi.dart';

class KalkulatorZakatPage extends StatefulWidget {
  @override
  _KalkulatorZakatPageState createState() => _KalkulatorZakatPageState();
}

class _KalkulatorZakatPageState extends State<KalkulatorZakatPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: whiteColor,
          elevation: 1,
          title: Text('Hitung Kewajiban Zakatmu',
              style: TextStyle(color: blackColor)),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(NewIcon.back_small_2x),
            color: blackColor,
            iconSize: 20,
          ),
          bottom: TabBar(
            labelColor: greenColor,
            indicatorColor: greenColor,
            unselectedLabelColor: grayColor,
            tabs: <Widget>[
              Tab(text: 'Profesi'),
              Tab(text: 'Maal'),
              Tab(text: 'Fitrah')
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ZakatProfesiPage(),
            ZakatMaalPage(),
            ZakatFitrahPages()
          ],
        ),
      ),
    );
  }
}
