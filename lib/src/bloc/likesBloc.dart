import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/likesModel.dart';
import 'package:flutter_jaring_ummat/src/models/listUserLikes.dart';
import 'package:flutter_jaring_ummat/src/repository/LikesRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikesBloc {
  final _repository = LikesRepository();
  final _likesFetchAll = PublishSubject<List<Likes>>();
  final _likesUserProgramAmalFetchAll = PublishSubject<List<ListUserLikes>>();
  final _likesUserBeritaFetchAll = PublishSubject<List<ListUserLikes>>();

  SharedPreferences _preferences;

  Observable<List<Likes>> get allCommentList => _likesFetchAll.stream;
  Observable<List<ListUserLikes>> get allLikeListUserProgramAmal => _likesUserProgramAmalFetchAll.stream;
  Observable<List<ListUserLikes>> get allLikeListUserBerita => _likesUserBeritaFetchAll.stream;

  fetchAllLikes() async {
    List<Likes> likes = await _repository.fetchAllLikes();
    _likesFetchAll.sink.add(likes);
  }

  fetchAllLikesUserProgramAmal(idProgram) async {
    List<ListUserLikes> user = await _repository.fetchUserLikeProgram(idProgram);
    _likesUserProgramAmalFetchAll.sink.add(user);
  }

  fetchAllLikesUserBerita(idBerita) async {
    List<ListUserLikes> user = await _repository.fetchUserLikeBerita(idBerita);
    _likesUserBeritaFetchAll.sink.add(user);
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
    await _likesUserBeritaFetchAll.drain();
    await _likesUserProgramAmalFetchAll.drain();
    _likesFetchAll.close();
    _likesUserBeritaFetchAll.close();
    _likesUserProgramAmalFetchAll.close();
  }
}

final bloc = LikesBloc();
