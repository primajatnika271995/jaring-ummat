import '../repository/RegisterRepository.dart';
import '../models/RegistrationModel.dart';

class RegisterBloc {
  final _repository = RegisterRepository();

  saveUser(
      String username,
      String fullname,
      String email,
      String tipe_user,
      String password,
      String contact) {

    _repository.saveUser(username, fullname, email, tipe_user, password, contact);
  }
}

final bloc = RegisterBloc();