import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/galang_amal_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_payment/payment.dart';

import 'package:flutter_jaring_ummat/src/views/page_virtual_account/input_bill.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GalangAmalView extends StatefulWidget {
  final ProgramAmalModel programAmal;

  GalangAmalView({Key key, this.programAmal});

  @override
  _GalangAmalState createState() => _GalangAmalState();
}

class _GalangAmalState extends State<GalangAmalView> {
  /*
   * Text Field Money Formatter
   */
  var nominalCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');

  /*
   * Variable Temp
   */
  String emailCustomer;
  String customerName;
  String customerPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 1.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(NewIcon.back_big_3x, color: blackColor, size: 20),
        ),
        title: new Text('Galang Amal', style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize)),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          GalangAmalContainer(programAmal: widget.programAmal)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Container(
          height: 75.0,
          child: new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Donasi terkumpul',
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        ),
                        Text(
                          'Rp. ' +
                              '${CurrencyFormat().data.format(widget.programAmal.totalDonation.toDouble())}' +
                              ' / ' +
                              '${CurrencyFormat().data.format(widget.programAmal.targetDonation.toDouble())}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Batas waktu ' + widget.programAmal.endDate.toString(),
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        )
                      ],
                    ),
                    RaisedButton(
                      onPressed: () {
                        print("Program Amal");
                        print(widget.programAmal.titleProgram);
                        print(widget.programAmal.idLembagaAmal);
                        requestBill("donasi");
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      color: greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        child: Text('Kirim Donasi'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void requestBill(String type) {
//    Navigator.of(context).push(MaterialPageRoute(
//      builder: (context) => InputBill(
//        type: type,
//        customerName: customerName,
//        customerEmail: emailCustomer,
//        customerPhone: customerPhone,
//        programId: widget.programAmal.idProgram,
//        programName: widget.programAmal.titleProgram,
//      ),
//    ));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PaymentPage(
        customerName: customerName,
        customerContact: customerPhone,
        customerEmail: emailCustomer,
        toLembagaName: widget.programAmal.createdBy,
        toGalangAmalName: widget.programAmal.titleProgram,
        toGalangAmalId: widget.programAmal.idProgram,
        toLembagaId: widget.programAmal.idLembagaAmal,
        type: 'donasi',
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      emailCustomer = _pref.getString(EMAIL_KEY);
      customerName = _pref.getString(FULLNAME_KEY);
      customerPhone = _pref.getString(CONTACT_KEY);
    });
  }
}
