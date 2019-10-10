import 'package:flutter/foundation.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/galangAmalListDonationModel.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramAmalApiProvider {
  /*
   * Client from Http
   */
  Client client = Client();

  /*
   * Variable Temp
   */
  var params;
  Uri uri;

  Future<List<GalangAmalListDonation>> galangAmalListDonation(
      String idProgram) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);

    Map<String, String> header = {'Authorization': 'Bearer $token'};

    params = {"programAmalId": idProgram};

    print(idProgram);

    uri = Uri.parse(GALANG_AMAL_DONATION_LIST);
    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams, headers: header);
    print('--> GAlang Amal Donation List : ${response.statusCode}');

    if (response.statusCode == 200) {
      return compute(galangAmalListDonationFromJson, response.body);
    } else {
      print('Err : ${response.statusCode}');
    }
  }

  Future<List<ProgramAmalModel>> fetchProgramAmal(
      String userId, String category, String offset, String limit) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var token = _pref.getString(ACCESS_TOKEN_KEY);
    var filter = _pref.getString(FILTER_PROGRAM_AMAL);
    var lokasiAmal = _pref.getString(LOKASI_AMAL);

    var kotaSearch;
    var provinsiSearch;

    switch (lokasiAmal) {
      case 'SEKARANG':
        kotaSearch = _pref.getString(CURRENT_LOCATION_CITY);
        provinsiSearch = _pref.getString(CURRENT_LOCATION_PROVINSI);
        break;
      case 'ASAL':
        kotaSearch = _pref.getString(KOTA_LAHIR);
        provinsiSearch = _pref.getString(PROVINSI_LAHIR);
        break;
      case 'TINGGAL':
        kotaSearch = _pref.getString(KOTA_TINGGAL);
        provinsiSearch = _pref.getString(PROVINSI_TINGGAL);
        break;
      default:
        kotaSearch = null;
        provinsiSearch = null;
        break;
    }

    print('ini filter : $filter');
    print('KOTA SEARCH : $kotaSearch');
    print('PROVINSI SEARCH : $provinsiSearch');

    if (token == null) {
      token =
          "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE1NzI4MTY0NDcsInVzZXJfbmFtZSI6InByaW1hamF0bmlrYTI3MTk5NUBnbWFpbC5jb20iLCJhdXRob3JpdGllcyI6WyJST0xFX1NZU1RFTUFETUlOIl0sImp0aSI6IjU4ODE4Y2NjLWE0MDItNDZmMi05MzAxLTU0YWYyZWI2OTQ5MCIsImNsaWVudF9pZCI6ImphcmluZ3VtYXQiLCJzY29wZSI6WyJyZWFkIiwid3JpdGUiXX0.RHDFSwbEnJQQQiwn52TEelzmE0zvZNSdXPLkmgOd52RB7pL6MDe-OyCC-S0maKs1Exr-5YRiHHbYINnlKAViEX6W2n34THLD9DsAFgDZjHAAsCB4uwVGS2cg79dNUvb_W13oXmusEFYMuBAOCuZ5724OhmSOl2PBN_OmODjLRqsPwEP6GMfadgP0-mwc8I9_yUh8O-JEMBCsXRR0cNEdkkS6Fuq3UI1k0UIQHn2D8HXy6Tmyz9v4bwFlQH0orHB6O1oVKkcAu0ixBu-TbzQ5vVhmmdxzYrHdToxGQ2Rienk57DCrN6KOazbvWoIxlZLmq-MVVGxqN7xe1gLxOTgFbA";
    }

    Map<String, String> header = {'Authorization': 'Bearer $token'};

    if (category.isEmpty) {
      print('No Category');
      params = {
        "idUser": userId,
        "limit": limit,
        "offset": offset,
        "filter": filter == null ? "false" : "true",
        "kota": filter != null ? kotaSearch : null,
        "provinsi": filter != null ? provinsiSearch : null
      };
      uri = Uri.parse(PROGRAM_AMAL_LIST_ALL_URL);
    } else {
      print('With Category : $category');
      params = {
        "idUser": userId,
        "limit": limit,
        "offset": offset,
        "category": category,
        "filter": filter == null ? "false" : "true",
        "kota": filter != null ? kotaSearch : null,
        "provinsi": filter != null ? provinsiSearch : null
      };
      uri = Uri.parse(PROGRAM_AMAL_LIST_BY_CATEGORY_URL);
    }

    final uriParams = uri.replace(queryParameters: params);
    final response = await client.get(uriParams, headers: header);

    print('--> Response Program Amal : ${response.statusCode}');
    if (response.statusCode == 200) {
      return compute(programAmalModelFromJson, response.body);
    } else if (response.statusCode == 204) {
      print('--> No Content');
    } else {
      print('Err :${response.statusCode}');
    }
    return null;
  }
}
