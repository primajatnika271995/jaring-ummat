import 'package:flutter/cupertino.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/views/login/validator.dart';
import 'package:rxdart/rxdart.dart';
import '../repository/RegisterRepository.dart';

class RegisterBloc with Validators {
  final _repository = RegisterRepository();
  final registerRespFetcher = PublishSubject<RegisterResponseModel>();

  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // retrieve data from stream
  Stream<String> get username => _username.stream.transform(usernameValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<bool> get submitValid =>
      Observable.combineLatest2(username, password, (e, p) => true);

  // add data to stream
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Observable<RegisterResponseModel> get streamResponse =>
      registerRespFetcher.stream;

  saveUser(
      BuildContext context, PostRegistration register, String content) async {
    RegisterResponseModel value =
        await _repository.saveUser(context, register, content);
    registerRespFetcher.sink.add(value);
  }

  dispose() async {
    await registerRespFetcher.drain();
    registerRespFetcher.close();
  }
}

final bloc = RegisterBloc();
