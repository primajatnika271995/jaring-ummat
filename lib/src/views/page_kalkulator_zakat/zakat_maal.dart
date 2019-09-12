import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/zakatProfesiModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/services/kalkulatorZakatApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/calculator_other_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_virtual_account/input_bill.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ZakatMaalPage extends StatefulWidget {
  @override
  _ZakatMaalPageState createState() => _ZakatMaalPageState();
}

class _ZakatMaalPageState extends State<ZakatMaalPage> {
  /*
   * Text Controller
   */
  final nilaiDepositoCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');
  final nilaiPropertiCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');
  final nilaiPerhiasanCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');
  final nilaiSahamCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');
  final nilaiHutangCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');


  /*
   * Form State
   */
  final _key = new GlobalKey<FormState>();

  /*
   * Varible Tmp
   */
  double totalZakat = 0;

  /*
   * Boolean Hiden Data
   */

  bool hidenNominal = true;

  /*
   * Provider Data Api
   */
  KalkulatorZakatProvider _provider = new KalkulatorZakatProvider();

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
                      hintText: 'Rp',
                      labelText: 'Nilai Deposito / Tabungan / Giro',
                      hasFloatingPlaceholder: true,
                      icon:
                          Icon(CalculatorOtherIcon.edittext_savings_3x)),
                  controller: nilaiDepositoCtrl,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Nilai Deposito tidak boleh kosong";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Rp',
                      labelText: 'Nilai properti & kendaraan (bukan yang digunakan sehari-hari)',
                      hasFloatingPlaceholder: true,
                      icon:
                          Icon(CalculatorOtherIcon.edittext_property_3x)),
                  controller: nilaiPropertiCtrl,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Rp',
                      labelText: 'Emas, perak, permata. atau sejenisnya',
                      hasFloatingPlaceholder: true,
                      icon: Icon(CalculatorOtherIcon.edittext_gold_3x)),
                  controller: nilaiPerhiasanCtrl,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Rp',
                      labelText: 'Lainnya (saham, piutang, dan surat-surat berharga lainnya)',
                      hasFloatingPlaceholder: true,
                      icon: Icon(CalculatorOtherIcon.edittext_another_salary_3x)),
                  controller: nilaiSahamCtrl,
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Rp',
                      labelText: 'Hutang pribadi yang jatuh tempo tahun ini',
                      hasFloatingPlaceholder: true,
                      icon: Icon(CalculatorOtherIcon.edittext_loan_3x)),
                  controller: nilaiHutangCtrl,
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
                hidenNominal ? Container() : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Kewajiban Zakat Maalmu',
                      style: TextStyle(color: grayColor),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: 'Rp ', style: TextStyle(color: grayColor)),
                        TextSpan(
                          text: '${CurrencyFormat().currency(totalZakat)}',
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: blackColor),
                        ),
                      ]),
                    ),
                    Text(
                      'Itulah besar nominal kewajiban zakatmu. Yuk segera bayar kewajibanmu itu dengan menekan tombol "Bayar Zakat"',
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
    getUser();
    super.initState();
  }

  void hitung() {
    _provider
        .zakatMaalApi(nilaiDepositoCtrl.numberValue, nilaiPropertiCtrl.numberValue, nilaiPerhiasanCtrl.numberValue, nilaiHutangCtrl.numberValue, nilaiSahamCtrl.numberValue)
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