import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/details_berita.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/details_data_mitra.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/details_galang_amal.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/details_portofolio.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/details_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/loginBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';

class DetailsLembaga extends StatefulWidget {
  final LembagaAmalModel value;
  DetailsLembaga({this.value});

  @override
  _DetailsLembagaState createState() => _DetailsLembagaState(value: this.value);
}

class _DetailsLembagaState extends State<DetailsLembaga> {
  LembagaAmalModel value;
  _DetailsLembagaState({this.value});

  int _tabLength = 5;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLength,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: whiteColor,
          titleSpacing: 0,
          leading: IconButton(
            icon: Icon(AllInOneIcon.back_small_2x),
            onPressed: () => Navigator.of(context).pop(),
            color: blackColor,
            iconSize: 20,
          ),
          title: Text(
            'Profil ${this.value.lembagaAmalName}',
            style: TextStyle(
                color: blackColor,
                fontSize: SizeUtils.titleSize,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(left: 10),
              icon: Icon(AllInOneIcon.share_3x),
              color: blackColor,
              iconSize: 25,
              onPressed: () {},
            ),
            IconButton(
              padding: EdgeInsets.only(right: 10),
              icon: Icon(AllInOneIcon.chat_3x),
              color: blackColor,
              iconSize: 25,
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Data Mitra'),
              Tab(text: 'Galang Amal'),
              Tab(text: 'Story'),
              Tab(text: 'Berita'),
              Tab(text: 'Portofolio'),
            ],
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            isScrollable: true,
            unselectedLabelColor: grayColor,
            indicatorColor: greenColor,
            labelColor: blackColor,
          ),
        ),
        body: TabBarView(children: [
          DataMitra(
            value: value,
          ),
          ProgramAmalLembaga(
            idUser: value.idUser,
            category: "programku",
          ),
          StoryLembagaAmal(
            userId: value.idUser,
          ),
          BeritaLembaga(
            idUser: value.idUser,
            category: "beritaku",
          ),
          PortofolioLembagaAmal(idLembaga: value.idLembagaAmal),
        ]),
      ),
    );
  }

  @override
  void initState() {
    bloc.userDetails(context, value.idLembagaAmal);
    super.initState();
  }
}

