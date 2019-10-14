import 'package:flutter_jaring_ummat/src/models/barChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/lineChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/penerimaanAmalTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/portofolioPenerimaanApi.dart';

class PortofolioPenerimaanRepository {
  final provider = PortofolioPenerimaanProvider();
  Future<SebaranAktifitasAmalModel> sebaranAktifitasAmalFetch() => provider.fetchSebaranAktifitasAmal();
  Future<List<PenerimaanAmalTerbesarModel>> penerimaanAmalTerbesarFetch() => provider.fetchPenerimaAmalTerbesar();
  Future<List<PenerimaanAmalTerbesarModel>> penerimaanAmalTerbaruFetch() => provider.fetchPenerimaAmalTerbaru();
  Future<List<LineChartModel>> lineChartFetch(String category) => provider.lineChartApi(category);
  Future<List<BarchartModel>> barChartFetch(String category, String type) => provider.barChartApi(category, type);

  Future<SebaranAktifitasAmalModel> sebaranAktifitasAmalFetchLembagaDetails(String idLembaga) => provider.fetchSebaranAktifitasAmalLembagaDetails(idLembaga);
  Future<List<PenerimaanAmalTerbesarModel>> penerimaanAmalTerbesarFetchLembagaDetails(String idLembaga) => provider.fetchPenerimaAmalTerbaruLembagaDetails(idLembaga);
  Future<List<PenerimaanAmalTerbesarModel>> penerimaanAmalTerbaruFetchLembagaDetails(String idLembaga) => provider.fetchPenerimaAmalTerbaruLembagaDetails(idLembaga);
  Future<List<BarchartModel>> barChartFetchLembagaDetails(String idLembaga, String category, String type) => provider.barChartLembagaDetailsApi(idLembaga, category, type);
  Future<List<LineChartModel>> lineChartFetchLembagaDetails(String idLembaga, String category) => provider.lineChartLembagaDetailsApi(idLembaga, category);
}
