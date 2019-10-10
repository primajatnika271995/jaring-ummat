import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:toast/toast.dart';

import '../views/components/icon_baru_icons.dart';

class PembayaranZakat extends StatefulWidget {

  String title;
  String nominal;
  IconData icon;

  PembayaranZakat({Key key, this.nominal, this.title, this.icon});

  @override
  _PembayaranZakatState createState() => _PembayaranZakatState();
}

class _PembayaranZakatState extends State<PembayaranZakat> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.icon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Pembayaran ${widget.title}',
            style: TextStyle(fontSize: 15.0),
          ),
          centerTitle: false,
          bottom: PreferredSize(
              child: new Container(
                child: Column(
                  children: <Widget>[
                    Icon(
                      widget.icon,
                      size: 45.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Nominal Pembayaran ${widget.title}',
                      style: TextStyle(
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      'Rp ${CurrencyFormat().data.format(double.parse(widget.nominal))}',
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
              preferredSize: null),
        ),
        preferredSize: Size.fromHeight(170.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                      color: Colors.grey,
                      offset: new Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0)
                ],
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
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.grey[400]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 2.0),
                          child: Text(
                            '8277081585940606',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 15.0),
                          child: Text(
                            'BNI Syariah Virtual Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.grey[400]),
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
                          },
                          color: Colors.blueAccent,
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
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.grey,
                        offset: new Offset(1.0, 1.0),
                        blurRadius: 5.0,
                        spreadRadius: 1.0)
                  ],
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
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
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                      color: Colors.grey,
                      offset: new Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0)
                ],
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
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ExpansionTile(
                      title: Text('ATM BNI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
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
          ],
        ),
      ),
    );
  }
}
