import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/galang_amal_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';

import 'package:flutter_jaring_ummat/src/bloc/requestVABloc.dart';
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
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 1.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(NewIcon.back_big_3x, color: greenColor, size: 20),
        ),
        title: new Text('Galang Amal', style: TextStyle(color: blackColor)),
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
                              '${CurrencyFormat().currency(widget.programAmal.totalDonation.toDouble())}' +
                              ' / ' +
                              '${CurrencyFormat().currency(widget.programAmal.targetDonation.toDouble())}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Batas waktu ' + widget.programAmal.endDate,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        )
                      ],
                    ),
                    RaisedButton(
                      onPressed: showPayment,
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

  void showPayment() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        title: Text('Masukan nominal Donasi yang akan dikirimkan',
            textAlign: TextAlign.center),
        content: Container(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nominalCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Silahkan isi nominal'),
              ),
              SizedBox(
                height: 20,
              ),
              StreamBuilder(
                  stream: bloc.streamRequest,
                  builder: (context, snapshot) {
                    return RaisedButton(
                      onPressed: () {
                        print("============== DATA DONASI =================");
                        print("Nominal   : ${nominalCtrl.numberValue}");
                        print("Email     : $emailCustomer");
                        print("Name      : $customerName");
                        print("Phone     : $customerPhone");
                        print("Donasi ke : ${widget.programAmal.idProgram}");

                        bloc.requestVA(
                            context,
                            nominalCtrl.numberValue,
                            emailCustomer,
                            customerName,
                            customerPhone,
                            widget.programAmal.idProgram,
                            'donasi');
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45)),
                      child: Text(
                        'Request',
                        style: TextStyle(color: whiteColor),
                      ),
                      color: greenColor,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
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
