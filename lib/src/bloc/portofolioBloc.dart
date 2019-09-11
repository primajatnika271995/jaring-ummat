import 'package:flutter_jaring_ummat/src/models/aktivitasTerbaruModel.dart';
import 'package:flutter_jaring_ummat/src/models/aktivitasTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/repository/PortofolioRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PortofolioBloc {
  final repository = PortofolioRepository();
  final sebaranAktifitasAmalFetcher = PublishSubject<SebaranAktifitasAmalModel>();
  final aktivitasTerbesarFetcher = PublishSubject<List<AktivitasAmalTerbaruModel>>();
  final aktivitasTerbaruFetcher = PublishSubject<List<AktivitasTerbesarModel>>();

  Observable<SebaranAktifitasAmalModel> get sebaranAktifitasAmal => sebaranAktifitasAmalFetcher.stream;
  Observable<List<AktivitasAmalTerbaruModel>> get aktivitasTerbesar => aktivitasTerbesarFetcher.stream;
  Observable<List<AktivitasTerbesarModel>> get aktivitasTerbaru => aktivitasTerbaruFetcher.stream;

  fetchSebaranAktifitasAmal() async {
    SebaranAktifitasAmalModel value = await repository.sebaranAktifitasAmalFetch();
    sebaranAktifitasAmalFetcher.sink.add(value);
  }

  fetchAktivitasTerbesar() async {
    List<AktivitasAmalTerbaruModel> value = await repository.aktivitasTerbesarFetch();
    aktivitasTerbesarFetcher.sink.add(value);
  }

  fetchAktivitasTerbaru() async {
    List<AktivitasTerbesarModel> value = await repository.aktivitasTerbaruFetch();
    aktivitasTerbaruFetcher.sink.add(value);
  }

  dispose() async {
    await sebaranAktifitasAmalFetcher.drain();
    await aktivitasTerbesarFetcher.drain();
    await aktivitasTerbaruFetcher.drain();
    sebaranAktifitasAmalFetcher.close();
    aktivitasTerbesarFetcher.close();
    aktivitasTerbaruFetcher.close();
  }
}

final bloc = PortofolioBloc();