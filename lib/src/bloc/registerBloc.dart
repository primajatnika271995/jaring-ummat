import 'package:flutter/cupertino.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:rxdart/rxdart.dart';
import '../repository/RegisterRepository.dart';

class RegisterBloc {
  final _repository = RegisterRepository();
  final registerRespFetcher = PublishSubject<RegisterResponseModel>();

  Observable<RegisterResponseModel> get streamResponse => registerRespFetcher.stream;

  saveUser(BuildContext context, PostRegistration register, String content) async {
    RegisterResponseModel value = await _repository.saveUser(context, register, content);
    registerRespFetcher.sink.add(value);
  }

  dispose() async {
    await registerRespFetcher.drain();
    registerRespFetcher.close();
  }
}

final bloc = RegisterBloc();
