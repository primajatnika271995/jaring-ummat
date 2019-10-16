import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/utils/textUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';

class ExplorerTanyaUstadzView extends StatefulWidget {
  @override
  _ExplorerTanyaUstadzViewState createState() => _ExplorerTanyaUstadzViewState();
}

class _ExplorerTanyaUstadzViewState extends State<ExplorerTanyaUstadzView> {
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(value.imageContent[0].url),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 10, bottom: 95, top: 10),
                    child: Icon(AllInOneIcon.donation_3x,
                        color: whiteColor, size: 35),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 20, right: 10),
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
    bloc.fetchAllProgramAmal('tanya_ustadz');
    super.initState();
  }
}
