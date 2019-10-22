import 'package:flutter_jaring_ummat/src/models/jelajahKebaikanModel.dart';
import 'package:flutter_jaring_ummat/src/services/jelajahKebaikanApi.dart';

class JelajahKebaikanRepository {
  final provider = JelajahKebaikanProvider();

  Future<List<JelajahKebaikanModel>> jelajahKebaikanPopuler() => provider.jelajahKebaikanPopuler();
}