import 'package:flutter_jaring_ummat/src/models/barChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/lineChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/penerimaanAmalTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/repository/PortofolioPenerimaanRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PortofolioPenerimaanBloc {
  final repository = PortofolioPenerimaanRepository();
  final sebaranAktifitasAmalFetcher = PublishSubject<SebaranAktifitasAmalModel>();
  final penerimaAmalTerbaruFetcher = PublishSubject<List<PenerimaanAmalTerbesarModel>>();
  final penerimaAmalTerbesarFetcher = PublishSubject<List<PenerimaanAmalTerbesarModel>>();
  final lineChartFetcher = PublishSubject<List<LineChartModel>>();
  final barChartFetcher = PublishSubject<List<BarchartModel>>();

  Observable<SebaranAktifitasAmalModel> get sebaranAktifitasAmal => sebaranAktifitasAmalFetcher.stream;
  Observable<List<PenerimaanAmalTerbesarModel>> get penerimaAmalTerbesarStream => penerimaAmalTerbesarFetcher.stream;
  Observable<List<PenerimaanAmalTerbesarModel>> get penerimaAmalTerbaruStream => penerimaAmalTerbaruFetcher.stream;
  Observable<List<LineChartModel>> get lineChartStream => lineChartFetcher.stream;
  Observable<List<BarchartModel>> get barChartStream => barChartFetcher.stream;

  BehaviorSubject<List<PenerimaanAmalTerbesarModel>> aktivitasPenerimaanAmalTerbaruBehaviour = new BehaviorSubject<List<PenerimaanAmalTerbesarModel>>();


  fetchSebaranAktifitasAmal() async {
    SebaranAktifitasAmalModel value = await repository.sebaranAktifitasAmalFetch();
    sebaranAktifitasAmalFetcher.sink.add(value);
  }

  fetchPenerimaAmalTerbesar() async {
    List<PenerimaanAmalTerbesarModel> value = await repository.penerimaanAmalTerbesarFetch();
    penerimaAmalTerbesarFetcher.sink.add(value);
  }

  fetchPenerimaAmalTerbaru() async {
    List<PenerimaanAmalTerbesarModel> value = await repository.penerimaanAmalTerbaruFetch();
    penerimaAmalTerbaruFetcher.sink.add(value);
    aktivitasPenerimaanAmalTerbaruBehaviour.add(value);
  }

  fetcherLineChart(String category) async {
    List<LineChartModel> value = await repository.lineChartFetch(category);
    lineChartFetcher.sink.add(value);
  }

  fetchBarChart(String category, String type) async {
    List<BarchartModel> value = await repository.barChartFetch(category, type);
    barChartFetcher.sink.add(value);
  }

  fetchSebaranAktifitasAmalLembagaDetails(String idLembaga) async {
    SebaranAktifitasAmalModel value = await repository.sebaranAktifitasAmalFetchLembagaDetails(idLembaga);
    sebaranAktifitasAmalFetcher.sink.add(value);
  }

  fetchPenerimaAmalTerbesarLembagaDetails(String idLembaga) async {
    List<PenerimaanAmalTerbesarModel> value = await repository.penerimaanAmalTerbaruFetchLembagaDetails(idLembaga);
    penerimaAmalTerbesarFetcher.sink.add(value);
  }

  fetchPenerimaAmalTerbaruLembagaDetails(String idLembaga) async {
    List<PenerimaanAmalTerbesarModel> value = await repository.penerimaanAmalTerbaruFetchLembagaDetails(idLembaga);
    penerimaAmalTerbaruFetcher.sink.add(value);
    aktivitasPenerimaanAmalTerbaruBehaviour.add(value);
  }

  fetcherLineChartLembagaDetails(String idLembaga, String category) async {
    List<LineChartModel> value = await repository.lineChartFetchLembagaDetails(idLembaga, category);
    lineChartFetcher.sink.add(value);
  }

  fetchBarChartLembagaDetails(String idLembaga, String category, String type) async {
    List<BarchartModel> value = await repository.barChartFetchLembagaDetails(idLembaga, category, type);
    barChartFetcher.sink.add(value);
  }

  dispose() async {
    await sebaranAktifitasAmalFetcher.drain();
    await penerimaAmalTerbesarFetcher.drain();
    await penerimaAmalTerbaruFetcher.drain();
    await lineChartFetcher.drain();
    await barChartFetcher.drain();
    sebaranAktifitasAmalFetcher.close();
    penerimaAmalTerbesarFetcher.close();
    penerimaAmalTerbaruFetcher.close();
    lineChartFetcher.close();
    barChartFetcher.close();
  }
}

final bloc = PortofolioPenerimaanBloc();
