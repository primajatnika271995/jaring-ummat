import 'package:flutter_jaring_ummat/src/models/historiTransaksiModel.dart';
import 'package:flutter_jaring_ummat/src/services/historyTransaksi.dart';

class HistoriTransaksiRepository {
  final provider = HistoriTransaksiProvider();
  Future<List<HistoriTransaksiModel>> historiTransaksi() => provider.historiTransaksi();
}