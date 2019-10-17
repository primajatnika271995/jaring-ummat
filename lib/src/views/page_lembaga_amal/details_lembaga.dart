import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/penerimaanAmalTerbesarModel.dart';
import 'package:flutter_jaring_ummat/src/models/sebaranAktifitasAmalModel.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/services/portofolioPenerimaanApi.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_views.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/loginBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/barChartModel.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/calculator_other_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/sosial_media_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart' as programBloc;
import 'package:flutter_jaring_ummat/src/bloc/beritaBloc.dart' as beritaBloc;
import 'package:flutter_jaring_ummat/src/bloc/portofolioPenerimaanBloc.dart' as portofolioBloc;
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_content.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';

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
          Center(
            child: Text('Story'),
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

class DataMitra extends StatefulWidget {
  final LembagaAmalModel value;
  DataMitra({this.value});

  @override
  _DataMitraState createState() => _DataMitraState(value: value);
}

class _DataMitraState extends State<DataMitra> {
  LembagaAmalModel value;
  _DataMitraState({this.value});

  final _phoneCtrl = new TextEditingController();
  final _emailCtrl = new TextEditingController();
  final _dateCtrl = new TextEditingController();
  final _addressCtrl = new TextEditingController();

  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage('${value.imageContent}'),
                  radius: 35,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    '${value.lembagaAmalName}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 35),
                  child: Text(
                    'Yayasan penghimpun dan pengelola dana masyarakat dengan cara yang diridhai Allah SWT.',
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                value.followThisAccount ? followedBtn() : unfollowedBtn(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: aktivitas(),
                ),
                emailField(),
                phoneField(),
                dateField(),
                addressField(),
                qrCode(),
                btnInfo(),
                shareSocial(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _emailCtrl.text = value.lembagaAmalEmail;
    _phoneCtrl.text = value.lembagaAmalContact;
    _addressCtrl.text = value.lembagaAmalAddress;
    setState(() {});
    super.initState();
  }

  Widget qrCode() {
    return InkWell(
      onTap: _barCodePopUp,
      child: (value.lembagaAmalEmail == null)
          ? CircularProgressIndicator()
          : Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: QrImage(
            data: value.lembagaAmalEmail,
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            errorStateBuilder: (cxt, err) {
              return Container(
                child: Center(
                  child: Text(
                    "Loading QR Code...",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
        width: 120.0,
        height: 120.0,
      ),
    );
  }

  Future _barCodePopUp() {
    return showDialog(
      context: (context),
      builder: (_) => Dialog(
        child: Container(
          height: 300,
          width: 300,
          child: Center(
            child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                data: value.lembagaAmalEmail,
                version: QrVersions.auto,
                size: 170,
                gapless: false,
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Loading QR Code...",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }


  Widget followedBtn() {
    return OutlineButton(
      onPressed: () {},
      color: greenColor,
      child: const Text(
        'Following',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      borderSide: BorderSide(
        color: Colors.green, //Color of the border
        style: BorderStyle.solid, //Style of the border
        width: 2.8, //width of the border
      ),
    );
  }

  Widget unfollowedBtn() {
    return OutlineButton(
      onPressed: () {},
      color: grayColor,
      child: const Text(
        'Follow',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      borderSide: BorderSide(
        color: Colors.grey, //Color of the border
        style: BorderStyle.solid, //Style of the border
        width: 2.8, //width of the border
      ),
    );
  }

  Widget aktivitas() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      childAspectRatio: 2.4,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(left: 15, right: 15),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200], width: 3),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(AllInOneIcon.edittext_people_3x,
                      color: whiteColor, size: 20),
                ),
                SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Follower',
                      style: TextStyle(color: grayColor, fontSize: 12),
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: '${value.totalFollowers}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: blackColor),
                        ),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200], width: 3),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child:
                  Icon(AllInOneIcon.love_3x, color: whiteColor, size: 20),
                ),
                SizedBox(
                  width: 7,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Galang Amal',
                      style: TextStyle(color: grayColor, fontSize: 12),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '${value.totalPostProgramAmal}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: blackColor),
                          ),
                          TextSpan(
                              text: ' Aksi',
                              style: TextStyle(color: grayColor, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget phoneField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: true,
            controller: _phoneCtrl,
            decoration: InputDecoration(
              labelText: 'Nomor Telepon',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(NewIcon.edittext_phone_3x,
                    color: whiteColor, size: 20),
              ),
            ),
          ),
          Container(
            child: OutlineButton(
              onPressed: () {},
              child: const Text('Hubungi',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );
  }

  Widget emailField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: true,
            controller: _emailCtrl,
            decoration: InputDecoration(
              labelText: 'Email',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(AllInOneIcon.edittext_name_3x,
                    color: whiteColor, size: 20),
              ),
            ),
          ),
          Container(
            child: OutlineButton(
              onPressed: () {},
              child: const Text('Kirim Email',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );
  }

  Widget dateField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: true,
            controller: _dateCtrl,
            decoration: InputDecoration(
              labelText: 'Tanggal Berdiri',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Icon(
                  CalculatorOtherIcon.edittext_birtdate_3x,
                  color: whiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addressField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            maxLines: null,
            maxLengthEnforced: true,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: true,
            controller: _addressCtrl,
            decoration: InputDecoration(
              labelText: 'Alamat Kantor',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(CalculatorOtherIcon.location_inactive_3x,
                    color: whiteColor, size: 20),
              ),
            ),
          ),
          _addressCtrl.text.length <= 10
              ? Container(
            child: OutlineButton(
              onPressed: () {},
              child: const Text('Lihat di Maps',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
              : Container(),
        ],
      ),
    );
  }

  Widget btnInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: Text(
        'Ikuti akun ${value.lembagaAmalName} di beberapa social media dibawah ini agar kamu bisa lebih dekat dengan Kami.',
        style: TextStyle(color: grayColor, fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget shareSocial() {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.facebook),
            iconSize: 40.0,
            color: facebookColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.google),
            iconSize: 40.0,
            color: googleColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(SosialMedia.linkedin),
            iconSize: 40.0,
            color: linkedInColor,
          ),
        ],
      ),
    );
  }
}

class ProgramAmalLembaga extends StatefulWidget {
  final String idUser;
  final String category;
  ProgramAmalLembaga({this.idUser, this.category});

  @override
  _ProgramAmalLembagaState createState() =>
      _ProgramAmalLembagaState(idUser: this.idUser, category: this.category);
}

class _ProgramAmalLembagaState extends State<ProgramAmalLembaga> {
  String idUser;
  String category;
  _ProgramAmalLembagaState({this.idUser, this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: programBloc.bloc.allProgramAmal,
              builder:
                  (context, AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('');
                    break;
                  default:
                    if (snapshot.hasData) {
                      return buildList(snapshot);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Container(
                      width: screenWidth(context),
                      color: whiteColor,
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/backgrounds/no_data_accent.png',
                              height: 250),
                          Text(
                            'Oops..',
                            style: TextStyle(
                              fontFamily: 'Proxima',
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'There\'s nothing \'ere, yet.',
                            style: TextStyle(
                              fontFamily: 'Proxima',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    );
                    break;
                }
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    programBloc.bloc.fetchAllProgramAmalDetailLembaga(idUser, category);
    super.initState();
  }

  Widget buildList(AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.data[index];
        return ProgramAmalContent(
          programAmal: value,
          bookmark: value.bookmarkThis,
        );
      },
    );
  }
}

class BeritaLembaga extends StatefulWidget {
  final String idUser;
  final String category;
  BeritaLembaga({this.idUser, this.category});

  @override
  _BeritaLembagaState createState() => _BeritaLembagaState(idUser: this.idUser, category: this.category);
}

class _BeritaLembagaState extends State<BeritaLembaga> {
  String idUser;
  String category;
  _BeritaLembagaState({this.idUser, this.category});

  String selectedCategory = "beritaku";

  bool _loadingVisible = false;

  var formatter = new DateFormat('dd MMM yyyy HH:mm:ss');

  /*
   * Image No Content Replace with This
   */
  final List<String> imgNoContent = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png"
  ];

  /*
   * Variable Current Image
   */
  int current = 0;
  int currentImage = 1;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  children: <Widget>[
                    Container(
                      child: StreamBuilder(
                          stream: beritaBloc.bloc.allBerita,
                          builder: (context,
                              AsyncSnapshot<List<BeritaModel>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Text('');
                                break;
                              default:
                                if (snapshot.hasData) {
                                  var data = snapshot.data[0];
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BeritaViews(value: data),
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          children: <Widget>[
                                            CarouselSlider(
                                              height: 260.0,
                                              autoPlay: false,
                                              reverse: false,
                                              viewportFraction: 1.0,
                                              aspectRatio:
                                              MediaQuery.of(context)
                                                  .size
                                                  .aspectRatio,
                                              items: (data.imageContent == null)
                                                  ? imgNoContent.map((url) {
                                                return Container(
                                                  child: CachedNetworkImage(
                                                      imageUrl: url,
                                                      fit: BoxFit.cover,
                                                      width:
                                                      MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width),
                                                );
                                              }).toList()
                                                  : data.imageContent.map(
                                                    (url) {
                                                  return Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        child:
                                                        CachedNetworkImage(
                                                          imageUrl: url.resourceType ==
                                                              "video"
                                                              ? url
                                                              .urlThumbnail
                                                              : url.url,
                                                          fit: BoxFit
                                                              .cover,
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width,
                                                        ),
                                                      ),
                                                      url.resourceType ==
                                                          "video"
                                                          ? Positioned(
                                                        right: screenWidth(
                                                            context,
                                                            dividedBy:
                                                            2.3),
                                                        top: screenHeight(
                                                            context,
                                                            dividedBy:
                                                            8),
                                                        child:
                                                        InkWell(
                                                          onTap: () =>
                                                              showMediaPlayer(
                                                                  url.url),
                                                          child:
                                                          CircleAvatar(
                                                            radius:
                                                            30,
                                                            backgroundColor:
                                                            greenColor,
                                                            child:
                                                            Icon(
                                                              AllInOneIcon
                                                                  .play_4x,
                                                              color:
                                                              whiteColor,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                          : Container(),
                                                    ],
                                                  );
                                                },
                                              ).toList(),
                                              onPageChanged: (index) {
                                                current = index;
                                                currentImage = index + 1;
                                                setState(() {});
                                              },
                                            ),
                                            Positioned(
                                              right: 20.0,
                                              top: 10.0,
                                              child: Badge(
                                                badgeColor: blackColor,
                                                elevation: 0.0,
                                                shape: BadgeShape.square,
                                                borderRadius: 10,
                                                toAnimate: false,
                                                badgeContent: (data
                                                    .imageContent ==
                                                    null)
                                                    ? Text(
                                                  '$currentImage / ${imgNoContent.length}',
                                                  style: TextStyle(
                                                      color: whiteColor),
                                                )
                                                    : Text(
                                                  '$currentImage / ${data.imageContent.length}',
                                                  style: TextStyle(
                                                      color: whiteColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 20.0, top: 10.0),
                                        child: const Text(
                                          'Kegiatan',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10.0,
                                          right: 20.0,
                                          top: 0.0,
                                        ),
                                        child: Text(
                                          data.titleBerita,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10.0,
                                          right: 15.0,
                                          top: 5.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 5.0,
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    data.createdBy,
                                                    style:
                                                    TextStyle(fontSize: 12),
                                                  ),
                                                  Text(
                                                      formatter
                                                          .format(DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                          data.createdDate *
                                                              1000))
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 11))
                                                ],
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5.0,
                                                right: 5.0,
                                                bottom: 5.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[
                                                  // Icon(NewIcon.love_3x,
                                                  //     color: blackColor,
                                                  //     size: 20.0),
                                                  // SizedBox(width: 10.0),
                                                  Icon(
                                                    NewIcon.save_3x,
                                                    color: blackColor,
                                                    size: 20.0,
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Icon(
                                                    NewIcon.share_3x,
                                                    color: blackColor,
                                                    size: 20.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                        child: new Center(
                                          child: new Container(
                                            margin:
                                            new EdgeInsetsDirectional.only(
                                                start: 1.0, end: 1.0),
                                            height: 5.0,
                                            color: softGreyColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                            }
                            return Container();
                          }),
                    ),
                    StreamBuilder(
                      stream: beritaBloc.bloc.allBerita,
                      builder:
                          (context, AsyncSnapshot<List<BeritaModel>> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            _loadingVisible = true;
                            return Text('');
                            break;
                          default:
                            if (snapshot.hasData) {
                              _loadingVisible = false;
                              return buildList(snapshot);
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            _loadingVisible = false;
                            return Container(
                              width: screenWidth(context),
                              color: whiteColor,
                              margin: EdgeInsets.only(top: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                      'assets/backgrounds/no_data_accent.png',
                                      height: 250),
                                  Text(
                                    'Oops..',
                                    style: TextStyle(
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'There\'s nothing \'ere, yet.',
                                    style: TextStyle(
                                      fontFamily: 'Proxima',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            );
                            break;
                        }
                      },
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  Widget buildList(AsyncSnapshot<List<BeritaModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.data[index];
        return BeritaContent(
          berita: value,
        );
      },
    );
  }

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void showMediaPlayer(String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 250,
            color: Colors.transparent,
            width: screenWidth(context),
            child: SimpleViewPlayer(
              url,
              isFullScreen: false,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    beritaBloc.bloc.fetchAllBeritaLembagaAmal(idUser, selectedCategory);
  }
}

class PortofolioLembagaAmal extends StatefulWidget {
  final String idLembaga;
  PortofolioLembagaAmal({this.idLembaga});
  @override
  _PortofolioLembagaAmalState createState() =>
      _PortofolioLembagaAmalState(idLembaga: this.idLembaga);
}

class _PortofolioLembagaAmalState extends State<PortofolioLembagaAmal> {
  String idLembaga;
  _PortofolioLembagaAmalState({this.idLembaga});
  /*
   * Format for Current Month
   */
  static var now = new DateTime.now();
  static var formatter = new DateFormat('MM');
  static String month = formatter.format(now);

  /*
   * From Libs charts_flutter
   */
  static List<BarchartModel> barData;
  List<charts.Series<BarchartModel, String>> _seriesLineData;

  /*
   * Tab Index
   */
  int indexTab = 0;
  String selectedCategory = "all";

  /*
   * Variable Temp
   */
  String emailCustomer;
  String customerName;
  String customerPhone;

  /*
   * Variable Temp Pie Chart
   */
  double valueZakat = 0;
  double valueInfaq = 0;
  double valueShodqoh = 0;
  double valueWakaf = 0;
  double valueDonasi = 0;
  double valueTotal = 0;
  double valueBackup = 0;
  int valueTotalAktivitas = 0;

  /*
   * Variable Temp Percent
   */

  double zakatPercent = 0;
  double infaqPercent = 0;
  double wakafPercent = 0;
  double shodaqohPercent = 0;
  double donasiPercent = 0;

  List<int> lengthBarChart = [0, 0, 0, 0, 0, 0, 0, 0, 120000, 0, 0, 0];
  double fillPercent;

  /*
   * Boolen for Loading
   */
  bool _loadingVisible = false;

  /*
   * Bar Chart Default Color
   */

  var barColor = Colors.teal;

  /*
   *  No Image Content
   */
  final String noImg =
      "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png";

  List<PenerimaanAmalTerbesarModel> _listAktivitasPenerimaanAmalTerbaruCache =
  new List<PenerimaanAmalTerbesarModel>();

  @override
  Widget build(BuildContext context) {
    // Sebaran Aktivitas Widget

    final sebaranAktifitas = Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Sebaran Aktivitas Amal',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Hey $customerName, terimakasih telah berpartisipasi pada beberapa aktivitas amal dan berikut ini sebaran aktivitasmu pada periode berjalan.',
            textAlign: TextAlign.justify,
          ),
          trailing: IconButton(
            onPressed: null,
            icon: Icon(
              NewIcon.next_small_2x,
              color: blackColor,
              size: 20,
            ),
          ),
        ),
        Container(
          height: 250,
          child: getDefaultDoughnutChart(false),
        ),
      ],
    );

    // Tren Aktivitas Harian / Line Chart

    final trenAktivitas = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text('Tren Aktivitas Amal Harian',
              style: TextStyle(
                color: blackColor,
                fontWeight: FontWeight.bold,
              )),
        ),
        buildBarChart(context),
      ],
    );

    // Sebaran Aktivitas Terbesar Widget

    final aktivitasTerbesar = Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        ListTile(
          title: Text(
            'Penerimaan amal terbesar',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '3 aktivitas amal terbesarmu berdasarkan nominal. Yuk perbanyak lagi amalmu dengan menekan tombol "+".',
            textAlign: TextAlign.justify,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(NewIcon.next_small_2x),
            color: blackColor,
            iconSize: 20,
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: StreamBuilder(
              stream: portofolioBloc.bloc.penerimaAmalTerbesarStream,
              builder: (context,
                  AsyncSnapshot<List<PenerimaanAmalTerbesarModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading');
                    break;
                  default:
                    if (snapshot.hasData) {
                      return listPenerimaAmalTerbesar(snapshot);
                    }
                    return GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey[200], width: 3),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(child: Text('No Data')),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey[200], width: 3),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(child: Text('No Data')),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey[200], width: 3),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(child: Text('No Data')),
                        ),
                      ],
                    );
                }
              }),
        ),
      ],
    );

    final aktivitasTerbaru = Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Penerimaan amal terbaru',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('3 aktivitas amal terbarumu pada semua kategori.'),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(NewIcon.next_small_2x),
            color: blackColor,
            iconSize: 20,
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: _listAktivitasPenerimaanAmalTerbaruCache == null
              ? Center(
            child: Text('Load Data'),
          )
              : listPenerimaAmalTerbaru(
              _listAktivitasPenerimaanAmalTerbaruCache),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: whiteColor,
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: DefaultTabController(
          length: 6,
          initialIndex: indexTab,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        // mySaldoGrid,
                        sebaranAktifitas,
                      ],
                    ),
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    child: Column(
                      children: <Widget>[trenAktivitas],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[aktivitasTerbesar],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[aktivitasTerbaru],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listPenerimaAmalTerbaru(List<PenerimaanAmalTerbesarModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.length <= 3 ? snapshot.length : 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var value = snapshot[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200], width: 3),
              borderRadius: BorderRadius.circular(13),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: value.category == "zakat"
                    ? Colors.yellow
                    : value.category == "infaq"
                    ? Colors.redAccent
                    : value.category == "sodaqoh"
                    ? Colors.deepPurple
                    : value.category == "wakaf"
                    ? Colors.green
                    : value.category == "donasi"
                    ? Colors.blue
                    : Colors.blue,
                child: Icon(
                  value.category == "zakat"
                      ? ProfileInboxIcon.zakat_3x
                      : value.category == "infaq"
                      ? ProfileInboxIcon.infaq_3x
                      : value.category == "sodaqoh"
                      ? ProfileInboxIcon.sodaqoh_3x
                      : value.category == "wakaf"
                      ? ProfileInboxIcon.wakaf_3x
                      : value.category == "donasi"
                      ? ProfileInboxIcon.donation_3x
                      : ProfileInboxIcon.donation_3x,
                  color: whiteColor,
                  size: 20,
                ),
              ),
              title: Text('${value.nama}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Text(
                  '${TimeAgoService().timeAgoFormatting(value.requestedDate)}',
                  style: TextStyle(fontSize: 12)),
              trailing: Text(
                  'Rp ${CurrencyFormat().data.format(value.totalAmal.toDouble())}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        );
      },
    );
  }

  Widget listPenerimaAmalTerbesar(
      AsyncSnapshot<List<PenerimaanAmalTerbesarModel>> snapshot) {
    return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: snapshot.data.length <= 3 ? snapshot.data.length : 3,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (constext, index) {
        var value = snapshot.data[index];
        return Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200], width: 3),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: greenColor,
                  child: (value.imageContent == null)
                      ? CircularProfileAvatar(noImg)
                      : CircularProfileAvatar(value.imageContent)),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: Text(
                  '${value.nama}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('${value.totalAktifitas} Aktivitas',
                  style: TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis),
              SizedBox(
                height: 3,
              ),
              Text(
                'Rp ${CurrencyFormat().data.format(value.totalAmal.toDouble())}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    portofolioBloc.bloc.fetchPenerimaAmalTerbesarLembagaDetails(idLembaga);
    portofolioBloc.bloc.fetchPenerimaAmalTerbaruLembagaDetails(idLembaga);
    portofolioBloc.bloc.fetchBarChartLembagaDetails(idLembaga, null, "satu");
    getDataPieChart();
    getAktivitasPenerimaanAmalTerbaruCache();
    getUser();
  }

  void getUser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      emailCustomer = _pref.getString(EMAIL_KEY);
      customerName = _pref.getString(FULLNAME_KEY);
      customerPhone = _pref.getString(CONTACT_KEY);
    });
  }

  Widget getDefaultDoughnutChart(bool isTileView) {
    return SfCircularChart(
      legend: Legend(
        isVisible: isTileView ? false : true,
        position: LegendPosition.right,
        itemPadding: 15,
        isResponsive: true,
        padding: 2,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      series: getDoughnutSeries(isTileView),
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Container(
            child: Text(
              'Rp ${CurrencyFormat().data.format(valueTotal.toDouble())} \n /$valueTotalAktivitas Aktivitas',
              style: TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
      palette: [
        Colors.red,
        Colors.yellow,
        Colors.deepOrange,
        Colors.deepPurpleAccent,
        Colors.blue,
        Colors.teal
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
      onLegendTapped: (LegendTapArgs value) {
        print(value.pointIndex);
        switch (value.pointIndex) {
          case 5:
            valueTotal = valueBackup;
            barColor = Colors.teal;
            print(valueTotal);
            portofolioBloc.bloc.fetchBarChart("", "satu");
            setState(() {});
            break;
        }
      },
      onPointTapped: (PointTapArgs value) {
        print(value.pointIndex);
        switch (value.pointIndex) {
          case 0:
            valueTotal = valueZakat;
            barColor = Colors.red;
            print(valueTotal);
            portofolioBloc.bloc.fetchBarChart("zakat", "satu");
            setState(() {});
            break;
          case 1:
            valueTotal = valueInfaq;
            barColor = Colors.yellow;
            print(valueTotal);
            portofolioBloc.bloc.fetchBarChart("infaq", "satu");
            setState(() {});
            break;
          case 2:
            valueTotal = valueShodqoh;
            barColor = Colors.redAccent[200];
            print(valueTotal);
            portofolioBloc.bloc.fetchBarChart("sodaqoh", "satu");
            setState(() {});
            break;
          case 3:
            valueTotal = valueWakaf;
            barColor = Colors.deepPurple;
            print(valueTotal);
            portofolioBloc.bloc.fetchBarChart("wakaf", "satu");
            setState(() {});
            break;
          case 4:
            valueTotal = valueDonasi;
            barColor = Colors.blue;
            print(valueTotal);
            portofolioBloc.bloc.fetchBarChart("donasi", "satu");
            setState(() {});
            break;
        }
      },
    );
  }

  List<DoughnutSeries<_DoughnutData, String>> getDoughnutSeries(
      bool isTileView) {
    final List<_DoughnutData> chartData = <_DoughnutData>[
      _DoughnutData('Zakat', zakatPercent, '$zakatPercent %'),
      _DoughnutData('Infaq', infaqPercent, '$infaqPercent %'),
      _DoughnutData('Sodaqoh', shodaqohPercent, '$shodaqohPercent %'),
      _DoughnutData('Wakaf', wakafPercent, '$wakafPercent %'),
      _DoughnutData('Donasi', donasiPercent, '$donasiPercent %'),
      _DoughnutData('Total', 0, ''),
    ];
    return <DoughnutSeries<_DoughnutData, String>>[
      DoughnutSeries<_DoughnutData, String>(
        radius: '100%',
        innerRadius: '67%',
        legendIconType: LegendIconType.circle,
        explode: true,
        explodeOffset: '10%',
        enableSmartLabels: true,
        dataSource: chartData,
        xValueMapper: (_DoughnutData data, _) => data.xData,
        yValueMapper: (_DoughnutData data, _) => data.yData,
        dataLabelMapper: (_DoughnutData data, _) => data.text,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          textStyle: ChartTextStyle(color: Colors.white),
        ),
      ),
    ];
  }

  void getDataPieChart() {
    PortofolioPenerimaanProvider provider = new PortofolioPenerimaanProvider();
    provider.pieChartLembagaDetailsApi(idLembaga).then((response) {
      if (response.statusCode == 200) {
        var data =
        SebaranAktifitasAmalModel.fromJson(json.decode(response.body));

        valueTotal = data.totalSemua.toDouble();
        valueBackup = data.totalSemua.toDouble();
        valueDonasi = data.totalDonasi.toDouble();
        valueWakaf = data.totalWakaf.toDouble();
        valueShodqoh = data.totalSodaqoh.toDouble();
        valueInfaq = data.totalInfaq.toDouble();
        valueZakat = data.totalZakat.toDouble();
        valueTotalAktivitas = data.totalAktifitas;

        zakatPercent = data.totalZakatPercent;
        infaqPercent = data.totalInfaqPercent;
        shodaqohPercent = data.totalSodaqohPercent;
        wakafPercent = data.totalWakafPercent;
        donasiPercent = data.totalDonasiPercent;
      }
    });
  }

  getAktivitasPenerimaanAmalTerbaruCache() {
    print('Get Aktivitas Penerimaan Terbaru ===>');
    portofolioBloc.bloc.aktivitasPenerimaanAmalTerbaruBehaviour.stream
        .forEach((value) {
      if (mounted) {
        setState(() {
          _listAktivitasPenerimaanAmalTerbaruCache = value;
        });
      }
    });
  }

  Widget buildBarChart(BuildContext context) {
    return StreamBuilder(
      stream: portofolioBloc.bloc.barChartStream,
      builder: (context, AsyncSnapshot<List<BarchartModel>> snapshot) {
        if (snapshot.hasData) {
          return barChartBuild(context, snapshot.data);
        }
        return Center(
          child: Text('loading'),
        );
      },
    );
  }

  Widget barChartBuild(BuildContext context, List<BarchartModel> snapshot) {
    return Container(
      height: 150,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          isVisible: false,
          minimum: 0,
          maximum: valueBackup,
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0),
        ),
        series: <ColumnSeries<SalesData, String>>[
          ColumnSeries(
            dataSource: <SalesData>[
              SalesData('Jan', snapshot[0].total.toDouble()),
              SalesData('Feb', snapshot[1].total.toDouble()),
              SalesData('Mar', snapshot[2].total.toDouble()),
              SalesData('Apr', snapshot[3].total.toDouble()),
              SalesData('Mei', snapshot[4].total.toDouble()),
              SalesData('Jun', snapshot[5].total.toDouble()),
              SalesData('Jul', snapshot[6].total.toDouble()),
              SalesData('Ags', snapshot[7].total.toDouble()),
              SalesData('Sep', snapshot[8].total.toDouble()),
              SalesData('Okt', snapshot[9].total.toDouble()),
              SalesData('Nov', snapshot[10].total.toDouble()),
              SalesData('Des', snapshot[11].total.toDouble()),
            ],
            isTrackVisible: true,
            borderRadius: BorderRadius.circular(5),
            trackColor: Colors.grey[200],
            color: barColor,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
            dataLabelSettings: DataLabelSettings(
              isVisible: false,
              textStyle: ChartTextStyle(color: Colors.white),
            ),
          ),
        ],
        tooltipBehavior: TooltipBehavior(
          enable: true,
          canShowMarker: false,
          header: '',
          format: 'Total bulan point.x : point.y',
        ),
      ),
    );
  }
}

class SalesData {
  final String year;
  final double sales;

  SalesData(this.year, this.sales);
}

class _DoughnutData {
  final String xData;
  final num yData;
  final String text;

  _DoughnutData(this.xData, this.yData, this.text);
}
