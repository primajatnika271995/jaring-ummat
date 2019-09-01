import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/LoginResponse.dart';
import 'package:flutter_jaring_ummat/src/models/amilDetailsModel.dart';
import 'package:flutter_jaring_ummat/src/repository/LoginRepository.dart';
import 'package:flutter_jaring_ummat/src/views/home.dart';
import 'package:flutter_jaring_ummat/src/views/login/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc with Validators {
  final repository = LoginRepository();
  final loginFetcher = PublishSubject<LoginResponse>();
  final detailFetcher = PublishSubject<AmilDetailsModel>();

  final  _email = BehaviorSubject<String>();
  final  _password = BehaviorSubject<String>();

  // retrieve data from stream
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (e, p) => true);

  // add data to stream
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Observable<LoginResponse> get streamLogin => loginFetcher.stream;
  Observable<AmilDetailsModel> get streamDetail => detailFetcher.stream;

  login(BuildContext context, String username, String password) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    LoginResponse response = await repository.login(context, username, password);

    loginFetcher.sink.add(response);

    if (response != null) {
      _preferences.setString(ACCESS_TOKEN_KEY, response.accessToken);
      userDetails(context, username);
    }
  }

  userDetails(BuildContext context, String email) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    AmilDetailsModel response = await repository.fetchDetail(context, email);

    detailFetcher.sink.add(response);

    if (response.id.isNotEmpty) {
      _preferences.setString(USER_ID_KEY, response.id);
      _preferences.setString(LEMABAGA_AMAL_ID, response.idLembaga);
      _preferences.setString(EMAIL_KEY, response.emailLembaga);
      _preferences.setString(FULLNAME_KEY, response.namaLembaga);
      _preferences.setString(CONTACT_KEY, response.contactLembaga);

      if (response.imgProfile == null) {
        _preferences.setString(PROFILE_PICTURE_KEY, "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png");
      } else {
        _preferences.setString(PROFILE_PICTURE_KEY, response.imgProfile[0].imgUrl);
      }
      
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeView()));
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
