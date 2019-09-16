import 'dart:convert';

import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart'
as blocLembagaAmal;
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/models/requestVAModel.dart';
import 'package:flutter_jaring_ummat/src/services/lembagaAmalApi.dart';
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
  final double nilaiZakat;

  InputBill(
      {this.type,
        this.customerName,
        this.customerEmail,
        this.customerPhone,
        this.programId,
        this.programName,
        this.nilaiZakat});

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
  String idLembagaAmal;

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
                TextSpan(text: 'Rp ', style: TextStyle(color: grayColor)),
                TextSpan(
                  text: '1.250',
                  style:
                  TextStyle(fontWeight: FontWeight.bold, color: blackColor),
                ),
              ]),
            ),
          ],
        ),
      ),
    );

    final info = Center(
      child: Text('Maks. Saldo Jejaring Cash Rp 2.000.000'),
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
              Text('Informasi Lembaga Amal',
                  style: TextStyle(
                      color: greenColor, fontWeight: FontWeight.bold)),
              Icon(Icons.info_outline)
            ],
          ),
          galangAmalSelect(),
//          TextField(
//            readOnly: true,
//            controller: programName,
//            decoration: InputDecoration(
//                hasFloatingPlaceholder: true,
//                labelText: 'Nama Galang Amal',
//                prefixIcon:
//                    Icon(ProfileInboxIcon.saved_galang_amal_3x, size: 20)),
//          ),
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
                  widget.programId != null
                      ? widget.programName
                      : _lembagaAmalModel.lembagaAmalName,
                  nominalCtrl.numberValue,
                  customerEmail.text,
                  customerName.text,
                  customerPhone.text,
                  widget.programId != null
                      ? widget.programId
                      : _lembagaAmalModel.idLembagaAmal,
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
                widget.programId == null ? informasiProgram : new Container(),
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

  LembagaAmalProvider _lembagaAmalProvider = new LembagaAmalProvider();

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  DirectSelectItem<String> getDropDownMenuItem(String value) {
    return DirectSelectItem<String>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Text(value);
        });
  }

  Widget testingSelectDropDown() {
    return Container(
      child: DirectSelectContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 150.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(left: 4),
                      child: Text("City"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                  child: DirectSelectList<String>(
                                      values: [
                                        'testing',
                                        'testing1',
                                        'testing2'
                                      ],
                                      defaultItemIndex: 3,
                                      itemBuilder: (String value) =>
                                          getDropDownMenuItem(value),
                                      focusedItemDecoration:
                                      _getDslDecoration(),
                                      onItemSelectedListener:
                                          (item, index, context) {
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(content: Text(item)));
                                      }),
                                  padding: EdgeInsets.only(left: 12)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.unfold_more,
                                color: Colors.black38,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getListLembagaAmil() async {
    await _lembagaAmalProvider.getListLembagaAmalByFollowed().then((response) {
      print('Reponse Get Mater Program Amal:');
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var list = (json.decode(response.body) as List)
            .map((data) => new LembagaAmalModel.fromJson(data))
            .toList();
        setState(() {
          _lembagaAmalList = list;
        });
      }
    });
  }

  LembagaAmalModel _lembagaAmalModel;
  List<LembagaAmalModel> _lembagaAmalList = new List<LembagaAmalModel>();
  Map _lembagaAmalModelValueSend = new Map();

  Widget galangAmalSelect() {
    return new DropdownButtonFormField<LembagaAmalModel>(
      decoration: InputDecoration(
        hintText: "Nama Lembaga Amal",
        contentPadding: EdgeInsets.all(9.0),
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(10.0),
          borderSide: new BorderSide(),
        ),
      ),
      onChanged: (LembagaAmalModel newValue) {
        setState(() {
          _lembagaAmalModel = newValue;
          _lembagaAmalModelValueSend = {
            'idLembagaAmal': newValue.idLembagaAmal,
            'lembagaAmalName': newValue.lembagaAmalName
          };
        });
      },
      value: _lembagaAmalModel,
      items: _lembagaAmalList == null
          ? new Text("Tidak Ditemukan Data")
          : _lembagaAmalList.map((LembagaAmalModel value) {
        return new DropdownMenuItem<LembagaAmalModel>(
          value: value,
          child: new Text(value.lembagaAmalName,
              style:
              new TextStyle(fontFamily: "Poppins", fontSize: 13.0)),
        );
      }).toList(),
    );
  }

//  Widget testing() {
//    return Padding(
//        child: DirectSelectList<String>(
//            values: _cities,
//            defaultItemIndex: 3,
//            itemBuilder: (String value) =>
//                getDropDownMenuItem(value),
//            focusedItemDecoration:
//            _getDslDecoration(),
//            onItemSelectedListener:
//                (item, index, context) {
//              Scaffold.of(context).showSnackBar(
//                  SnackBar(content: Text(item)));
//            }),
//        padding: EdgeInsets.only(left: 12));
//  }

  @override
  void initState() {
    super.initState();
    setState(() {
      double total = 0.0;
      if (widget.nilaiZakat != null) {
        total = (widget.nilaiZakat * 10);
      }
      customerName.text = widget.customerName;
      customerEmail.text = widget.customerEmail;
      customerPhone.text = widget.customerPhone;
      programName.text = widget.programName;
      widget.nilaiZakat != null
          ? nominalCtrl.text = total.toString()
          : nominalCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');
      _loadingVisible = false;
      getListLembagaAmil();
    });
  }
}
