import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/loginBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/calculator_other_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/sosial_media_icons.dart';

class DetailsLembaga extends StatefulWidget {
  final LembagaAmalModel value;
  DetailsLembaga({this.value});

  @override
  _DetailsLembagaState createState() => _DetailsLembagaState(value: this.value);
}

class _DetailsLembagaState extends State<DetailsLembaga> {
  LembagaAmalModel value;
  _DetailsLembagaState({this.value});

  int _tabLength = 4;

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
          Center(
            child: const Text('Next Week'),
          ),
          Center(
            child: const Text('Next Week'),
          ),
          Center(
            child: const Text('Next Week'),
          ),
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
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
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
