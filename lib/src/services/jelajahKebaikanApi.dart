import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:flutter_jaring_ummat/src/models/jelajahKebaikanModel.dart';
import 'package:http/http.dart' show Client;

class JelajahKebaikanProvider {
  Client _client = new Client();
  
  Future<List<JelajahKebaikanModel>> jelajahKebaikanPopuler() async {
    final response = await _client.get(JELAJAH_KEBAIKAN_POPULER);

    print('Response Jelajah kebaikan Populer : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(jelajahKebaikanModelFromJson, response.body);
    } return null;
  }
}