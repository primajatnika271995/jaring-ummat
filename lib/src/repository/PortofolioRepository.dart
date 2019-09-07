import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/portofolioApi.dart';

class PortofolioRepository {
  final provider = PortofolioProvider();
  Future<SebaranAktifitasAmalModel> sebaranAktifitasAmalFetch() => provider.fetchSebaranAktifitasAmal();
}