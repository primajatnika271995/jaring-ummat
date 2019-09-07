import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/galangAmalListDonationModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/repository/ProgramAmalRepository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgramAmalBloc {
  SharedPreferences _preferences;
  String idUser;

  final repository = ProgramAmalRepository();
  final programAmalFetcher = PublishSubject<List<ProgramAmalModel>>();
  final galangAmalDonationFetch = PublishSubject<List<GalangAmalListDonation>>();

  Observable<List<ProgramAmalModel>> get allProgramAmal =>
      programAmalFetcher.stream;

  Observable<List<GalangAmalListDonation>> get galangAmalDonationStream => galangAmalDonationFetch.stream;

  fetchAllProgramAmal(String category) async {
    _preferences = await SharedPreferences.getInstance();
    idUser = _preferences.getString(USER_ID_KEY);
    
    if (idUser == null) {
      idUser = "4b724e9e-3cdb-4b2f-8c72-070646b45fdf";
    }

    List<ProgramAmalModel> listAllProgramAmal = await repository.fetchAllProgramAmal(idUser, category, "0", "20");
    programAmalFetcher.sink.add(listAllProgramAmal);
  }

  fetchGalangAmalDonation(String idProgram) async {
    List<GalangAmalListDonation> value = await repository.galangAmalDOnation(idProgram);
    galangAmalDonationFetch.sink.add(value);
  }

  dispose() async {
    await programAmalFetcher.drain();
    await galangAmalDonationFetch.drain();
    programAmalFetcher.close();
    galangAmalDonationFetch.close();
  }
}

final bloc = ProgramAmalBloc();
