import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/services/registerApi.dart';
import '../models/RegistrationModel.dart';

class RegisterRepository {
  final repository = RegisterApiProvider();

  Future saveUser(PostRegistration register) => repository.saveUser(register);
}