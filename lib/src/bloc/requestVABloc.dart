import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/models/requestVAModel.dart';
import 'package:flutter_jaring_ummat/src/repository/RequestVARepository.dart';
import 'package:flutter_jaring_ummat/src/views/page_virtual_account/input_bill.dart';
import 'package:flutter_jaring_ummat/src/views/page_virtual_account/request_va.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class RequestVABloc {
  final repository = RequestVARepository();
  final requestFetcher = PublishSubject<RequestVaModel>();

  Observable<RequestVaModel> get streamRequest => requestFetcher.stream;

  pembayaran(String transaksiId, String va) async {
    repository.pembayaran(transaksiId, va);
  }

  requestVA(
      BuildContext context,
      double amount,
      String customerEmail,
      String customerName,
      String customerPhone,
      String transactionId,
      String transactionType) async {
    RequestVaModel value = await repository.requestVAoauth(
        amount,
        customerEmail,
        customerName,
        customerPhone,
        transactionId,
        transactionType);
    requestFetcher.sink.add(value);

    print('Request Status : ${value.status}');
    if (value.status == "000") {
      print('Data OK!');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RequestVA(
            nominal: amount,
            transaksiId: value.data.transactionId,
            virtualNumber: value.data.virtualNumber,
          ),
        ),
      );
    } else {
      if (transactionId == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => InputBill(
            customerEmail: customerEmail,
            customerName: customerName,
            customerPhone: customerPhone,
            type: transactionType,
          ),
        ));
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }

      Flushbar(
        margin: EdgeInsets.all(8.0),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: 8.0,
        message: "Ada gangguan pada Service Virtual Account",
        leftBarIndicatorColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }
}

final bloc = RequestVABloc();
