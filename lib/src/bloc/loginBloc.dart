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
    LoginResponse response =
        await repository.login(context, username, password);
    loginFetcher.sink.add(response);

    _preferences.setString(ACCESS_TOKEN_KEY, response.accessToken);
  }

  userDetails(BuildContext context, String email) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    MuzakkiUserDetails response = await repository.fetchDetail(context, email);

    detailFetcher.sink.add(response);

    if (!response.userId.isEmpty) {
      _preferences.setString(USER_ID_KEY, response.userId);
      _preferences.setString(EMAIL_KEY, response.email);
      _preferences.setString(FULLNAME_KEY, response.fullname);
      _preferences.setString(CONTACT_KEY, response.contact);

      if (response.imgProfile == null) {
        _preferences.setString(PROFILE_PICTURE_KEY,
            'https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png');
      } else {
        _preferences.setString(
            PROFILE_PICTURE_KEY, response.imgProfile[0].imgUrl);
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeView(
            currentindex: 4,
          ),
        ),
      );
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
