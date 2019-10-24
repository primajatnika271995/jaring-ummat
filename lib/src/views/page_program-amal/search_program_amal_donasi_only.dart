import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ReturnData.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/donasi_only.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProgramAmalDonasiOnly extends StatefulWidget {
  @override
  _SearchProgramAmalDonasiOnlyState createState() => _SearchProgramAmalDonasiOnlyState();
}

class _SearchProgramAmalDonasiOnlyState extends State<SearchProgramAmalDonasiOnly> {
  final _searchCtrl = new TextEditingController();
  bool _isSearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: whiteColor,
          elevation: 1,
          title: searchForm(),
          actions: <Widget>[
            IconButton(
              icon: Icon(AllInOneIcon.close_2x, size: 25, color: blackColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[_isSearch ? Container() : recomendation()],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget recomendation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text('Rekomendasi Pilihan Lokasi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: OutlineButton(
                  onPressed: () {
                    _searchCtrl.text = 'Jakarta';
                    _isSearch = true;
                    ProgramAmalReturn value = ProgramAmalReturn(
                      lokasi: _searchCtrl.text,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DonasiOnlyScreen(value: value),
                    ));
                    setState(() {});
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('DKI Jakarta',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                  color: grayColor,
                  borderSide: BorderSide(width: 2, color: Colors.grey[200]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: OutlineButton(
                  onPressed: () {
                    _searchCtrl.text = 'Bandung';
                    _isSearch = true;
                    ProgramAmalReturn value = ProgramAmalReturn(
                      lokasi: _searchCtrl.text,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DonasiOnlyScreen(value: value),
                    ));
                    setState(() {});
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Bandung',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                  color: grayColor,
                  borderSide: BorderSide(width: 2, color: Colors.grey[200]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: OutlineButton(
                  onPressed: () {
                    _searchCtrl.text = 'Surabaya';
                    _isSearch = true;
                    ProgramAmalReturn value = ProgramAmalReturn(
                      lokasi: _searchCtrl.text,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DonasiOnlyScreen(value: value),
                    ));
                    setState(() {});
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Surabaya',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                  color: grayColor,
                  borderSide: BorderSide(width: 2, color: Colors.grey[200]),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: OutlineButton(
                  onPressed: () {
                    _searchCtrl.text = 'Papua';
                    _isSearch = true;
                    ProgramAmalReturn value = ProgramAmalReturn(
                      lokasi: _searchCtrl.text,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DonasiOnlyScreen(value: value),
                    ));
                    setState(() {});
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Papua',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                  color: grayColor,
                  borderSide: BorderSide(width: 2, color: Colors.grey[200]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: OutlineButton(
                  onPressed: () {
                    _searchCtrl.text = 'Banten';
                    _isSearch = true;
                    ProgramAmalReturn value = ProgramAmalReturn(
                      lokasi: _searchCtrl.text,
                    );
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DonasiOnlyScreen(value: value),
                    ));
                    setState(() {});
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Banten',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold)),
                  color: grayColor,
                  borderSide: BorderSide(width: 2, color: Colors.grey[200]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
              hintText: 'Cari kota, kabupaten, atau provinsi',
            ),
            controller: _searchCtrl,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              print('Selesai');
              print(_searchCtrl.text);
              _isSearch = true;
              ProgramAmalReturn value = ProgramAmalReturn(
                lokasi: _searchCtrl.text,
              );
//              Navigator.of(context).pop(value);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DonasiOnlyScreen(),
              ));
            },
          ),
          Align(
            alignment: Alignment(-0.95, -1),
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
}
