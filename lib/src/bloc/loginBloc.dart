import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/LoginResponse.dart';
import 'package:flutter_jaring_ummat/src/models/muzakkiUserDetails.dart';
import 'package:flutter_jaring_ummat/src/repository/LoginRepository.dart';
import 'package:flutter_jaring_ummat/src/views/home.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc {
  final repository = LoginRepository();
  final loginFetcher = PublishSubject<LoginResponse>();
  final detailFetcher = PublishSubject<MuzakkiUserDetails>();

  Observable<LoginResponse> get streamLogin => loginFetcher.stream;
  Observable<MuzakkiUserDetails> get streamDetail => detailFetcher.stream;

  login(BuildContext context, String username, String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    await repository.login(context, username, password).then((LoginResponse value) {
      loginFetcher.sink.add(value);
      _preferences.setString(ACCESS_TOKEN_KEY, value.accessToken);
      userDetails(context, username);
    }).catchError((err) => print('Err : $err'));
  }

  userDetails(BuildContext context, String email) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    MuzakkiUserDetails response = await repository.fetchDetail(context, email);

    await repository.fetchDetail(context, email).then((MuzakkiUserDetails value) {
      detailFetcher.sink.add(value);

      if (value.userId != null) {
        _preferences.setString(USER_ID_KEY, response.userId);
        _preferences.setString(EMAIL_KEY, response.email);
        _preferences.setString(FULLNAME_KEY, response.fullname);
        _preferences.setString(CONTACT_KEY, response.contact);
        _preferences.setString(PROFILE_PICTURE_KEY, value.imageUrl);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      }
    }).catchError((err) => print('Err : $err'));
  }

  dispose() async {
    await loginFetcher.drain();
    await detailFetcher.drain();
    loginFetcher.close();
    detailFetcher.drain();
  }
}

final bloc = LoginBloc();
