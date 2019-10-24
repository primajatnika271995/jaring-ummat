import 'package:flutter_jaring_ummat/src/models/pengaturanAplikasiModel.dart';
import 'package:flutter_jaring_ummat/src/services/pengaturanAplikasiApi.dart';

class PengaturanAplikasiRepository {
  final provider = PengaturanAplikasiProvider();

  Future<PengaturanAplikasiModel> pengaturanAplikasi() => provider.pengaturanAplikasi();
}