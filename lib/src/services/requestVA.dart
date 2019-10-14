import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/requestVAModel.dart';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';

class RequestVAProvider {
  Client client = new Client();

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<RequestVaModel> requestVirtualAccountAnonymous(
      double amount,
      String customerEmail,
      String customerName,
      String customerPhone,
      String transactionId,
      String transactionType) async {
    /*
   *  Params Request VA   
   */
    Map params = {
      "amount": amount,
      "customerEmail": customerEmail,
      "customerName": customerName,
      "customerPhone": customerPhone,
      "transactionId": transactionId,
      "transactionType": transactionType,
    };

    final response = await client.post(REQUEST_VA_ANONIMOUS,
        headers: headers, body: json.encode(params));
    print('--> Request VA Anonimous :${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(requestVaModelFromJson, response.body);
    }
  }

  Future<RequestVaModel> requestVirtualAccountOAuth(
      double amount,
      String customerEmail,
      String customerName,
      String customerPhone,
      String transactionId,
      String lembaga,
      String transactionType) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    print(amount);
    print(customerEmail);
    print(customerPhone);
    print(customerName);
    print(transactionId);
    print(transactionType);

    Map<String, String> head = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    Map params = {
      "amount": amount,
      "customerEmail": customerEmail,
      "customerName": customerName,
      "customerPhone": customerPhone,
      "transactionId": transactionId,
      "lembaga": lembaga,
      "transactionType": transactionType
    };

    final response = await client.post(REQUEST_VA_OAUTH,
        headers: head, body: json.encode(params));
    print('--> Request VA OAuth :${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.body);
      return compute(requestVaModelFromJson, response.body);
    }
  }

  Future pembayaran(String transaksiId, String va) async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      var token = _pref.getString(ACCESS_TOKEN_KEY);

      Map<String, String> header = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      Uri uri = Uri.parse(PEMBAYARAN_URL);
      var params = {"transactionId": transaksiId, "virtualNumber": va};

      final uriParse = uri.replace(queryParameters: params);
      final response = await client.post(uriParse, headers: header);
      print(response.statusCode);

      if (response.statusCode == 201) {
        return response;
      } else {
        print('Err :${response.statusCode}');
      }
    }
}
