import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/utils/textUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_explorer/elastic_search.dart';
import 'package:flutter_jaring_ummat/src/views/page_explorer/explorer_aktivitas_amal.dart';
import 'package:flutter_jaring_ummat/src/views/page_explorer/explorer_berita.dart';
import 'package:flutter_jaring_ummat/src/views/page_explorer/explorer_mitra_jejaring.dart';
import 'package:flutter_jaring_ummat/src/views/page_explorer/explorer_populer.dart';
import 'package:flutter_jaring_ummat/src/views/page_explorer/explorer_story_jejaring.dart';
import 'package:flutter_jaring_ummat/src/views/page_explorer/explorer_tanya_ustadz.dart';

class ExplorerPage extends StatefulWidget {
  @override
  _ExplorerPageState createState() => _ExplorerPageState();
}

class _ExplorerPageState extends State<ExplorerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Text(ExplorerText.titleBar,
              style: TextStyle(
                  fontSize: SizeUtils.titleSize, color: Colors.black)),
          actions: <Widget>[
            IconButton(
              onPressed: elasticSearch,
              icon: Icon(NewIcon.search_small_2x),
              color: blackColor,
              iconSize: 25,
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4, color: greenColor),
            ),
            labelColor: blackColor,
            unselectedLabelColor: grayColor,
            tabs: <Widget>[
              Tab(text: 'Populer'),
              Tab(text: 'Aktivitas Amal'),
              Tab(text: 'Story Jejaring'),
              Tab(text: 'Tanya Ustadz'),
              Tab(text: 'Mitra Jejaring'),
              Tab(text: 'Berita')
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ExplorerPopulerView(),
            ExplorerAktivitasAmalView(),
            ExplorerStoryJejaringView(),
            ExplorerTanyaUstadzView(),
            ExplorerMitraJejaringView(),
            ExplorerBeritaView(),
          ],
        ),
      ),
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
                        padding: const EdgeInsets.only(left: 10, bottom: 55, top: 10),
                        child: Icon(ExplorerText.jenisKebaikan[0], color: whiteColor, size: 25),
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
                        padding: const EdgeInsets.only(left: 10, bottom: 55, top: 10),
                        child: Icon(ExplorerText.jenisKebaikan[1], color: whiteColor, size: 25),
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

  void elasticSearch() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ElasticSearch(),
      ),
    );
  }
}
