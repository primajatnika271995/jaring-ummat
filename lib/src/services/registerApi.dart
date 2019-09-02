import 'dart:io';

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/models/postModel.dart';

class RegisterApiProvider {
  Dio dio = new Dio();
  Client client = new Client();

  final String contentFile = "Users Profile";
  final String types = "image";

  Map<String, String> headers = {
    'Content-type': 'application/json',
  };

  Future<RegisterResponseModel> saveUser(BuildContext context, PostRegistration data, String content) async {
    Map params = {
      "tipe_user": data.tipe_user,
      "password": data.password,
      "username": data.email,
      "email": data.email,
      "fullname": data.fullname,
      "contact": data.contact
    };

    Map paramsLembaga = {
      "namaLembaga": data.fullname,
      "emailLembaga": data.email,
      "categoryLembaga": "Amal",
      "contactLembaga": "-",
      "alamatLembaga": "-"
    };

    final response = await client.post(REGISTRATION_URL,
        headers: headers, body: json.encode(params));

    if (response.statusCode == 201) {
      // Ambil value id
      RegisterResponseModel value =
          registerResponseModelFromJson(response.body);
      print('--> id user for save image content : ${value.id}');

      // response simpan ke table lembaga amal
      final resp = await client.post(CREATE_LEMBAGA_AMAL,
          headers: headers, body: json.encode(paramsLembaga));

      if (resp.statusCode == 201) {
        // save content image
        saveContent(context, value.id, content);
      } else if (response.statusCode == 500) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.all(8.0),
          borderRadius: 8.0,
          message: "Akun tidak bisa di daftarkan ke Lembaga Amal",
          leftBarIndicatorColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    } else if (response.statusCode == 500) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        margin: EdgeInsets.all(8.0),
        borderRadius: 8.0,
        message: "Akun anda sudah terdaftar sebelumnya",
        leftBarIndicatorColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  Future saveContent(BuildContext context, contentId, content) async {
    FormData formData = new FormData.from({
      "contentId": contentId,
      "contentFile": contentFile,
      "types": types,
      "content": new UploadFileInfo(new File("./$content"), content),
    });
    final response = await dio.post(UPLOADER_MEDIA_IMAGE, data: formData);
    print('--> Response Context Image : ${response.statusCode}');
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            elevation: 0.0,
            backgroundColor: Colors.white,
            child: Container(
              height: 500.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Buat Akun Sukses',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Text(
                          'Selamat! Pembuatan akun Anda berhasil.\n Mari Mulai lakukan kebaikan untuk sesama!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: grayColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                        color: greenColor,
                        child: const Text('Bismillah'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
      return response;
    } else {
      print('--> Failed to save image user');
    }
  }
}
