import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/likesModel.dart';
import 'package:flutter_jaring_ummat/src/repository/LikesRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikesBloc {
  final _repository = LikesRepository();
  final _likesFetchAll = PublishSubject<List<Likes>>();

  final _likes = BehaviorSubject<String>();

  SharedPreferences _preferences;

  Observable<List<Likes>> get allCommentList => _likesFetchAll.stream;

  fetchAllLikes() async {
    List<Likes> likes = await _repository.fetchAllLikes();
    _likesFetchAll.sink.add(likes);
  }

  saveProgramLikes(idProgram) async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);

    _repository.addSaveLikes(idUser, idProgram, "");
  }

  saveBeritaLikes(idNews) async {
    _preferences = await SharedPreferences.getInstance();
    var idUser = _preferences.getString(USER_ID_KEY);

    _repository.addSaveLikes(idUser, "", idNews);
  }

  dispose() async {
    await _likesFetchAll.drain();
    _likesFetchAll.close();
  }
}

final bloc = LikesBloc();
