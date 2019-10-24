import 'package:flutter_jaring_ummat/src/models/pengaturanAplikasiModel.dart';
import 'package:flutter_jaring_ummat/src/repository/PengaturanAplikasiRepository.dart';
import 'package:rxdart/rxdart.dart';

class PengaturanAplikasiBloc {

  final repository = PengaturanAplikasiRepository();
  final penagturanFetch = PublishSubject<PengaturanAplikasiModel>();

  Observable<PengaturanAplikasiModel> get streamPengaturan => penagturanFetch.stream;

  fetchPengaturanAplikasi() async {
    PengaturanAplikasiModel value = await repository.pengaturanAplikasi();
    penagturanFetch.sink.add(value);
  }

  dispose() async {
    await penagturanFetch.drain();
    penagturanFetch.close();
  }

}

final pengaturanAplikasiBloc = PengaturanAplikasiBloc();