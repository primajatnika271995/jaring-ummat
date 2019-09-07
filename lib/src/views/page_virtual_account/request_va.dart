import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/requestVABloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';

class RequestVA extends StatefulWidget {
  final double nominal;
  final String transaksiId;
  final String virtualNumber;
  RequestVA({@required this.nominal, this.virtualNumber, this.transaksiId});

  @override
  _RequestVAState createState() => _RequestVAState();
}

class _RequestVAState extends State<RequestVA> {
  bool _loadingVisible = false;
  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor,
          title: Text('Pembayaran Virtual Account BNI'),
          titleSpacing: 0,
          elevation: 0,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                color: greenColor,
                child: Column(
                  children: <Widget>[
                    Icon(
                      ProfileInboxIcon.donation_3x,
                      size: 45.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Total Nominal Pembayaran',
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    ),
                    Text(
                      'Rp ${CurrencyFormat().currency(widget.nominal)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 2.0),
                            child: Text(
                              'Kode Virtual Account',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: grayColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 2.0),
                            child: Text(
                              '${widget.virtualNumber}',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 15.0),
                            child: Text(
                              'BNI Virtual Account',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: grayColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.only(right: 10.0),
                          child: RaisedButton(
                            onPressed: () {
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                message: 'Code Virtual Account Copy',
                                duration: Duration(seconds: 3),
                              )..show(context);
                            },
                            color: greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              child: Text(
                                'Salin Kode',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    color: Colors.white,
                  ),
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                    child: new Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15.0,
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
                                'Selesaikan pembayaran zakat Anda sebelum tanggal 09 Januari 2018 pukul 10.19 WIB.',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: grayColor,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.0,
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
                                'Pembayaran Zakat ini akan otomatis terbatalkan apabila Anda tidak melakukan pembayaran sebelum waktu yang ditentukan tersebut.',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: grayColor,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  color: Colors.white,
                ),
                child: new Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                  child: new Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15.0,
                      ),
                      Column(
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Cara Pembayaran',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        child: Text(
                          'Pilih Cara pembayaran dan lakukan pembayaran sesuai kode Virtual Account',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: grayColor,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      ExpansionTile(
                        title: Text(
                          'ATM BNI',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        children: <Widget>[
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
                                  'Masukkan kartu Anda',
                                  style: TextStyle(
                                      fontSize: 12.0,
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
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: new Text(
                                  'Pilih Bahasa',
                                  style: TextStyle(
                                      fontSize: 12.0,
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
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: new Text(
                                  'Masukkan PIN ATM anda',
                                  style: TextStyle(
                                      fontSize: 12.0,
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
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: new Text(
                                  'Pilih Menu "Lainnya"',
                                  style: TextStyle(
                                      fontSize: 12.0,
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
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: new Text(
                                  'Pilih "Transfer"',
                                  style: TextStyle(
                                      fontSize: 12.0,
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
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: new Text(
                                  'Pilih "Rekening Tabungan"',
                                  style: TextStyle(
                                      fontSize: 12.0,
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
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: new Text(
                                  'Pilih "ke Rekening BNI Syariah"',
                                  style: TextStyle(
                                      fontSize: 12.0,
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
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: new Text(
                                  'Masukan nomor rekening tujuan dengan 16 digit Kode Virtual Account .(Contoh: 82277081205678)',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    'Jika sudah melakukan pembayar melalui VA diatas, silahkan untuk mengkonfirm status anda.',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
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
                    'Confirm',
                    style: TextStyle(color: whiteColor),
                  ),
                  color: blueColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadingVisible = false;
    });
  }
}
