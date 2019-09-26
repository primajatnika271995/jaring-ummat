import 'package:flutter_jaring_ummat/src/models/aktivitasTerbaruModel.dart';
import 'package:flutter_jaring_ummat/src/models/aktivitasTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/barChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/repository/PortofolioRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PortofolioBloc {
  final repository = PortofolioRepository();
  final sebaranAktifitasAmalFetcher = PublishSubject<SebaranAktifitasAmalModel>();
  final aktivitasTerbesarFetcher = PublishSubject<List<AktivitasTerbesarModel>>();
  final aktivitasTerbaruFetcher = PublishSubject<List<AktivitasTerbesarModel>>();
  final barChartFetcher = PublishSubject<List<BarchartModel>>();

  Observable<SebaranAktifitasAmalModel> get sebaranAktifitasAmal => sebaranAktifitasAmalFetcher.stream;
  Observable<List<AktivitasTerbesarModel>> get aktivitasTerbesar => aktivitasTerbesarFetcher.stream;
  Observable<List<AktivitasTerbesarModel>> get aktivitasTerbaru => aktivitasTerbaruFetcher.stream;
  Observable<List<BarchartModel>> get barChartStream => barChartFetcher.stream;

  fetchSebaranAktifitasAmal() async {
    SebaranAktifitasAmalModel value = await repository.sebaranAktifitasAmalFetch();
    sebaranAktifitasAmalFetcher.sink.add(value);
  }

  fetchAktivitasTerbesar() async {
    List<AktivitasTerbesarModel> value = await repository.aktivitasTerbesarFetch();
    aktivitasTerbesarFetcher.sink.add(value);
  }

  fetchAktivitasTerbaru() async {
    List<AktivitasTerbesarModel> value = await repository.aktivitasTerbaruFetch();
    aktivitasTerbaruFetcher.sink.add(value);
  }

  fetchBarChart(String category, String type) async {
    List<BarchartModel> value = await repository.barChartFetch(category, type);
    barChartFetcher.sink.add(value);
  }

  dispose() async {
    await sebaranAktifitasAmalFetcher.drain();
    await aktivitasTerbesarFetcher.drain();
    await aktivitasTerbaruFetcher.drain();
    await barChartFetcher.drain();
    sebaranAktifitasAmalFetcher.close();
    aktivitasTerbesarFetcher.close();
    aktivitasTerbaruFetcher.close();
    barChartFetcher.close();
  }
}

final bloc = PortofolioBloc();