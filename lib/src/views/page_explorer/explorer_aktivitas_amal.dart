import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/utils/textUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';

class ExplorerAktivitasAmalView extends StatefulWidget {
  @override
  _ExplorerAktivitasAmalViewState createState() => _ExplorerAktivitasAmalViewState();
}

class _ExplorerAktivitasAmalViewState extends State<ExplorerAktivitasAmalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.allProgramAmal,
        builder: (context, AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
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

  Widget listBuilder(List<ProgramAmalModel> snapshot) {
    return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      shrinkWrap: true,
      itemCount: snapshot.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GalangAmalView(
                  programAmal: value,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(value.imageContent[0].resourceType == "video" ? value.imageContent[0].urlThumbnail : value.imageContent[0].url),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10, top: 10),
                      child: Icon(AllInOneIcon.create_galang_amal_3x,
                          color: whiteColor, size: 25),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                      child: Text(
                        value.descriptionProgram,
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

  Widget bantuKamiRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Container(
                height: 186,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(ExplorerText.bantuKamiUrl1),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 55, top: 10),
                        child: Icon(ExplorerText.jenisKebaikan[0],
                            color: whiteColor, size: 25),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        child: Text(ExplorerText.bantuKamiDesc1,
                            style: TextStyle(color: whiteColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Container(
                height: 186,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(ExplorerText.bantuKamiUrl2),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 55, top: 10),
                        child: Icon(ExplorerText.jenisKebaikan[1],
                            color: whiteColor, size: 25),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 20),
                        child: Text(ExplorerText.bantuKamiDesc2,
                            style: TextStyle(color: whiteColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    bloc.fetchAllProgramAmal('');
    super.initState();
  }
}
