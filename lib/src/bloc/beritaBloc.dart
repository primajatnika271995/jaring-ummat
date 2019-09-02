import 'package:flutter/cupertino.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/repository/BeritaRepository.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BeritaBloc with Validators {
  SharedPreferences _preferences;
  String idUser;

  final _title = BehaviorSubject<String>();
  final _category = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();

  // retrieve data from stream
  Stream<String> get title => _title.stream.transform(titleValidator);
  Stream<String> get category => _category.stream.transform(categoryValidator);
  Stream<String> get description =>
      _description.stream.transform(descriptionValidator);

  Stream<bool> get submitValid => Observable.combineLatest2(
      title, description, (t, c) => true);

  // add data to stream
  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeCategory => _category.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  
  final repository = BeritaRepository();
  final beritaFetcher = PublishSubject<List<BeritaModel>>();

  Observable<List<BeritaModel>> get allBerita => beritaFetcher.stream;

  fetchAllBerita(String category) async {
    _preferences = await SharedPreferences.getInstance();
    idUser = _preferences.getString(USER_ID_KEY);

    if (idUser == null) {
      idUser = "4b724e9e-3cdb-4b2f-8c72-070646b45fdf";
    }
    
    List<BeritaModel> listAllBerita = await repository.fetchAllBerita(idUser, category, "0", "20");
    beritaFetcher.sink.add(listAllBerita);
  }

  save(BuildContext context, PostBerita value, String content) async {
    _preferences = await SharedPreferences.getInstance();
    idUser = _preferences.getString(LEMABAGA_AMAL_ID);
    var fullname = _preferences.getString(FULLNAME_KEY);

    await repository.save(context, value, fullname, idUser, content);
  }

  dispose() async {
    await beritaFetcher.drain();
    beritaFetcher.close();
  }
}

final bloc = BeritaBloc();