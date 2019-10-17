import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';

class ExplorerPopulerView extends StatefulWidget {
  @override
  _ExplorerPopulerViewState createState() => _ExplorerPopulerViewState();
}

class _ExplorerPopulerViewState extends State<ExplorerPopulerView> {
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
                          const EdgeInsets.only(left: 10, top: 20),
                      child: Icon(AllInOneIcon.donation_3x,
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

  @override
  void initState() {
    bloc.fetchAllProgramAmal('');
    super.initState();
  }
}
