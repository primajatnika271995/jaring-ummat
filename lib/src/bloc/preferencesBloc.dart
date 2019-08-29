import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/UserDetailPref.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesBloc {

  final _userDetailPreferences = BehaviorSubject<UserDetailPref>();
  Function(UserDetailPref) get changePref => _userDetailPreferences.sink.add;
  Stream<UserDetailPref> get preferences => _userDetailPreferences.stream;
  SharedPreferences _preferences;

  Future<void> _loadSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    final idUser = _preferences.getString(USER_ID_KEY);
    final uname  = _preferences.getString(FULLNAME_KEY) ?? 'Not Found';
    final email  = _preferences.getString(EMAIL_KEY) ?? 'Not Found';
    final contact = _preferences.getString(CONTACT_KEY) ?? 'Not Found';
    final img_profile_db = _preferences.getString(PROFILE_PICTURE_KEY) ?? 'https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png';
    final img_profile_social = _preferences.getString(PROFILE_FACEBOOK_KEY) ?? 'https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png';

    _userDetailPreferences.add(UserDetailPref(idUser, uname, email, contact, img_profile_db, img_profile_social));
  }

  PreferencesBloc() {
    _loadSharedPreferences();
  }

  dispose() async {
    await _userDetailPreferences.drain();
    _userDetailPreferences?.close();
  }
}

final bloc = PreferencesBloc();