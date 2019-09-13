import 'package:flutter_jaring_ummat/src/config/urls.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show Client;

class KalkulatorZakatProvider {
  Client client = new Client();

  Future<http.Response> zakatprofesiApi(double pendapatan, double lainnya, double hutang) {

    print('masuk kaga ?');

    // var params = {
    //   "pendapatanPerbulan": 1000000,
    //   "pendapatanLain": 1000000,
    //   "hutang": 100000,
    // };

    // Uri uri = Uri.parse(KALKULATOR_ZAKAT_PROFESI);


    // final uriParams = uri.replace(queryParameters: params);
    // print(uriParams);
    return client.get('http://139.162.15.91/jaring-ummat/api/zakat/profesi?pendapatanPerbulan=$pendapatan&pendapatanLain=$lainnya&hutang=$hutang');
  }

    Future<http.Response> zakatMaalApi(double tabungan, double properti, double perhiasan, double hutang, double lainnya) {

    print('masuk kaga ?');

    // var params = {
    //   "pendapatanPerbulan": 1000000,
    //   "pendapatanLain": 1000000,
    //   "hutang": 100000,
    // };

    // Uri uri = Uri.parse(KALKULATOR_ZAKAT_PROFESI);


    // final uriParams = uri.replace(queryParameters: params);
    // print(uriParams);
    return client.get('http://139.162.15.91/jaring-ummat/api/zakat/maal?hutang=$hutang&nilaiTabungan=$tabungan&nilaiProperti=$properti&nilaiEmasPerak=$perhiasan&nilaiLainnya=$lainnya');
  }

      Future<http.Response> zakatFitrahApi(String orang, double hargaBeras) {

    print('masuk kaga ?');

    // var params = {
    //   "pendapatanPerbulan": 1000000,
    //   "pendapatanLain": 1000000,
    //   "hutang": 100000,
    // };

    // Uri uri = Uri.parse(KALKULATOR_ZAKAT_PROFESI);


    // final uriParams = uri.replace(queryParameters: params);
    // print(uriParams);
    return client.get('http://139.162.15.91/jaring-ummat/api/zakat/fitrah?jumlahOrang=$orang&jenis=kg');
  }

  Future<http.Response> masterNilai() {
    return client.get(MASTER_NILAI_ZAKAT_FITRAH);
  }

}
