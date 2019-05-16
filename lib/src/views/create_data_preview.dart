import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_jaring_ummat/src/services/news_service.dart';

class PreviewData extends StatefulWidget {
  final String newsId;
  final String iconImg;
  final String profileName;
  final String category;
  final String title;
  final File newsImg;
  final File newsImg1;
  final String postedBy;
  final String excerpt;

  PreviewData(
      {Key key,
      this.newsId,
      this.iconImg,
      this.profileName,
      this.category,
      this.newsImg,
      this.newsImg1,
      this.title,
      this.postedBy,
      this.excerpt});

  @override
  _PreviewDataState createState() => _PreviewDataState();
}

class _PreviewDataState extends State<PreviewData> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoved = false;

  bool flag = true;

  bool _isSubmit = false;

  String lessDesc;
  String moreDesc;

  @override
  void initState() {
    super.initState();

    if (widget.excerpt.length > 150) {
      lessDesc = widget.excerpt.substring(0, 150);
      moreDesc = widget.excerpt.substring(150, widget.excerpt.length);
    } else {
      lessDesc = widget.excerpt;
      moreDesc = "";
    }
  }

  Future onCreateBerita() async {
    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        duration: new Duration(seconds: 2),
        content: new Row(
          children: <Widget>[
            new CircularProgressIndicator(),
            new Text(" Please Wait ... ")
          ],
        ),
      ),
    );

    setState(() {
      _isSubmit = true;
    });

    NewsService newsService = NewsService();
    await newsService
        .saveNews(
            widget.title,
            widget.newsId,
            widget.category,
            widget.excerpt,
            widget.postedBy,
            widget.newsImg.path,
            widget.newsImg1.path,
            widget.newsImg.path)
        .then((response) {
      if (response.statusCode == 201) {
        setState(() {
          _isSubmit = false;
        });
        print("Data Berita Berhasil Disimpan");
        Navigator.of(context).pushReplacementNamed("/home");
      }
    });
  }

  Widget getProfilePicture() {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: (widget.iconImg != '')
            ? NetworkImage(widget.iconImg)
            : AssetImage("assets/users/bamuis-bni.png"),
        fit: BoxFit.contain,
      )),
    );
  }

  Widget getTopInformation() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Kegiatan ${widget.category}',
            style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          Text(
            'Bandung, 27 Desember 2018',
            style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget setTopContent() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          getTopInformation(),
        ],
      ),
    );
  }

  Widget setMainImage() {
    return Container(
      height: 250.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.0), topRight: Radius.circular(7.0)),
          image: DecorationImage(
            image: FileImage(widget.newsImg),
            fit: BoxFit.cover,
          )),
    );
  }

  Widget setDescription() {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: moreDesc.isEmpty
          ? new Text(
              lessDesc,
              style: TextStyle(color: Colors.black45),
            )
          : new Column(
              children: <Widget>[
                new Text(
                  flag ? (lessDesc + "...") : (lessDesc + moreDesc),
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black45),
                ),
                new InkWell(
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget setButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            child: Text(
              'Cancel',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            onCreateBerita();
          },
          color: Color.fromRGBO(21, 101, 192, 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            child: Text(
              _isSubmit ? 'Loading ...' : 'Konfirmasi',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(47.0),
        child: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Overview Berita',
            style: TextStyle(fontSize: 15.0),
          ),
          centerTitle: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                color: Colors.white,
                boxShadow: [
                  new BoxShadow(
                      color: Colors.grey,
                      offset: new Offset(1.0, 1.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0)
                ],
              ),
              child: Column(
                children: <Widget>[
                  setMainImage(),
                  setTopContent(),
                  setDescription(),
//          setBottomContent(),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
              child: setButton(),
            ),
          ],
        ),
      ),
    );
  }
}
