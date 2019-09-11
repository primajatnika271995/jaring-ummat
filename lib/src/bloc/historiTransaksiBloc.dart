import 'package:flutter_jaring_ummat/src/models/historiTransaksiModel.dart';
import 'package:flutter_jaring_ummat/src/repository/HistoriTransaksi.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class HistoriTransaksiBloc {
  final repository = HistoriTransaksiRepository();
  final historyFetcher = PublishSubject<List<HistoriTransaksiModel>>();

  Observable<List<HistoriTransaksiModel>> get streamHistory =>
      historyFetcher.stream;

  fetchHistoryTransaksi(String type) async {
    List<HistoriTransaksiModel> listHistory = await repository.historiTransaksi(type);
    historyFetcher.sink.add(listHistory);
  }

  dispose() async {
    await historyFetcher.drain();
    historyFetcher.close();
  }
}

final bloc = HistoriTransaksiBloc();
