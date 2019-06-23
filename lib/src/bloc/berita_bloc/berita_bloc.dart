import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class BeritaBloc extends Bloc<BeritaEvent, BeritaState> {

  final http.Client httpClient;
  BeritaBloc({@required this.httpClient});

  SharedPreferences _preferences;

  @override
  Stream<BeritaState> transform(Stream<BeritaEvent> events, Stream<BeritaState> Function(BeritaEvent event) next) {
    // TODO: implement transform
    return super.transform(
      (events as Observable<BeritaEvent>).debounceTime(
        Duration(milliseconds: 500)), next,
    );
  }

  @override
  BeritaState get initialState => BeritaUninitialized();

  @override
  Stream<BeritaState> mapEventToState(BeritaEvent event) async* {
    
    _preferences = await SharedPreferences.getInstance();
    var userId = _preferences.getString(USER_ID_KEY);

    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is BeritaUninitialized) {
          final berita = await _fetchBerita(userId, 0, 10);
          yield BeritaLoaded(berita: berita, hasReachedMax: false);
        }
        // if (currentState is BeritaLoaded) {
        //   final berita = await _fetchBerita(userId, (currentState as BeritaLoaded).berita.length, 2);
        //   yield berita.isEmpty
        //       ? (currentState as BeritaLoaded).copyWith(hasReachedMax: true)
        //       : BeritaLoaded(
        //           berita: (currentState as BeritaLoaded).berita + berita,
        //           hasReachedMax: false,
        //       );
        // }
      } catch (_) {
        yield BeritaError();
      }
    }
  }

  bool _hasReachedMax(BeritaState state) =>
    state is BeritaLoaded && state.hasReachedMax;

  Future<List<Berita>> _fetchBerita(String userId, int startIndex, int limit) async {
    print("this start index ${startIndex}");
    print("this limit data ${limit}");
    final response = await httpClient.get('http://139.162.15.91/jaring-ummat/api/berita/list?start=$startIndex&limit=$limit&idUserLogin=$userId');
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        return data.map((rawBerita) {
          return Berita(
            id: rawBerita['id'],
            idUser: rawBerita['idUser'],
            idUserLike: rawBerita['idUserLike'],
            title: rawBerita['title'],
            category: rawBerita['category'],
            description: rawBerita['description'],
            imageContent: rawBerita['imageContent'],
            createdBy: rawBerita['createdBy'],
            createdDate: rawBerita['createdDate'],
            totalComment: rawBerita['totalComment'],
            totalLikes: rawBerita['totalLikes'],
          );
        }).toList();
      } else {
        throw Exception('error fetching Berita');
      }
  }
}
