import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<String> listPertanyaan = [
    'Bagaimana cara beramal melalui Jaring?',
    'Apakah amal Saya langsung diterima oleh Amil?',
    'Pertanyaan 3',
    'Pertanyaan 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 1,
        titleSpacing: 0,
        backgroundColor: whiteColor,
        title: Text('Tanya Jawab',
            style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize)),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(AllInOneIcon.back_small_2x),
          color: blackColor,
          iconSize: 20,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(AllInOneIcon.search_small_2x),
            color: blackColor,
            iconSize: 20,
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return pertanyaan(listPertanyaan[index]);
          },
        ),
      ),
    );
  }

  Widget pertanyaan(String pertanyaan) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: blueColor,
              child: Icon(AllInOneIcon.ask_jejaring_3x,
                  size: 20, color: whiteColor),
            ),
            title: Text('$pertanyaan',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              style: TextStyle(fontSize: 14),
              maxLength: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: CircleAvatar(
                    backgroundColor: Colors.yellowAccent,
                    child: Icon(AllInOneIcon.ask_jejaring_3x,
                        size: 20, color: whiteColor),
                  ),
                  hintText: 'Jawaban atas pertanyaan diatas...'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 70, right: 15, top: 10),
            child: new SizedBox(
              height: 10.0,
              child: new Center(
                child: new Container(
                    margin:
                        new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                    height: 5.0,
                    color: Colors.grey[200]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
