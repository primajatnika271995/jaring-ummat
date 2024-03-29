import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';

class TermAndConditionPage extends StatefulWidget {
  @override
  _TermAndConditionPageState createState() => _TermAndConditionPageState();
}

class _TermAndConditionPageState extends State<TermAndConditionPage> {
  List<String> listTerms = [
    'Jaring Platform',
    'Layanan Jaring Platform',
    'Pihak yang Dilayani',
    'Syarat dan Ketentuan'
  ];

  bool _isApprove = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 1,
        titleSpacing: 0,
        backgroundColor: whiteColor,
        title: Text('Syarat dan Ketentuan',
            style: TextStyle(fontSize: SizeUtils.titleSize, color: blackColor)),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(AllInOneIcon.back_small_2x),
          color: blackColor,
          iconSize: 20,
        ),
        centerTitle: false,
      ),
      body: Container(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (context, index) {
            return pertanyaan(listTerms[index], index);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                _isApprove = !_isApprove;
                setState(() {});
              },
              icon: CircleAvatar(
                backgroundColor: _isApprove ? greenColor : Colors.grey,
                child: Icon(AllInOneIcon.checklist_2x,
                    color: _isApprove ? whiteColor : whiteColor, size: 20),
              ),
              iconSize: 20,
            ),
            Container(
              width: 250,
              child: const Text(
                'Saya telah menyetujui Syarat dan Ketentuan Jaring',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pertanyaan(String term, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundColor: blueColor,
              child: Text('${index + 1}',
                  style: TextStyle(color: whiteColor, fontSize: 15)),
            ),
            title: Text(
              '$term',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            subtitle: TextField(
              style: TextStyle(fontSize: 15),
              maxLines: null,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Deskripsi atas poin diatas...'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 70, right: 15),
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
