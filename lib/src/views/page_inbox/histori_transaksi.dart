import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/historiTransaksiModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/historiTransaksiBloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_payment/instruksi_pembayaran.dart';

class HistoriTransaksiView extends StatefulWidget {
  @override
  _HistoriTransaksiViewState createState() => _HistoriTransaksiViewState();
}

class _HistoriTransaksiViewState extends State<HistoriTransaksiView>
    with TickerProviderStateMixin {
  /*
   * Animation Controller
   */
  AnimationController _animationController;

  /*
   * Variable Temp
   */
  int count;

  var formatter = new DateFormat('dd MMMM yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Pembayaran Donasi',
                style: TextStyle(
                    color: blackColor, fontSize: SizeUtils.titleSize)),
            Text('Dalam Proses',
                style: TextStyle(
                    color: grayColor, fontSize: SizeUtils.titleSize - 6)),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(NewIcon.back_small_2x),
          color: blackColor,
          iconSize: 20,
        ),
      ),
      body: StreamBuilder(
        stream: bloc.streamHistory,
        builder:
            (context, AsyncSnapshot<List<HistoriTransaksiModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('');
              break;
            default:
              if (snapshot.hasData) {
                return listBuilder2(snapshot.data);
              }
              return Center(
                child: Text('NO HISTORY DATA'),
              );
          }
        },
      ),
    );
  }

  Widget listBuilder2(List<HistoriTransaksiModel> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: new SizedBox(
            height: 10.0,
            child: new Center(
              child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.grey[200]),
            ),
          ),
        );
      },
      itemCount: snapshot.length,
      itemBuilder: (context, index) {
        var data = snapshot[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Card(
            elevation: 1,
            color: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              // height: screenHeightExcludingToolbar(context, dividedBy: 4),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    child: ListTile(
                      title: const Text(
                        'Lakukan Pembayaran Sebelum',
                        style: TextStyle(
                            fontSize: 12),
                      ),
                      subtitle: Text(
                        '${formatter.format(DateTime.fromMicrosecondsSinceEpoch(data.tanggalBerakhirVa * 1000))} WIB',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: data.totalMenitCounting <= 1
                          ? OutlineButton(
                        onPressed: null,
                        child: const Text(
                          'Expired',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      )
                          : OutlineButton(
                        onPressed: () {
                          print("Batalkan On Progress");
                        },
                        child: const Text('Batalkan',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.red)),
                        borderSide: BorderSide(
                          color: Colors.red, //Color of the border
                          style: BorderStyle.solid, //Style of the border
                          width: 2.8, //width of the border
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Column(children: <Widget>[
                        ListTile(
                          title: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: '${data.jenisTransaksi}\n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                              ),
                              data.jenisTransaksi == 'DONASI'
                                  ? TextSpan(
                                  text: '${data.donasiTitle}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ))
                                  : TextSpan(
                                  text: 'Pembayaran ${data.jenisTransaksi}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                  ))
                            ]),
                          ),
                          subtitle: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Rp ',
                                style:
                                TextStyle(color: Colors.grey, fontSize: 11),
                              ),
                              TextSpan(
                                text:
                                '${CurrencyFormat().currency(data.jumlahTransaksi.toDouble())}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: data.jenisTransaksi == "ZAKAT"
                                ? Colors.yellow
                                : data.jenisTransaksi == "INFAQ"
                                ? Colors.redAccent
                                : data.jenisTransaksi == "SODAQOH"
                                ? Colors.deepPurple
                                : data.jenisTransaksi == "WAKAF"
                                ? Colors.green
                                : data.jenisTransaksi == "DONASI"
                                ? Colors.blue
                                : Colors.blue,
                            child: Icon(
                              data.jenisTransaksi == "ZAKAT"
                                  ? ProfileInboxIcon.zakat_3x
                                  : data.jenisTransaksi == "INFAQ"
                                  ? ProfileInboxIcon.infaq_3x
                                  : data.jenisTransaksi == "SODAQOH"
                                  ? ProfileInboxIcon.sodaqoh_3x
                                  : data.jenisTransaksi == "WAKAF"
                                  ? ProfileInboxIcon.wakaf_3x
                                  : data.jenisTransaksi == "DONASI"
                                  ? ProfileInboxIcon.donation_3x
                                  : ProfileInboxIcon
                                  .donation_3x,
                              color: whiteColor,
                              size: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 70.0),
                          child: new SizedBox(
                            height: 10.0,
                            child: new Center(
                              child: new Container(
                                  margin: new EdgeInsetsDirectional.only(
                                      start: 1.0, end: 1.0),
                                  height: 5.0,
                                  color: Colors.grey[200]),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('BNI Syariah VA Billing',
                              style: TextStyle(fontSize: 12)),
                          subtitle: Text(
                            '${data.virtualAccount}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: blackColor),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            backgroundImage: NetworkImage(
                                'https://2.bp.blogspot.com/-qy7Sanutml0/WmXk88IBzNI/AAAAAAAANyg/2fENOvWf5bUgTD8T7FEAzotvjdmusMZYACLcBGAs/s600/Bank-BNI-Syariah-Logo.jpg'),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 7.0),
                              child: OutlineButton(
                                onPressed: () {
                                  print("Salin");
                                },
                                child: const Text('Salin',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple)),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple,
                                  //Color of the border
                                  style: BorderStyle.solid,
                                  //Style of the border
                                  width: 0.8, //width of the border
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7.0),
                              child: OutlineButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => InstruksiPembayaran(
                                        transaksiId: data.idTransaksi,
                                        nominal:
                                        data.jumlahTransaksi.toDouble(),
                                        tanggalRequest:
                                        data.tanggalTransaksi.toString(),
                                        toLembagAmal: data.namaLembagaAmal,
                                        counting: data.totalMenitCounting,
                                        virtualNumber: data.virtualAccount,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Cara Pembayaran',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.green)),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                  //Color of the border
                                  style: BorderStyle.solid,
                                  //Style of the border
                                  width: 2.8, //width of the border
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ],
                        )
                      ])),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget listBuilder(List<HistoriTransaksiModel> snapshot) {
    return ListView.separated(
      itemCount: snapshot.length,
      shrinkWrap: true,
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: new SizedBox(
            height: 10.0,
            child: new Center(
              child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: softGreyColor),
            ),
          ),
        );
      },
      itemBuilder: (context, index) {
        var data = snapshot[index];
        return ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: data.jenisTransaksi == "ZAKAT"
                ? Colors.yellow
                : data.jenisTransaksi == "INFAQ"
                ? Colors.redAccent
                : data.jenisTransaksi == "SODAQOH"
                ? Colors.deepPurple
                : data.jenisTransaksi == "WAKAF"
                ? Colors.green
                : data.jenisTransaksi == "DONASI"
                ? Colors.blue
                : Colors.blue,
            child: Icon(
              data.jenisTransaksi == "ZAKAT"
                  ? ProfileInboxIcon.zakat_3x
                  : data.jenisTransaksi == "INFAQ"
                  ? ProfileInboxIcon.infaq_3x
                  : data.jenisTransaksi == "SODAQOH"
                  ? ProfileInboxIcon.sodaqoh_3x
                  : data.jenisTransaksi == "WAKAF"
                  ? ProfileInboxIcon.wakaf_3x
                  : data.jenisTransaksi == "DONASI"
                  ? ProfileInboxIcon.donation_3x
                  : ProfileInboxIcon.donation_3x,
              color: whiteColor,
              size: 20,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Rp ',
                        style: TextStyle(fontSize: 11, color: grayColor)),
                    TextSpan(
                      text:
                      '${CurrencyFormat().currency(data.jumlahTransaksi.toDouble())}',
                      style: TextStyle(
                          color: blackColor, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                '${data.jenisTransaksi} - ${data.namaLembagaAmal}',
                style: TextStyle(
                    fontSize: 11,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${data.donasiTitle}',
                style: TextStyle(
                    fontSize: 11,
                    color: grayColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: <Widget>[
            ListTile(
              title: Text('${data.virtualAccount}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              subtitle: Text(
                'BNI Syariah VA Billing',
                style: TextStyle(fontSize: 11),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.redAccent,
                backgroundImage: NetworkImage(
                    'https://2.bp.blogspot.com/-qy7Sanutml0/WmXk88IBzNI/AAAAAAAANyg/2fENOvWf5bUgTD8T7FEAzotvjdmusMZYACLcBGAs/s600/Bank-BNI-Syariah-Logo.jpg'),
              ),
              trailing: OutlineButton(
                onPressed: () {},
                child: const Text('Salin',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: ListTile(
                title: const Text(
                  'Lakukan Pembayaran Sebelum',
                  style: TextStyle(fontSize: 11),
                ),
                subtitle: Text(
                  formatter.format(
                    DateTime.fromMicrosecondsSinceEpoch(
                        data.tanggalBerakhirVa * 1000),
                  ),
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold),
                ),
                trailing: data.totalMenitCounting <= 1
                    ? OutlineButton(
                  onPressed: null,
                  child: const Text(
                    'Expired',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )
                    : OutlineButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InstruksiPembayaran(
                          transaksiId: data.idTransaksi,
                          nominal: data.jumlahTransaksi.toDouble(),
                          tanggalRequest:
                          data.tanggalTransaksi.toString(),
                          toLembagAmal: data.namaLembagaAmal,
                          counting: data.totalMenitCounting,
                          virtualNumber: data.virtualAccount,
                        ),
                      ),
                    );
                  },
                  child: const Text('Pembayaran',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(days: 1));
    startTimer();
    bloc.fetchHistoryTransaksi("waiting");
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
    return '${duration.inHours} Jam : ${(duration.inMinutes % 60).toString().padLeft(2, '0')} Menit : ${(duration.inSeconds % 60).toString().padLeft(2, '0')} Detik';
  }
}

// ListTile(
//           leading: CircleAvatar(
//             backgroundColor: data.jenisTransaksi == "ZAKAT"
//                 ? Colors.yellow
//                 : data.jenisTransaksi == "INFAQ"
//                     ? Colors.redAccent
//                     : data.jenisTransaksi == "SODAQOH"
//                         ? Colors.deepPurple
//                         : data.jenisTransaksi == "WAKAF"
//                             ? Colors.green
//                             : data.jenisTransaksi == "DONASI"
//                                 ? Colors.blue
//                                 : Colors.blue,
//             child: Icon(
//               data.jenisTransaksi == "ZAKAT"
//                   ? ProfileInboxIcon.zakat_3x
//                   : data.jenisTransaksi == "INFAQ"
//                       ? ProfileInboxIcon.infaq_3x
//                       : data.jenisTransaksi == "SODAQOH"
//                           ? ProfileInboxIcon.sodaqoh_3x
//                           : data.jenisTransaksi == "WAKAF"
//                               ? ProfileInboxIcon.wakaf_3x
//                               : data.jenisTransaksi == "DONASI"
//                                   ? ProfileInboxIcon.donation_3x
//                                   : ProfileInboxIcon.donation_3x,
//               color: whiteColor,
//               size: 20,
//             ),
//           ),
//           title: data.donasiTitle == null
//               ? Text("${data.jenisTransaksi}",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))
//               : Text(data.donasiTitle,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
//           isThreeLine: true,
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                   'Jumlah Transaksi ${CurrencyFormat().currency(data.jumlahTransaksi.toDouble())}'),
//               Text('${data.jenisTransaksi}'),
//             ],
//           ),
//           trailing: data.totalMenitCounting <= 1 ? RaisedButton(
//             onPressed: null,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
//             color: greenColor,
//             child: Text('Waktu Habis', style: TextStyle(color: whiteColor)),
//           ) : RaisedButton(
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                 builder: (context) => InstruksiPembayaran(
//                     transaksiId: data.idTransaksi,
//                     nominal: data.jumlahTransaksi.toDouble(),
//                     tanggalRequest: data.tanggalTransaksi.toString(),
//                     toLembagAmal: data.namaLembagaAmal,
//                     counting: data.totalMenitCounting,
//                     virtualNumber: data.virtualAccount),
//               ));
//             },
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
//             color: greenColor,
//             child: Text('Bayar', style: TextStyle(color: whiteColor)),
//           ),
//         );

// Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//           child: Card(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             child: Container(
//               width: screenWidth(context),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20), color: greenColor),
//               child: Column(
//                 children: <Widget>[
//                   data.totalMenitCounting <= 1
//                       ? Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(20),
//                               topLeft: Radius.circular(20),
//                             ),
//                           ),
//                           width: screenWidth(context),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 5, right: 5, top: 7, bottom: 3),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Center(
//                                       child: Text('Waktu Habis',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.redAccent,
//                                               fontWeight: FontWeight.bold)),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       : Container(
//                           decoration: BoxDecoration(
//                             color: Colors.grey[100],
//                             borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(20),
//                               topLeft: Radius.circular(20),
//                             ),
//                           ),
//                           width: screenWidth(context),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 17, right: 15, top: 7, bottom: 3),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     const Text('Lakukan Pembayaran Sebelum',
//                                         style: TextStyle(
//                                             color: Colors.grey, fontSize: 11)),
//                                     Text(
//                                         formatter.format(
//                                             DateTime.fromMicrosecondsSinceEpoch(
//                                                 data.tanggalBerakhirVa * 1000)),
//                                         style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.redAccent,
//                                             fontWeight: FontWeight.bold))
//                                   ],
//                                 ),
//                                 OutlineButton(
//                                   onPressed: () {},
//                                   color: whiteColor,
//                                   child: const Text('Batalkan',
//                                       style: TextStyle(
//                                           color: Colors.redAccent,
//                                           fontWeight: FontWeight.bold)),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20)),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                   Container(
//                     width: screenWidth(context),
//                     color: whiteColor,
//                     child: Column(
//                       children: <Widget>[
//                         ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: data.jenisTransaksi == "ZAKAT"
//                                 ? Colors.yellow
//                                 : data.jenisTransaksi == "INFAQ"
//                                     ? Colors.redAccent
//                                     : data.jenisTransaksi == "SODAQOH"
//                                         ? Colors.deepPurple
//                                         : data.jenisTransaksi == "WAKAF"
//                                             ? Colors.green
//                                             : data.jenisTransaksi == "DONASI"
//                                                 ? Colors.blue
//                                                 : Colors.blue,
//                             child: Icon(
//                               data.jenisTransaksi == "ZAKAT"
//                                   ? ProfileInboxIcon.zakat_3x
//                                   : data.jenisTransaksi == "INFAQ"
//                                       ? ProfileInboxIcon.infaq_3x
//                                       : data.jenisTransaksi == "SODAQOH"
//                                           ? ProfileInboxIcon.sodaqoh_3x
//                                           : data.jenisTransaksi == "WAKAF"
//                                               ? ProfileInboxIcon.wakaf_3x
//                                               : data.jenisTransaksi == "DONASI"
//                                                   ? ProfileInboxIcon.donation_3x
//                                                   : ProfileInboxIcon
//                                                       .donation_3x,
//                               color: whiteColor,
//                               size: 20,
//                             ),
//                           ),
//                           title: RichText(
//                             text: TextSpan(
//                               children: <TextSpan>[
//                                 TextSpan(
//                                     text: 'Rp ',
//                                     style: TextStyle(
//                                         fontSize: 11, color: grayColor)),
//                                 TextSpan(
//                                   text:
//                                       '${CurrencyFormat().currency(data.jumlahTransaksi.toDouble())}',
//                                   style: TextStyle(
//                                       color: blackColor,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           subtitle: RichText(
//                             text: TextSpan(
//                               children: <TextSpan>[
//                                 TextSpan(
//                                     text:
//                                         '${data.jenisTransaksi} - ${data.namaLembagaAmal} \n',
//                                     style: TextStyle(
//                                         fontSize: 11,
//                                         color: blackColor,
//                                         fontWeight: FontWeight.bold)),
//                                 TextSpan(
//                                     text: '${data.donasiTitle}',
//                                     style: TextStyle(
//                                         fontSize: 11, color: grayColor)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         ListTile(
//                           title: Text(
//                             '${data.virtualAccount}',
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                                 color: blackColor),
//                           ),
//                           subtitle: Text('BNI Syariah VA Billing',
//                               style: TextStyle(fontSize: 11)),
//                           leading: CircleAvatar(
//                               backgroundColor: Colors.redAccent,
//                               backgroundImage: NetworkImage(
//                                   'https://2.bp.blogspot.com/-qy7Sanutml0/WmXk88IBzNI/AAAAAAAANyg/2fENOvWf5bUgTD8T7FEAzotvjdmusMZYACLcBGAs/s600/Bank-BNI-Syariah-Logo.jpg')),
//                           trailing: data.totalMenitCounting <= 1
//                               ? OutlineButton(
//                                   onPressed: null,
//                                   child: Text('Expired',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.deepPurple)),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20)),
//                                 )
//                               : OutlineButton(
//                                   onPressed: () {},
//                                   child: Text('Salin',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.deepPurple)),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20)),
//                                 ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: data.totalMenitCounting <= 1
//                                   ? softGreyColor
//                                   : greenColor,
//                               borderRadius: BorderRadius.only(
//                                 bottomRight: Radius.circular(20),
//                                 bottomLeft: Radius.circular(20),
//                               )),
//                           width: screenWidth(context),
//                           height: 40,
//                           child: data.totalMenitCounting <= 1
//                               ? Center()
//                               : Center(
//                                   child: InkWell(
//                                   onTap: () {
// Navigator.of(context)
//     .push(MaterialPageRoute(
//   builder: (context) => InstruksiPembayaran(
//       transaksiId: data.idTransaksi,
//       nominal:
//           data.jumlahTransaksi.toDouble(),
//       tanggalRequest:
//           data.tanggalTransaksi.toString(),
//       toLembagAmal: data.namaLembagaAmal,
//       counting: data.totalMenitCounting,
//       virtualNumber: data.virtualAccount),
// ));
//                                   },
//                                   child: Text('Cara Pembayaran',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           color: whiteColor)),
//                                 )),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
