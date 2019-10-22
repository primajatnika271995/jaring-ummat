import 'package:flutter_jaring_ummat/src/models/jelajahKebaikanModel.dart';
import 'package:flutter_jaring_ummat/src/repository/JelajahKebaikanRepository.dart';
import 'package:rxdart/rxdart.dart';

class JelajahKebaikanBloc {

  final repository = new JelajahKebaikanRepository();
  final jelajahKebaikanPopulerFetch = PublishSubject<List<JelajahKebaikanModel>>();

  Observable<List<JelajahKebaikanModel>> get streamJelajahKebaikanPopuler => jelajahKebaikanPopulerFetch.stream;

  fetchJelajahKebaikanPopuler() async {
    List<JelajahKebaikanModel> listJelajahKebaikanPopuler = await repository.jelajahKebaikanPopuler();
    jelajahKebaikanPopulerFetch.sink.add(listJelajahKebaikanPopuler);
  }

  dispose() async {
    await jelajahKebaikanPopulerFetch.drain();
    jelajahKebaikanPopulerFetch.close();
}

}

final jelajahKebaikanBloc = new JelajahKebaikanBloc();