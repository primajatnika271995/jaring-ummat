import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';


class ProgramAmalLembaga extends StatefulWidget {
  final String idUser;
  final String category;
  ProgramAmalLembaga({this.idUser, this.category});

  @override
  _ProgramAmalLembagaState createState() =>
      _ProgramAmalLembagaState(idUser: this.idUser, category: this.category);
}

class _ProgramAmalLembagaState extends State<ProgramAmalLembaga> {
  String idUser;
  String category;
  _ProgramAmalLembagaState({this.idUser, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: bloc.allProgramAmal,
              builder:
                  (context, AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('');
                    break;
                  default:
                    if (snapshot.hasData) {
                      return buildList(snapshot);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Container(
                      width: screenWidth(context),
                      color: whiteColor,
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/backgrounds/no_data_accent.png',
                              height: 250),
                          Text(
                            'Oops..',
                            style: TextStyle(
                              fontFamily: 'Proxima',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'There\'s nothing \'ere, yet.',
                            style: TextStyle(
                              fontFamily: 'Proxima',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    );
                    break;
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    bloc.fetchAllProgramAmalDetailLembaga(idUser, category);
    super.initState();
  }

  Widget buildList(AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.data[index];
        return ProgramAmalContent(
          programAmal: value,
          likes: value.userLikeThis,
          bookmark: value.bookmarkThis,
        );
      },
    );
  }
}