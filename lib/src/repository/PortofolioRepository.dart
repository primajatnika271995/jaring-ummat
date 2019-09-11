import 'package:flutter_jaring_ummat/src/models/aktivitasTerbaruModel.dart';
import 'package:flutter_jaring_ummat/src/models/aktivitasTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/portofolioApi.dart';

class PortofolioRepository {
  final provider = PortofolioProvider();
  Future<SebaranAktifitasAmalModel> sebaranAktifitasAmalFetch() => provider.fetchSebaranAktifitasAmal();
  Future<List<AktivitasAmalTerbaruModel>> aktivitasTerbesarFetch() => provider.fetchAktivitasTerbesar();
  Future<List<AktivitasTerbesarModel>> aktivitasTerbaruFetch() => provider.fetchAktifitasTerbaru();
}