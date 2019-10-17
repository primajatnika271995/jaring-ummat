import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/details_lembaga.dart';

class ExplorerMitraJejaringView extends StatefulWidget {
  @override
  _ExplorerMitraJejaringViewState createState() => _ExplorerMitraJejaringViewState();
}

class _ExplorerMitraJejaringViewState extends State<ExplorerMitraJejaringView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: StreamBuilder(
        stream: bloc.allLembagaAmalList,
        builder: (context, AsyncSnapshot<List<LembagaAmalModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: Text('Waiting...'));
              break;
            default:
              if (snapshot.hasData) {
                return listBuilder(snapshot.data);
              }
              return Center(child: streamNoData());
          }
        },
      ),
    );
  }

  Widget listBuilder(List<LembagaAmalModel> snapshot) {
    return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      shrinkWrap: true,
      itemCount: snapshot.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsLembaga(
                  value: value,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(value.imageContent),
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
                      child: Icon(AllInOneIcon.account_following_3x,
                          color: whiteColor, size: 25),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                      child: Text(
                        value.lembagaAmalEmail,
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

  Widget streamNoData() {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgrounds/no_data_accent.png'),
        ),
      ),
    );
  }

  @override
  void initState() {
    bloc.fetchAllLembagaAmal('');
    super.initState();
  }
}
