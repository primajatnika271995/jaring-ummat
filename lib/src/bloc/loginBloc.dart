import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/LoginResponse.dart';
import 'package:flutter_jaring_ummat/src/models/amilDetailsModel.dart';
import 'package:flutter_jaring_ummat/src/repository/LoginRepository.dart';
import 'package:flutter_jaring_ummat/src/views/home.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  final repository = LoginRepository();
  final loginFetcher = PublishSubject<LoginResponse>();
  final detailFetcher = PublishSubject<AmilDetailsModel>();

  Observable<LoginResponse> get streamLogin => loginFetcher.stream;
  Observable<AmilDetailsModel> get streamDetail => detailFetcher.stream;

  login(BuildContext context, String username, String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    LoginResponse response =
        await repository.login(context, username, password);
    loginFetcher.sink.add(response);

    _preferences.setString(ACCESS_TOKEN_KEY, response.accessToken);
  }

  userDetails(BuildContext context, String email) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    AmilDetailsModel response = await repository.fetchDetail(context, email);

    detailFetcher.sink.add(response);

    if (!response.id.isEmpty) {
      _preferences.setString(USER_ID_KEY, response.id);
      _preferences.setString(LEMABAGA_AMAL_ID, response.idLembaga);
      _preferences.setString(EMAIL_KEY, response.emailLembaga);
      _preferences.setString(FULLNAME_KEY, response.namaLembaga);
      _preferences.setString(CONTACT_KEY, response.contactLembaga);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeView(
          currentindex: 3,
        )
      ));
    }
  }

  dispose() async {
    await loginFetcher.drain();
    await detailFetcher.drain();
    loginFetcher.close();
    detailFetcher.drain();
  }
}

final bloc = LoginBloc();
