import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/LoginResponse.dart';
import 'package:flutter_jaring_ummat/src/models/amilDetailsModel.dart';
import 'package:flutter_jaring_ummat/src/services/loginApi.dart';

class LoginRepository {
  final provider = LoginApiProvider();

  Future<LoginResponse> login(BuildContext context, String username, String password) => provider.login(context, username, password);
  Future<AmilDetailsModel> fetchDetail(BuildContext context, String email) => provider.fetchDetails(context, email);
}