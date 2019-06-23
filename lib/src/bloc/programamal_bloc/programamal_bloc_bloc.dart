import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class ProgramamalBlocBloc extends Bloc<ProgramamalBlocEvent, ProgramamalBlocState> {

  final http.Client httpClient;
  ProgramamalBlocBloc({@required this.httpClient});

  SharedPreferences _preferences;

  @override
  Stream<ProgramamalBlocState> transform(Stream<ProgramamalBlocEvent> events, Stream<ProgramamalBlocState> Function(ProgramamalBlocEvent event) next) {
    // TODO: implement transform
    return super.transform(
      (events as Observable<ProgramamalBlocEvent>).debounceTime(
        Duration(milliseconds: 500),
      ), next);
  }

  @override
  ProgramamalBlocState get initialState => ProgramAmalUninitialized();

  @override
  Stream<ProgramamalBlocState> mapEventToState(ProgramamalBlocEvent event) async* {

    _preferences = await SharedPreferences.getInstance();

    var userId = _preferences.getString(USER_ID_KEY);
    
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ProgramAmalUninitialized) {
          final programAmal = await _fetchProgramAmal(userId, 0, 10);
          yield ProgramAmalLoaded(programAmal: programAmal, hasReachedMax: false);
        }
//        if (currentState is ProgramAmalLoaded) {
//          final programAmal = await _fetchProgramAmal(userId, (currentState as ProgramAmalLoaded).programAmal.length, 2);
//          yield programAmal.isEmpty
//              ? (currentState as ProgramAmalLoaded).copyWith(hasReachedMax: true)
//              : ProgramAmalLoaded(
//                  programAmal: (currentState as ProgramAmalLoaded).programAmal + programAmal,
//                  hasReachedMax: false,
//              );
//        }
      } catch (_) {
        yield ProgramAmalError();
      }
    }
  }

  bool _hasReachedMax(ProgramamalBlocState state) =>
    state is ProgramAmalLoaded && state.hasReachedMax;

  Future<List<ProgramAmal>> _fetchProgramAmal(String userId, int startIndex, int limit) async {

    print("this start index ${startIndex}");
    print("this limit data ${limit}");

    final response = await httpClient.get('http://139.162.15.91/jaring-ummat/api/program-amal/list?idUserLogin=${userId}&start=$startIndex&limit=$limit');
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((rawProgramAmal) {
          return ProgramAmal(
            id: rawProgramAmal['id'],
            idUser: rawProgramAmal['idUser'],
            idUserLike: rawProgramAmal['idUserLike'],
            titleProgram: rawProgramAmal['titleProgram'],
            category: rawProgramAmal['category'],
            descriptionProgram: rawProgramAmal['descriptionProgram'],
            imageContent: rawProgramAmal['imageContent'],
            totalDonasi: rawProgramAmal['totalDonasi'],
            targetDonasi: rawProgramAmal['targetDonasi'],
            endDonasi: rawProgramAmal['endDonasi'],
            createdBy: rawProgramAmal['createdBy'],
            createdDate: rawProgramAmal['createdDate'],
            totalComment: rawProgramAmal['total_comment'],
            totalLikes: rawProgramAmal['total_likes'],
          );
        }).toList();
      } else {
        throw Exception('error fetching ProgramAmal');
      }
  }
}
