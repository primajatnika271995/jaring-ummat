import 'package:flutter_jaring_ummat/src/services/registerApi.dart';
import '../models/RegistrationModel.dart';

class RegisterRepository {
  final repository = RegisterApiProvider();

  Future saveUser(
      String username,
      String fullname,
      String email,
      String tipe_user,
      String password,
      String contact) => repository.saveUser(username, fullname, email, tipe_user, password, contact);
}