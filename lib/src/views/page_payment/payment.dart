import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/lembagaAmalApi.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/calculator_other_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_payment/pembayaran_donasi.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class PaymentPage extends StatefulWidget {
  final String customerName;
  final String customerContact;
  final String customerEmail;
  final String toLembagaId;
  final String toLembagaName;
  final String toGalangAmalName;
  final String toGalangAmalId;
  final String type;
  final double nilaiZakat;

  PaymentPage(
      {Key key,
      this.customerName,
      this.customerContact,
      this.customerEmail,
      this.toLembagaId,
      this.toLembagaName,
      this.toGalangAmalName,
      this.toGalangAmalId,
      this.type,
      this.nilaiZakat})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState(
      this.customerName,
      this.customerContact,
      this.customerEmail,
      this.toLembagaName,
      this.toGalangAmalName,
      this.toGalangAmalId,
      this.type,
      this.toLembagaId);
}

class _PaymentPageState extends State<PaymentPage> {
  String customerName;
  String cutomerContact;
  String customerEmail;
  String toLembagaId;
  String toLembagaName;
  String toGalangAmalName;
  String toGalangAmalId;
  String type;

  _PaymentPageState(
      this.customerName,
      this.cutomerContact,
      this.customerEmail,
      this.toLembagaName,
      this.toGalangAmalName,
      this.toGalangAmalId,
      this.type,
      this.toLembagaId);

  /*
   * Background Img
   */
  final String bgUrl = 'assets/backgrounds/payment_accent_full_width.png';

  /*
   * Masking Money Edit Controller
   */
  var nominalCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');

  @override
  Widget build(BuildContext context) {
    final informasiProgram = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          galangAmalSelect(),
          Text(
              '*akan terisi secara otomatis saat melakukan donasi pada Program Amal',
              style: TextStyle(fontSize: 12)),
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            titleSpacing: 0,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(NewIcon.back_small_2x),
              iconSize: 20,
              color: blackColor,
            ),
            title: Text(
                'Nominal ${widget.type[0].toUpperCase()}${widget.type.substring(1)}',
                style: TextStyle(
                    fontSize: SizeUtils.titleSize, color: Colors.black)),
            backgroundColor: whiteColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // color: Colors.pink,
                  width: screenWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 15, bottom: 10),
                        child: Text(
                            'Pemberi ${widget.type[0].toUpperCase()}${widget.type.substring(1)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeUtils.titleSize)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300], width: 3),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: ListTile(
                            title: Text('$customerName',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13)),
                            subtitle: Text(
                                '+62 $cutomerContact | $customerEmail',
                                style: TextStyle(fontSize: 11),
                                overflow: TextOverflow.ellipsis),
                            leading: CircleAvatar(
                              backgroundColor: greenColor,
                              backgroundImage: AssetImage(
                                  'assets/icon/default_picture_man.png'),
                            ),
                            trailing: CircleAvatar(
                              backgroundColor: greenColor,
                              child: Icon(Icons.visibility,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.deepPurple,
                  width: screenWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 15, bottom: 10),
                        child: Text(
                            'Penerima ${widget.type[0].toUpperCase()}${widget.type.substring(1)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeUtils.titleSize)),
                      ),
                      toLembagaId == null
                          ? informasiProgram
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: screenWidth(context),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey[300], width: 3),
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: ListTile(
                                  title: Text('$toLembagaName',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13)),
                                  subtitle: Text('$toGalangAmalName',
                                      style: TextStyle(fontSize: 11),
                                      overflow: TextOverflow.ellipsis),
                                  leading: CircleAvatar(
                                    backgroundColor: greenColor,
                                    child: Text(
                                        '${toLembagaName.substring(0, 1)}',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 40, bottom: 20),
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nominal Donasi',
                        labelStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        hasFloatingPlaceholder: true,
                        prefixIcon: Icon(CalculatorOtherIcon.edittext_loan_3x),
                      ),
                      controller: nominalCtrl,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: RaisedButton(
                    onPressed: () {
                      if (toGalangAmalId == null && _lembagaAmalModel == null) {
                        return showDialog<String>(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              title: const Text('Silahkan Pilih lembaga Amal',
                                  style: TextStyle(fontSize: 14.0)),
                              children: <Widget>[],
                            );
                          },
                        );
                      } else {
                        print('To Lembaga Amal $toLembagaName');
                        print('Lembaga Amal Model $_lembagaAmalModel');
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PembayaranDonasi(
                            nominal: nominalCtrl.numberValue,
                            toLembagaAmal: toLembagaName != null
                                ? toLembagaName
                                : _lembagaAmalModel.lembagaAmalName,
                            email: customerEmail,
                            nameProgram: toGalangAmalName,
                            idProgram: toGalangAmalId != null
                                ? toGalangAmalId
                                : _lembagaAmalModel.idLembagaAmal,
                            phone: cutomerContact,
                            lembagaId: toLembagaId,
                            type: type,
                          ),
                        ));
                      }
                    },
                    child: const Text('Selanjutnya',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                    color: greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            bgUrl,
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomLeft,
          ),
        ),
      ],
    );
  }

  LembagaAmalModel _lembagaAmalModel;
  List<LembagaAmalModel> _lembagaAmalList = new List<LembagaAmalModel>();
  Map _lembagaAmalModelValueSend = new Map();

  Widget galangAmalSelect() {
    return new DropdownButtonFormField<LembagaAmalModel>(
      decoration: InputDecoration(
        hintText: "Pilih Lembaga Amal",
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
                        new TextStyle(fontFamily: "Poppins", fontSize: 14.0)),
              );
            }).toList(),
    );
  }

  LembagaAmalProvider _lembagaAmalProvider = new LembagaAmalProvider();

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

  @override
  void initState() {
    double total = 0.0;
    if (widget.nilaiZakat != null) {
      total = (widget.nilaiZakat * 10);
    }
    widget.nilaiZakat != null
        ? nominalCtrl.text = total.toString()
        : nominalCtrl = new MoneyMaskedTextController(leftSymbol: 'Rp ');
    print(type);
    getListLembagaAmil();
    super.initState();
  }
}
