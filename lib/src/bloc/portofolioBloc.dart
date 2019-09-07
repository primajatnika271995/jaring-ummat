import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/repository/PortofolioRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class PortofolioBloc {
  final repository = PortofolioRepository();
  final sebaranAktifitasAmalFetcher = PublishSubject<SebaranAktifitasAmalModel>();

  Observable<SebaranAktifitasAmalModel> get sebaranAktifitasAmal => sebaranAktifitasAmalFetcher.stream;

  fetchSebaranAktifitasAmal() async {
    SebaranAktifitasAmalModel value = await repository.sebaranAktifitasAmalFetch();
    sebaranAktifitasAmalFetcher.sink.add(value);
  }

  dispose() async {
    await sebaranAktifitasAmalFetcher.drain();
    sebaranAktifitasAmalFetcher.close();
  }
}

final bloc = PortofolioBloc();