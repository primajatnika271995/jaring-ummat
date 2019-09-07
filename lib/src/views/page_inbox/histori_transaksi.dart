import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/historiTransaksiModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/historiTransaksiBloc.dart';

class HistoriTransaksiView extends StatefulWidget {
  @override
  _HistoriTransaksiViewState createState() => _HistoriTransaksiViewState();
}

class _HistoriTransaksiViewState extends State<HistoriTransaksiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0,
        elevation: 0,
        title: Text('Transaksi Histori', style: TextStyle(color: blackColor)),
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
              return Text('NO HISTORY DATA');
          }
        },
      ),
    );
  }

  Widget listBuilder(List<HistoriTransaksiModel> snapshot) {
    return ListView.separated(
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 80),
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
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = snapshot[index];
        return ListTile(
          leading: Icon(Icons.history, size: 30,),
          title: data.donasiTitle == null
              ? Text("Untuk ${data.jenisTransaksi}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))
              : Text(data.donasiTitle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          isThreeLine: true,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Jumlah Transaksi ${CurrencyFormat().currency(data.jumlahTransaksi.toDouble())}'),
              Text('${data.jenisTransaksi}'),
            ],
          ),
          trailing: RaisedButton(
            onPressed: () {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            color: greenColor,
            child: Text('Bayar', style: TextStyle(color: whiteColor)),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    bloc.fetchHistoryTransaksi();
  }
}
