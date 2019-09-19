import 'package:flutter/cupertino.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:flutter_jaring_ummat/src/models/muzakkiUserDetails.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/registerApi.dart';

class RegisterRepository {
  final repository = RegisterApiProvider();
  Future<RegisterResponseModel> saveUser(BuildContext context, PostRegistration register, String content) => repository.saveUser(context, register, content);
  Future<MuzakkiUserDetails> updateLokasiAmal(String lokasiAmal) => repository.updateLokasiAmal(lokasiAmal);
  Future<MuzakkiUserDetails> updateUser(MuzakkiUserDetails value) => repository.updateUser(value);
}