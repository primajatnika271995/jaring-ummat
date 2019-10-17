import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_atur_aplikasi/atur_aplikasimu_text.dart';

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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Text('Pengaturan Akun',
                    style: TextStyle(
                        fontSize: SizeUtils.titleSize - 1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              listPengaturanAkun(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: const Text('Pengaturan Notifikasi',
                    style: TextStyle(
                        fontSize: SizeUtils.titleSize - 1,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              listPengaturanNotifikasi(),
            ],
          ),
        ),
      ),
    );
  }

  Widget listPengaturanAkun() {
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
            trailing: AturAplikasiMu.pengaturanAkunBool[index] ? aktiveBtn(index) : inActiveBtn(index),
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

  Widget listPengaturanNotifikasi() {
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
            trailing: AturAplikasiMu.pengaturanNotifikasiBool[index] ? aktiveNotifikasiBtn(index) : inActiveNotifikasiBtn(index),
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
        AturAplikasiMu.pengaturanAkunBool[index] = !AturAplikasiMu.pengaturanAkunBool[index];
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
        AturAplikasiMu.pengaturanNotifikasiBool[index] = !AturAplikasiMu.pengaturanNotifikasiBool[index];
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
        AturAplikasiMu.pengaturanAkunBool[index] = !AturAplikasiMu.pengaturanAkunBool[index];
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
        AturAplikasiMu.pengaturanNotifikasiBool[index] = !AturAplikasiMu.pengaturanNotifikasiBool[index];
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
}
