import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/repository/ProgramAmalRepository.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramAmalBloc with Validators {
  SharedPreferences _preferences;
  String idUser;

  final repository = ProgramAmalRepository();
  final programAmalFetcher = PublishSubject<List<ProgramAmalModel>>();

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

  Observable<List<ProgramAmalModel>> get allProgramAmal =>
      programAmalFetcher.stream;

  fetchAllProgramAmal(String category) async {
    _preferences = await SharedPreferences.getInstance();
    idUser = _preferences.getString(USER_ID_KEY);

    if (idUser == null) {
      idUser = "4b724e9e-3cdb-4b2f-8c72-070646b45fdf";
    }

    List<ProgramAmalModel> listAllProgramAmal =
        await repository.fetchAllProgramAmal(idUser, category, "0", "20");
    programAmalFetcher.sink.add(listAllProgramAmal);
  }

  save(BuildContext context, PostProgramAmal value, String content) async {
    _preferences = await SharedPreferences.getInstance();
    idUser = _preferences.getString(LEMABAGA_AMAL_ID);
    var fullname = _preferences.getString(FULLNAME_KEY);

    await repository.save(context, value, idUser, fullname, content);
  }

  dispose() async {
    await programAmalFetcher.drain();
    programAmalFetcher.close();
  }
}

final bloc = ProgramAmalBloc();
