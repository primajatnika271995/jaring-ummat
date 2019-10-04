import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/elasticSearchModel.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/elasticSearchBloc.dart';

class ElasticSearch extends StatefulWidget {
  @override
  _ElasticSearchState createState() => _ElasticSearchState();
}

class _ElasticSearchState extends State<ElasticSearch> {
  final _searchCtrl = new TextEditingController();
  bool showRecomended = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: whiteColor,
          elevation: 1,
          title: searchForm(),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: InkWell(
                onTap: () {
                  _searchCtrl.clear();
                },
                child: Icon(AllInOneIcon.clear_search_history_3x,
                    size: 20, color: blackColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(AllInOneIcon.close_2x, size: 20, color: blackColor),
              ),
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
              Tab(text: 'Semua'),
              Tab(text: 'Aktivitas Amal'),
              Tab(text: 'Story Jejaring'),
              Tab(text: 'Tanya Ustadz'),
              Tab(text: 'Akun Mitra'),
              Tab(text: 'Berita')
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              recomendation(),
              StreamBuilder(
                stream: bloc.streamData,
                builder: (context, AsyncSnapshot<ElasticSearchModel> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: Text('Waiting..'),
                      );
                      break;
                    default:
                      if (snapshot.hasData &&
                          snapshot.data.hits.hits.isNotEmpty) {
                        return listResult(snapshot.data);
                      } else if (snapshot.data.hits.hits.isEmpty) {
                        return Container(
                          width: screenWidth(context),
                          color: whiteColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/backgrounds/no_data_accent.png',
                                height: 250,
                              ),
                              Text(
                                'Oops, Data Tidak Ditemukan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Tidak ada hasil pencarian berdasarkan \n kata pencarian "${_searchCtrl.text}"',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: Text('Error'),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    bloc.fetchElasticData('');
    super.initState();
  }

  Widget searchForm() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Stack(
        children: <Widget>[
          TextFormField(
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(40, 10, 15, 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                borderSide: BorderSide(color: greenColor),
              ),
              hintText: 'Apa yang kamu cari?',
            ),
            controller: _searchCtrl,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              print(_searchCtrl.text);
              bloc.fetchElasticData(_searchCtrl.text);
            },
          ),
          Align(
            alignment: Alignment(-0.9, -1),
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Icon(
                AllInOneIcon.search_small_2x,
                color: grayColor,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recomendation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text('Rekomendasi Kata Pencarian',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  _searchCtrl.text = 'Kemanusiaan';
                  bloc.fetchElasticData(_searchCtrl.text);
                  setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('Kemanusiaan', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                color: grayColor,
                borderSide: BorderSide(width: 2, color: Colors.grey[200]),
              ),
              OutlineButton(
                onPressed: () {
                  _searchCtrl.text = 'Donasi';
                  bloc.fetchElasticData(_searchCtrl.text);
                  setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('Donasi', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                color: grayColor,
                borderSide: BorderSide(width: 2, color: Colors.grey[200]),
              ),
              OutlineButton(
                onPressed: () {
                  _searchCtrl.text = 'Bamuis BNI';
                  bloc.fetchElasticData(_searchCtrl.text);
                  setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child:
                    Text('Bamuis BNI', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                color: grayColor,
                borderSide: BorderSide(width: 2, color: Colors.grey[200]),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  _searchCtrl.text = 'Bantuan Pendidikan';
                  bloc.fetchElasticData(_searchCtrl.text);
                  setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('Bantuan Pendidikan',
                    style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                color: grayColor,
                borderSide: BorderSide(width: 2, color: Colors.grey[200]),
              ),
              OutlineButton(
                onPressed: () {
                  _searchCtrl.text = 'Wakaf';
                  bloc.fetchElasticData(_searchCtrl.text);
                  setState(() {});
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('Wakaf Mesjid',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                color: grayColor,
                borderSide: BorderSide(width: 2, color: Colors.grey[200]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listResult(ElasticSearchModel snapshot) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, position) {
        return Padding(
          padding: EdgeInsets.only(left: 85, right: 20),
          child: new SizedBox(
            height: 10.0,
            child: new Center(
              child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.grey[200]),
            ),
          ),
        );
      },
      itemCount: snapshot.hits.hits.length,
      itemBuilder: (context, index) {
        var data = snapshot.hits.hits[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListTile(
            leading: Container(
              width: 45.0,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text('${data.source.category}',
                style: TextStyle(fontSize: 14, color: grayColor)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${data.source.title}',
                    style: TextStyle(
                        fontSize: 15,
                        color: blackColor,
                        fontWeight: FontWeight.bold)),
                Text('oleh ${data.source.createdBy}',
                    style: TextStyle(fontSize: 14, color: grayColor)),
              ],
            ),
          ),
        );
      },
    );
  }
}
