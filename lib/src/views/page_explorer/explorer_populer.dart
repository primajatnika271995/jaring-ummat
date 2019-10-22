import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/jelajahKebaikanBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/models/jelajahKebaikanModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/beritaApi.dart';
import 'package:flutter_jaring_ummat/src/services/programAmalApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_views.dart';

class ExplorerPopulerView extends StatefulWidget {
  @override
  _ExplorerPopulerViewState createState() => _ExplorerPopulerViewState();
}

class _ExplorerPopulerViewState extends State<ExplorerPopulerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: jelajahKebaikanBloc.streamJelajahKebaikanPopuler,
        builder: (context, AsyncSnapshot<List<JelajahKebaikanModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: Text('Waiting...'));
              break;
            default:
              if (snapshot.hasData) {
                return listBuilder(snapshot.data);
              }
              return Center(child: Text('No Data'));
          }
        },
      ),
    );
  }

  Widget listBuilder(List<JelajahKebaikanModel> snapshot) {
    return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      shrinkWrap: true,
      itemCount: snapshot.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot[index];
        return InkWell(
          onTap: () {
            switch (value.category) {
              case "program":
                print("it/'s program");
                getProgramAmalByID(value.id);
                break;
              case "berita":
                print("it/'s berita");
                getBeritaByID(value.id);
                break;
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      value.imageContent[0].resourceType == "video"
                          ? value.imageContent[0].urlThumbnail
                          : value.imageContent[0].url),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 20),
                      child: Icon(
                          value.category == "program"
                              ? AllInOneIcon.create_galang_amal_3x
                              : AllInOneIcon.news_3x,
                          color: whiteColor,
                          size: 25),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 10, right: 10),
                      child: Text(
                        value.description,
                        style: TextStyle(color: whiteColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    jelajahKebaikanBloc.fetchJelajahKebaikanPopuler();
    super.initState();
  }

  @override
  void dispose() {
    jelajahKebaikanBloc.dispose();
    super.dispose();
  }

  void getBeritaByID(String idBerita) {
    BeritaProvider provider = new BeritaProvider();
    provider.beritaByID(idBerita).then((response) {
      print(response.statusCode);
      var value = BeritaModel.fromJson(json.decode(response.body));
//      Navigator.of(context).push(
//        MaterialPageRoute(
//          builder: (context) => BeritaViews(
//            value: value,
//          ),
//        ),
//      );
    });
  }

  void getProgramAmalByID(String idProgram) {
    ProgramAmalApiProvider provider = new ProgramAmalApiProvider();
    provider.programAmalByID(idProgram).then((response) {
      print(response.statusCode);
      var value = ProgramAmalModel.fromJson(json.decode(response.body));
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => GalangAmalView(
//            programAmal: value,
//            likes: value.userLikeThis,
//          ),
//        ),
//      );
    });
  }
}
