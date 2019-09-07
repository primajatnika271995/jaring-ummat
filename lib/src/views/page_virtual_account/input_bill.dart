import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/requestVAModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_jaring_ummat/src/bloc/requestVABloc.dart';

class InputBill extends StatefulWidget {
  final String type;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String programId;
  final String programName;
  InputBill(
      {this.type,
      this.customerName,
      this.customerEmail,
      this.customerPhone,
      this.programId,
      this.programName});

  @override
  _InputBillState createState() => _InputBillState();
}

class _InputBillState extends State<InputBill> {
  /*
   * Text Field Money Formatter
   */
  var nominalCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');

  /*
   * Text Edit Controller
   */
  var customerName = new TextEditingController();
  var customerEmail = new TextEditingController();
  var customerPhone = new TextEditingController();
  var programName = new TextEditingController();

  /*
   * Boolen for Loading
   */
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    final mySaldo = Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: EdgeInsets.only(right: 6),
        padding: EdgeInsets.only(top: 3, bottom: 3),
        width: 500,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300], width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Text('SALDO JEJARING CASH'),
            SizedBox(
              height: 2,
            ),
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: 'Rp', style: TextStyle(color: grayColor)),
                TextSpan(
                  text: '1.250',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: blackColor),
                ),
              ]),
            ),
          ],
        ),
      ),
    );

    final info = Center(
      child: Text('Maks. Saldo Jejaring Cash Rp2.000.000'),
    );

    final nominalField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: TextField(
        controller: nominalCtrl,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: 'Silahkan isi nominal',
            hasFloatingPlaceholder: true,
            labelText: 'Nominal'),
      ),
    );

    final informasiDatadiri = Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Informasi Data Diri',
                  style: TextStyle(
                      color: greenColor, fontWeight: FontWeight.bold)),
              Icon(Icons.info_outline)
            ],
          ),
          TextField(
            readOnly: true,
            controller: customerName,
            decoration: InputDecoration(
                hasFloatingPlaceholder: true,
                labelText: 'Nama Lengkap',
                prefixIcon: Icon(NewIcon.edittext_name_3x, size: 20)),
          ),
          TextField(
            readOnly: true,
            controller: customerEmail,
            decoration: InputDecoration(
                hasFloatingPlaceholder: true,
                labelText: 'Email Anda',
                prefixIcon: Icon(Icons.mail_outline, size: 20)),
          ),
          TextField(
            readOnly: true,
            controller: customerPhone,
            decoration: InputDecoration(
                hasFloatingPlaceholder: true,
                labelText: 'Nomor Telepon',
                prefixIcon: Icon(NewIcon.edittext_phone_3x, size: 20)),
          ),
        ],
      ),
    );

    final informasiProgram = Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Informasi Galang Amal',
                  style: TextStyle(
                      color: greenColor, fontWeight: FontWeight.bold)),
              Icon(Icons.info_outline)
            ],
          ),
          TextField(
            readOnly: true,
            controller: programName,
            decoration: InputDecoration(
                hasFloatingPlaceholder: true,
                labelText: 'Nama Galang Amal',
                prefixIcon:
                    Icon(ProfileInboxIcon.saved_galang_amal_3x, size: 20)),
          ),
          Text(
              '*akan terisi secara otomatis saat melakukan donasi pada Program Amal',
              style: TextStyle(fontSize: 12)),
        ],
      ),
    );

    final sendBtn = StreamBuilder(
        stream: bloc.streamRequest,
        builder: (context, snapshot) {
          print('Snapshot : ${snapshot.hasData}');
          if (snapshot.hasData) {
            RequestVaModel value = snapshot.data;
            print('ini hasilnya statusnya :${value.status}');
            if (value.status == "001") {
              print('loading status :$_loadingVisible');
            }
          }
          return RaisedButton(
            onPressed: () {
              setState(() {
                _loadingVisible = true;
              });
              bloc.requestVA(
                  context,
                  nominalCtrl.numberValue,
                  customerEmail.text,
                  customerName.text,
                  customerPhone.text,
                  widget.programId,
                  widget.type);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            child: Text(
              'Kirim ${widget.type}',
              style: TextStyle(color: whiteColor),
            ),
            color: greenColor,
          );
        });

    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Hero(
        tag: 'Bill',
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            title: Text('Transaksi ${widget.type}',
                style: TextStyle(color: whiteColor)),
            backgroundColor: greenColor,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(NewIcon.back_small_2x),
              color: whiteColor,
              iconSize: 20,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                mySaldo,
                SizedBox(
                  height: 5,
                ),
                info,
                nominalField,
                SizedBox(
                  height: 10,
                ),
                informasiDatadiri,
                informasiProgram,
                SizedBox(
                  height: 10,
                ),
                sendBtn,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      customerName.text = widget.customerName;
      customerEmail.text = widget.customerEmail;
      customerPhone.text = widget.customerPhone;
      programName.text = widget.programName;
      _loadingVisible = false;
    });
  }
}
