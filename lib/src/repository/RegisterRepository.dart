import 'package:flutter/cupertino.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/registerApi.dart';
import '../models/RegistrationModel.dart';

class RegisterRepository {
  final repository = RegisterApiProvider();
  Future<RegisterResponseModel> saveUser(BuildContext context, PostRegistration register, String content) => repository.saveUser(context, register, content);
}