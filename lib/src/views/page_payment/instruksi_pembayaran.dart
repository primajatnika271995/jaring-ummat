import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/calculator_other_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/requestVABloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';

class InstruksiPembayaran extends StatefulWidget {
  final String toLembagAmal;
  final double nominal;
  final String transaksiId;
  final String virtualNumber;
  final String tanggalRequest;
  final int counting;
  final int tanggalBerakhirVa;

  InstruksiPembayaran({
    Key key,
    this.toLembagAmal,
    this.nominal,
    this.transaksiId,
    this.virtualNumber,
    this.tanggalRequest,
    this.counting,
    this.tanggalBerakhirVa,
  }) : super(key: key);

  @override
  _InstruksiPembayaranState createState() =>
      _InstruksiPembayaranState(
        this.toLembagAmal,
        this.nominal,
        this.transaksiId,
        this.virtualNumber,
        this.counting,
        this.tanggalBerakhirVa,
      );
}

class _InstruksiPembayaranState extends State<InstruksiPembayaran>
    with TickerProviderStateMixin {
  final String toLembagaAmal;
  final double nominal;
  final String transaksiId;
  final String virtualNumber;
  final int counting;
  final int tanggalBerakhirVa;

  _InstruksiPembayaranState(this.toLembagaAmal, this.nominal, this.transaksiId,
      this.virtualNumber, this.counting, this.tanggalBerakhirVa);

  /*
   * Animation Controller
   */
  AnimationController _animationController;

  /*
   * Boolen for Loading
   */
  bool _loadingVisible = false;

  DateTime tanggalBerakhir = null;

  final String bniLogo =
      'https://2.bp.blogspot.com/-qy7Sanutml0/WmXk88IBzNI/AAAAAAAANyg/2fENOvWf5bUgTD8T7FEAzotvjdmusMZYACLcBGAs/s600/Bank-BNI-Syariah-Logo.jpg';

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(NewIcon.back_small_2x),
            iconSize: 20,
            color: blackColor,
          ),
          title: const Text('Instruksi Pembayaran',
              style: TextStyle(
                  fontSize: SizeUtils.titleSize, color: Colors.black)),
          backgroundColor: whiteColor,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
                expandedHeight: 0.0,
                backgroundColor: whiteColor,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(72.0),
                  child: pemberiDonasi(),
                )),
            new SliverList(
                delegate: SliverChildListDelegate([
                  Column(children: <Widget>[
                    jumlahTagihan(),
                    nomorVirtualAccount(),
                    panduanPembayaran()
                  ])
                ]))
          ],
        ),
      ),
    );
  }

  Widget pemberiDonasi() {
    return Container(
      // color: Colors.pink,
      width: screenWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300], width: 1),
                  color: Colors.red),
              child: ListTile(
                title: Text('Lakukan pembayaran dalam waktu',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    )),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (_, child) {
                        return Text(timerString,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16));
                      },
                    ),
                    Text('atau sebelum $tanggalBerakhir',
                        style: TextStyle(fontSize: 11, color: Colors.white))
                  ],
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(CalculatorOtherIcon.edittext_loan_3x,
                      color: Colors.redAccent, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget jumlahTagihan() {
    return Container(
      // color: Colors.pink,
      width: screenWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: const Text('Jumlah Tagihan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300], width: 3),
                borderRadius: BorderRadius.circular(13),
              ),
              child: ListTile(
                title: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'Rp ',
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    TextSpan(
                      text: '${CurrencyFormat().currency(nominal)}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeUtils.titleSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
                subtitle: Text('Penerima : $toLembagaAmal',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    ProfileInboxIcon.donation_3x,
                    color: whiteColor,
                    size: 20,
                  ),
                ),
                trailing: OutlineButton(
                  onPressed: () {},
                  child: const Text('Details',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget nomorVirtualAccount() {
    return Container(
      // color: Colors.pink,
      width: screenWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: const Text('Nomor Virtual Account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: screenWidth(context),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300], width: 3),
                borderRadius: BorderRadius.circular(13),
              ),
              child: ListTile(
                title: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: '$virtualNumber',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),
                subtitle: Text('BNI Syariah VA Billing',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
                leading: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  backgroundImage: NetworkImage(bniLogo),
                ),
                trailing: OutlineButton(
                  onPressed: () {},
                  child: const Text('Salin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget panduanPembayaran() {
    return Container(
      // color: Colors.pink,
      width: screenWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15, bottom: 10),
            child: const Text('Panduan Pembayaran',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          ExpansionTile(
            title: const Text('Mobile Banking BNI Syariah',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          ExpansionTile(
            title: const Text('SMS Banking',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          ExpansionTile(
            title: const Text('ATM BNI Syariah',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          ExpansionTile(
            title: const Text('ATM Bersama',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          ExpansionTile(
            title: const Text('Bank Lain',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: ListTile(
              title: const Text(
                  'Mohon tidak memberikan data pembayaran kepada pihak manapun kecuali Jejaring!',
                  style: TextStyle(color: Colors.redAccent, fontSize: 11)),
              leading: Icon(Icons.info_outline, color: Colors.redAccent),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              child: RaisedButton(
                onPressed: () async {
                  setState(() {
                    _loadingVisible = true;
                  });
                  bloc.pembayaran(widget.transaksiId, widget.virtualNumber);
                  await Future.delayed(Duration(seconds: 3));
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45)),
                child: Text(
                  'Update Status Pembayaran',
                  style: TextStyle(color: whiteColor),
                ),
                color: greenColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    if (tanggalBerakhirVa == null) {
      setState(() {
        tanggalBerakhir = DateTime.parse(new DateTime.now().add(Duration(days: 1)).toString());
      });
    } else {
      setState(() {
        tanggalBerakhir =
            DateTime.fromMicrosecondsSinceEpoch(tanggalBerakhirVa * 1000);
      });
    }
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(minutes: counting == null ? 1440 : counting));
    startTimer();
    setState(() {
      _loadingVisible = false;
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      if (_animationController.isAnimating) {
        _animationController.stop();
      } else {
        _animationController.reverse(
            from: _animationController.value == 0.0
                ? 1.0
                : _animationController.value);
      }
    });
  }

  String get timerString {
    Duration duration =
        _animationController.duration * _animationController.value;
    return '${duration.inHours} Jam : ${(duration.inMinutes % 60)
        .toString()
        .padLeft(2, '0')} Menit : ${(duration.inSeconds % 60)
        .toString()
        .padLeft(2, '0')} Detik';
  }
}
