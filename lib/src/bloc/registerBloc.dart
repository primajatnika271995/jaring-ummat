import 'package:flutter/cupertino.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/FilePathResponse.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/RegisterResponse.dart';
import 'package:flutter_jaring_ummat/src/models/muzakkiUserDetails.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/registerPopUp.dart';
import 'package:flutter_jaring_ummat/src/views/login/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/RegisterRepository.dart';

class RegisterBloc with Validators {
  SharedPreferences _preferences;

  String idUser;

  final _repository = RegisterRepository();

  final registerUserFetcher = PublishSubject<RegisterResponseModel>();
  final saveFilepathFecther = PublishSubject<FilePathResponseModel>();

  final updateUserFetcher = PublishSubject<MuzakkiUserDetails>();
  final updateLokasiAmalFetcher = PublishSubject<MuzakkiUserDetails>();

  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Observable<RegisterResponseModel> get streamSaveUser => registerUserFetcher.stream;
  Observable<FilePathResponseModel> get streamSaveFilepath => saveFilepathFecther.stream;

  // retrieve data from stream
  Stream<String> get username => _username.stream.transform(usernameValidator);

  Stream<String> get password => _password.stream.transform(passwordValidator);

  Stream<bool> get submitValid => Observable.combineLatest2(username, password, (e, p) => true);

  // add data to stream
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changePassword => _password.sink.add;

  saveUser(BuildContext context, PostRegistration register) async {
    await _repository.saveUser(context, register).then((RegisterResponseModel value) {
      idUser = value.id;
      registerUserFetcher.sink.add(value);
    }).catchError((err) => print('Err : $err'));
  }

  saveFilepath(BuildContext context, FilePathResponseModel filepath) async {
    await _repository.saveFilepath(context, filepath, idUser).then((FilePathResponseModel value) => onSuccess(context)).catchError((err) => print('Err : $err'));
  }

  updateLokasiAmal(String lokasiAmal) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    MuzakkiUserDetails updateLokasiAmal = await _repository.updateLokasiAmal(lokasiAmal);
    updateLokasiAmalFetcher.sink.add(updateLokasiAmal);
    if (updateLokasiAmal.userId != null) {
      _preferences.setString(LOKASI_AMAL, updateLokasiAmal.lokasiAmal);
    }
  }

  updateUser(BuildContext context, MuzakkiUserDetails data) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    MuzakkiUserDetails value = await _repository.updateUser(data);
    updateUserFetcher.sink.add(value);

    print('Response Update User Details');
    print(muzakkiUserDetailsToJson(value));

    if (value.userId != null) {
      _preferences.setString(FULLNAME_KEY, value.fullname);
      _preferences.setString(CONTACT_KEY, value.contact);
      _preferences.setString(TEMPAT_LAHIR, value.kotaLahir);
      _preferences.setString(TGL_LAHIR, value.tanggalLahir);
      _preferences.setString(ALAMAT_LAHIR, value.kotaLahir);
      _preferences.setString(KOTA_LAHIR, value.kotaLahir != null ? value.kotaLahir : value.kabupatenLahir);
      _preferences.setString(PROVINSI_LAHIR, value.provinsiLahir);
      _preferences.setString(KOTA_TINGGAL, value.kabupaten != null ? value.kabupaten : value.kotaTinggal);
      _preferences.setString(PROVINSI_TINGGAL, value.provinsi);
      Navigator.of(context).pop();
    }
  }

  dispose() async {
    await registerUserFetcher.drain();
    await saveFilepathFecther.drain();
    await updateLokasiAmalFetcher.drain();
    await updateUserFetcher.drain();
    await _username.drain();
    await _password.drain();
    registerUserFetcher.close();
    saveFilepathFecther.close();
    updateLokasiAmalFetcher.close();
    updateUserFetcher.close();
    _username.close();
    _password.drain();
  }
}

final bloc = RegisterBloc();
