import 'package:flutter_jaring_ummat/src/models/postModel.dart';

import '../repository/RegisterRepository.dart';
import '../models/RegistrationModel.dart';

class RegisterBloc {
  final _repository = RegisterRepository();

  saveUser(PostRegistration register) {

    _repository.saveUser(register);
  }
}

final bloc = RegisterBloc();