import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/pengaturanAplikasiBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/key.dart';
import 'package:flutter_jaring_ummat/src/models/pengaturanAplikasiModel.dart';
import 'package:flutter_jaring_ummat/src/services/pengaturanAplikasiApi.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_atur_aplikasi/atur_aplikasimu_text.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class AturAplikasimuView extends StatefulWidget {
  final bool isActive;
  AturAplikasimuView({this.isActive});

  @override
  _AturAplikasimuViewState createState() =>
      _AturAplikasimuViewState(isActive: this.isActive);
}

class _AturAplikasimuViewState extends State<AturAplikasimuView> {
  bool isActive;
  _AturAplikasimuViewState({this.isActive});

  List<bool> aturTmp = [];
  List<bool> notifTmp = [];
  List<dynamic> valueTmp = [];

  String id;
  String userId;
  int createdDate;
  int modifyDate;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: whiteColor,
        titleSpacing: 0,
        elevation: 1,
        title: const Text(
          'Atur Aplikasi dan Akunmu',
          style: TextStyle(fontSize: SizeUtils.titleSize, color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(AllInOneIcon.back_small_2x),
            onPressed: () {
              Navigator.pop(context);
            },
            color: blackColor,
            iconSize: 20),
      ),
      body: StreamBuilder(
        stream: pengaturanAplikasiBloc.streamPengaturan,
        builder: (BuildContext context,
            AsyncSnapshot<PengaturanAplikasiModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: Text('Waiting...'));
              break;
            default:
              if (snapshot.hasData) {
                return listBuilder(snapshot.data);
              }
              return Center(child: Text('No Data'));
          }
        },
      ),
    );
  }

  Widget listBuilder(PengaturanAplikasiModel snapshot) {
    aturTmp.add(snapshot.aktivitasAmal);
    aturTmp.add(snapshot.komentarGalangAmal);
    notifTmp.add(snapshot.pengingatSholat);
    notifTmp.add(snapshot.ayatAlquranHarian);
    notifTmp.add(snapshot.aksiGalangAmal);
    notifTmp.add(snapshot.beritaAmil);
    notifTmp.add(snapshot.akunAmilBaru);
    notifTmp.add(snapshot.chatDariAmil);
    notifTmp.add(snapshot.portofolio);

    id = snapshot.id;
    userId = snapshot.userId;
    createdDate = snapshot.createdDate;
    modifyDate = snapshot.modifyDate;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const Text('Pengaturan Akun',
                  style: TextStyle(
                      fontSize: SizeUtils.titleSize - 1,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            listPengaturanAkun(snapshot),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const Text('Pengaturan Notifikasi',
                  style: TextStyle(
                      fontSize: SizeUtils.titleSize - 1,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            listPengaturanNotifikasi(snapshot),
          ],
        ),
      ),
    );
  }

  Widget listPengaturanAkun(PengaturanAplikasiModel snapshot) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AturAplikasiMu.pengaturanAkunColorList[index],
              child: Icon(AturAplikasiMu.pengaturanAkunIconList[index],
                  color: whiteColor, size: 20),
            ),
            trailing: aturTmp[index] ? aktiveBtn(index) : inActiveBtn(index),
            title: Text(AturAplikasiMu.pengaturanAkunTitle[index],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            subtitle: Text(AturAplikasiMu.pengaturanAkunSubtitle[index],
                style: TextStyle(fontSize: 13)),
          );
        },
        separatorBuilder: (context, position) {
          return Padding(
            padding: EdgeInsets.only(left: 70.0),
            child: SizedBox(
              height: 10.0,
              child: Center(
                child: Container(
                    margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                    height: 5.0,
                    color: Colors.grey[200]),
              ),
            ),
          );
        },
        itemCount: AturAplikasiMu.pengaturanAkunColorList.length);
  }

  Widget listPengaturanNotifikasi(PengaturanAplikasiModel snapshot) {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  AturAplikasiMu.pengaturanNotifikasiColorList[index],
              child: Icon(AturAplikasiMu.pengaturanNotifikasiIconList[index],
                  color: whiteColor, size: 20),
            ),
            trailing: notifTmp[index]
                ? aktiveNotifikasiBtn(index)
                : inActiveNotifikasiBtn(index),
            title: Text(AturAplikasiMu.pengaturanNotifikasiTitle[index],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            subtitle: Text(AturAplikasiMu.pengaturanNotifikasiSubtitle[index],
                style: TextStyle(fontSize: 13)),
          );
        },
        separatorBuilder: (context, position) {
          return Padding(
            padding: EdgeInsets.only(left: 70.0),
            child: SizedBox(
              height: 10.0,
              child: Center(
                child: Container(
                    margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                    height: 5.0,
                    color: Colors.grey[200]),
              ),
            ),
          );
        },
        itemCount: AturAplikasiMu.pengaturanNotifikasiColorList.length);
  }

  Widget aktiveBtn(int index) {
    return OutlineButton(
      onPressed: () {
        aturTmp[index] = !aturTmp[index];
        valueTmp.add(id);
        valueTmp.add(userId);
        valueTmp.addAll(aturTmp);
        valueTmp.addAll(notifTmp);
        valueTmp.add(createdDate);
        valueTmp.add(modifyDate);

        update(valueTmp);
        setState(() {});
      },
      child: const Text('Aktif',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      borderSide: BorderSide(
        color: Colors.green, //Color of the border
        style: BorderStyle.solid, //Style of the border
        width: 2.8, //width of the border
      ),
    );
  }

  Widget aktiveNotifikasiBtn(int index) {
    return OutlineButton(
      onPressed: () {
        notifTmp[index] = !notifTmp[index];
        valueTmp.add(id);
        valueTmp.add(userId);
        valueTmp.addAll(aturTmp);
        valueTmp.addAll(notifTmp);
        valueTmp.add(createdDate);
        valueTmp.add(modifyDate);

        update(valueTmp);
        setState(() {});
      },
      child: const Text('Aktif',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      borderSide: BorderSide(
        color: Colors.green, //Color of the border
        style: BorderStyle.solid, //Style of the border
        width: 2.8, //width of the border
      ),
    );
  }

  Widget inActiveBtn(int index) {
    return OutlineButton(
      onPressed: () {
        aturTmp[index] = !aturTmp[index];
        valueTmp.add(id);
        valueTmp.add(userId);
        valueTmp.addAll(aturTmp);
        valueTmp.addAll(notifTmp);
        valueTmp.add(createdDate);
        valueTmp.add(modifyDate);

        update(valueTmp);
        setState(() {});
      },
      child: const Text('Tidak Aktif',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      borderSide: BorderSide(
        color: Colors.grey, //Color of the border
        style: BorderStyle.solid, //Style of the border
        width: 2.8, //width of the border
      ),
    );
  }

  Widget inActiveNotifikasiBtn(int index) {
    return OutlineButton(
      onPressed: () {
        notifTmp[index] = !notifTmp[index];
        valueTmp.add(id);
        valueTmp.add(userId);
        valueTmp.addAll(aturTmp);
        valueTmp.addAll(notifTmp);
        valueTmp.add(createdDate);
        valueTmp.add(modifyDate);

        if (index == 0) {
          print('pengingat sholat');
          pengingatSholat();
        }
        update(valueTmp);
        setState(() {});
      },
      child: const Text('Tidak Aktif',
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      borderSide: BorderSide(
        color: Colors.grey, //Color of the border
        style: BorderStyle.solid, //Style of the border
        width: 2.8, //width of the border
      ),
    );
  }

  void pengingatSholat() async {
    var location = new Location();
    var currentLocation = await location.getLocation();

    final coordinate = new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var data = await Geocoder.google(GOOGLE_MAPS_KEY, language: "id").findAddressesFromCoordinates(coordinate);
    print(data.first.subAdminArea);
  }

  void update(List<dynamic> data) {
    var value = PengaturanAplikasiModel(
      id: data[0],
      userId: data[1],
      aktivitasAmal: data[2],
      komentarGalangAmal: data[3],
      pengingatSholat: data[4],
      ayatAlquranHarian: data[5],
      aksiGalangAmal: data[6],
      beritaAmil: data[7],
      akunAmilBaru: data[8],
      chatDariAmil: data[9],
      portofolio: data[10],
      createdDate: data[11],
      modifyDate: data[12],
    );
    PengaturanAplikasiProvider updatePengaturan = new PengaturanAplikasiProvider();
    updatePengaturan.update(value).then((response) {
      print('Response Hasil Update ${response.statusCode}');
      pengaturanAplikasiBloc.fetchPengaturanAplikasi();
    });
  }

  @override
  void initState() {
    pengaturanAplikasiBloc.fetchPengaturanAplikasi();
    super.initState();
  }
}
