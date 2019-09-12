import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/masterNilaiZakatFitrahModel.dart';
import 'package:flutter_jaring_ummat/src/models/zakatProfesiModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/services/kalkulatorZakatApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/calculator_other_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_virtual_account/input_bill.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZakatFitrahPages extends StatefulWidget {
  @override
  _ZakatFitrahPagesState createState() => _ZakatFitrahPagesState();
}

class _ZakatFitrahPagesState extends State<ZakatFitrahPages> {
  /*
   * Text Controller
   */
  final jumlahOrangCtrl = new TextEditingController();
  final hargaBerasCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');

  /*
   * Form State
   */
  final _key = new GlobalKey<FormState>();

  /*
   * Varible Tmp
   */
  double totalZakat = 0;
  double berasLiter = double.parse('0.0');
  double berasKilogram = double.parse('0.0');

  int selectedBeras = 0;

  /*
   * Boolean Hiden Data
   */

  bool hidenNominal = true;

  /*
   * Provider Data Api
   */
  KalkulatorZakatProvider _provider = new KalkulatorZakatProvider();
  int _radioValue = 0;
  double _hargaBeras;
  String _berasPer = "Kilogram";

  /*
   * Variable Temp
   */
  String emailCustomer;
  String customerName;
  String customerPhone;
  String nilaiZakat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: '00',
                      labelText: 'Jumlah Orang',
                      hasFloatingPlaceholder: true,
                      icon: Icon(CalculatorOtherIcon.edittext_people_3x)),
                  controller: jumlahOrangCtrl,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Jumlah Orang tidak boleh kosong.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.all(0.0),
                      enabled: false,
                      hintText: 'Pilih Satuan Beras',
                      labelText: 'Pilih Satuan Beras',
                      hasFloatingPlaceholder: true,
                      icon: Icon(CalculatorOtherIcon.edittext_option_3x)),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: new Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: (int value) {
                              setState(() {
                                _berasPer = "Kilogram";
                                _radioValue = value;
                                _hargaBeras = berasKilogram;
                                hargaBerasCtrl.text = berasKilogram.toString();
                              });
                            },
                          ),
                        ),
                        new Text(
                          'Kilogram',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ]),
                      new Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: new Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: (int value) {
                              setState(() {
                                _berasPer = "Liter";
                                _radioValue = value;
                                _hargaBeras = berasLiter;
                                hargaBerasCtrl.text = berasLiter.toString();
                              });
                            },
                          ),
                        ),
                        new Text(
                          'Liter',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ])
                    ]),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      hintText: 'Rp',
                      labelText: 'Harga Beras di Pasaran per $_berasPer',
                      hasFloatingPlaceholder: true,
                      icon: Icon(CalculatorOtherIcon.edittext_price_rice_3x)),
                  controller: hargaBerasCtrl,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  onPressed: () {
                    hitung();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45)),
                  child: const Text('Hitung',
                      style: TextStyle(color: Colors.white)),
                  color: greenColor,
                  disabledColor: grayColor,
                  disabledTextColor: whiteColor,
                ),
                SizedBox(
                  height: 40,
                ),
                hidenNominal
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Kewajiban Zakat Fitrahmu',
                            style: TextStyle(color: grayColor),
                          ),
                          RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: 'Rp ',
                                  style: TextStyle(color: grayColor)),
                              TextSpan(
                                text:
                                    '${CurrencyFormat().currency(totalZakat)}',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: blackColor),
                              ),
                            ]),
                          ),
                          Text(
                            'Itulah besar nominal kewajiban zakatmu. yuk segera bayar kewajibanmu itu dengan menekan tombol "Bayar Zakat"',
                            style: TextStyle(color: grayColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                            onPressed: () {
                              requestBill('zakat');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)),
                            child: const Text('Bayar Zakat',
                                style: TextStyle(color: Colors.white)),
                            color: greenColor,
                            disabledColor: grayColor,
                            disabledTextColor: whiteColor,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      hidenNominal = true;
    });

    _provider.masterNilai().then((response) {
      if (response.statusCode == 200) {
        MasterNilaiZakatFitrahModel value =
            MasterNilaiZakatFitrahModel.fromJson(json.decode(response.body));
        setState(() {
          berasKilogram = value.kilogram.toDouble();
          berasLiter = value.liter.toDouble();
          _hargaBeras = berasKilogram;
          hargaBerasCtrl.text = berasKilogram.toString();
        });
      }
    });
    getUser();
    super.initState();
  }

  void hitung() {
    _provider
        .zakatFitrahApi(jumlahOrangCtrl.text, hargaBerasCtrl.numberValue)
        .then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        ZakatProfesiModel value =
            ZakatProfesiModel.fromJson(json.decode(response.body));
        setState(() {
          totalZakat = value.jumlahZakat;
          hidenNominal = false;
        });
      }
    });
  }

  void getUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      emailCustomer = _pref.getString(EMAIL_KEY);
      customerName = _pref.getString(FULLNAME_KEY);
      customerPhone = _pref.getString(CONTACT_KEY);
    });
  }

  Future requestBill(String type) {
    print('Total Zakat : $totalZakat');
    if (totalZakat <= 0) {
      return showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text('Nilai Zakat Andah Kurang Dari Rp. 0',
                style: TextStyle(fontSize: 14.0)),
            children: <Widget>[],
          );
        },
      );
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => InputBill(
          type: type,
          customerName: customerName,
          customerEmail: emailCustomer,
          customerPhone: customerPhone,
          programName: null,
          nilaiZakat: totalZakat),
    ));
  }
}
