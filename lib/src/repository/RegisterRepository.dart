import 'package:flutter/cupertino.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/FilePathResponse.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:flutter_jaring_ummat/src/models/muzakkiUserDetails.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/registerApi.dart';

class RegisterRepository {
  final repository = RegisterApiProvider();
  Future<RegisterResponseModel> saveUser(BuildContext context, PostRegistration register) => repository.saveUser(context, register);
  Future<FilePathResponseModel> saveFilepath(BuildContext context, FilePathResponseModel data, String idUser) => repository.saveFilepath(context, data, idUser);

  Future<MuzakkiUserDetails> updateLokasiAmal(String lokasiAmal) => repository.updateLokasiAmal(lokasiAmal);
  Future<MuzakkiUserDetails> updateUser(MuzakkiUserDetails value) => repository.updateUser(value);
}