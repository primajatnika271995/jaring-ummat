import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  String key;
  dynamic value;

  Preference({this.key, this.value});

  setString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(this.key, this.value);
  }

  Future<dynamic> get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dynamic value = prefs.get(this.key);
    print(value);
    return value;
  }
}