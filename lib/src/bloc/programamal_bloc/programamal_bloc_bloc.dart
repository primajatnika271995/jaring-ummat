import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jaring_ummat/src/models/programAmalModel.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class ProgramamalBlocBloc extends Bloc<ProgramamalBlocEvent, ProgramamalBlocState> {

  final http.Client httpClient;
  ProgramamalBlocBloc({@required this.httpClient});

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
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ProgramAmalUninitialized) {
          final programAmal = await _fetchProgramAmal('15e0c393-d4e6-4c2d-93f8-c050b79ad1bb', 1, 2);
          yield ProgramAmalLoaded(programAmal: programAmal, hasReachedMax: false);
        }
        if (currentState is ProgramAmalLoaded) {
          final programAmal = await _fetchProgramAmal('15e0c393-d4e6-4c2d-93f8-c050b79ad1bb', (currentState as ProgramAmalLoaded).programAmal.length, 2);
          yield programAmal.isEmpty
              ? (currentState as ProgramAmalLoaded).copyWith(hasReachedMax: true)
              : ProgramAmalLoaded(
                  programAmal: (currentState as ProgramAmalLoaded).programAmal + programAmal,
                  hasReachedMax: false,
              );
        }
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
    final response = await httpClient.get('http://localhost:9091/api/program-amal/list?idUserLogin=${userId}&start=$startIndex&limit=$limit');
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
