import 'package:flutter/cupertino.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:flutter_jaring_ummat/src/models/muzakkiUserDetails.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/RegisterRepository.dart';

class RegisterBloc {
  SharedPreferences _preferences;

  final _repository = RegisterRepository();
  final registerRespFetcher = PublishSubject<RegisterResponseModel>();
  final updateUserFetcher = PublishSubject<MuzakkiUserDetails>();
  final updateLokasiAmalFetcher = PublishSubject<MuzakkiUserDetails>();

  Observable<RegisterResponseModel> get streamResponse => registerRespFetcher.stream;
  Observable<MuzakkiUserDetails> get streamUpdateUser => updateUserFetcher.stream;

  saveUser(BuildContext context, PostRegistration register, String content) async {
    RegisterResponseModel value = await _repository.saveUser(context, register, content);
    registerRespFetcher.sink.add(value);

    if (value.id != null) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  updateLokasiAmal(String lokasiAmal) async {
    MuzakkiUserDetails updateLokasiAmal = await _repository.updateLokasiAmal(lokasiAmal);
    updateLokasiAmalFetcher.sink.add(updateLokasiAmal);
    if (updateLokasiAmal.userId != null) {
      _preferences.setString(LOKASI_AMAL, updateLokasiAmal.lokasiAmal);
    }
  }

  updateUser(BuildContext context, MuzakkiUserDetails data) async {
    MuzakkiUserDetails value = await _repository.updateUser(data);
    updateUserFetcher.sink.add(value);

    if (value.userId != null) {
      Navigator.of(context).pop();
    }
  }

  dispose() async {
    await registerRespFetcher.drain();
    await updateUserFetcher.drain();
    registerRespFetcher.close();
    updateUserFetcher.close();
  }
}

final bloc = RegisterBloc();
