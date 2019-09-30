import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/historiTransaksiModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/historiTransaksiBloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';

class ExpiredTransaksi extends StatefulWidget {
  @override
  _ExpiredTransaksiState createState() => _ExpiredTransaksiState();
}

class _ExpiredTransaksiState extends State<ExpiredTransaksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        title: Text('Amal Dibatalkan',
            style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize)),
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
                return listBuilder(snapshot.data);
              }
              return Center(
                child: Text('NO EXPIRED DATA'),
              );
          }
        },
      ),
    );
  }

  Widget listBuilder(List<HistoriTransaksiModel> snapshot) {
    return ListView.separated(
      itemCount: snapshot.length,
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 0),
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
      itemBuilder: (context, index) {
        var data = snapshot[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Card(
            elevation: 2,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: 'Rp ',
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                          TextSpan(
                            text:
                                '${CurrencyFormat().currency(data.jumlahTransaksi.toDouble())}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                      subtitle: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text:
                                '${data.jenisTransaksi} - ${data.namaLembagaAmal} \n',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          TextSpan(
                              text: '${data.donasiTitle}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              )),
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
                                              : ProfileInboxIcon.donation_3x,
                          color: whiteColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    bloc.fetchHistoryTransaksi("failed");
  }
}
