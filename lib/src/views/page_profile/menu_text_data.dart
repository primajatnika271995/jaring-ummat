import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';

class MenuTextData {
  /*
   * List Data for Title Menu
   */
  static const  List<String> titleMenu = [
    "Galang Amal Tersimpan",
    "Hitung Kewajiban Zakatmu",
    "Atur Aplikasi dan Akunmu"
  ];

  /*
   * List Data for Subtitle Menu
   */
  static const List<String> subtitleMenu = [
    "Beberapa aksi galang amal sudah tersimpan disini. Yuk lanjutkan niat baikmu untuk berpartisipasi dalam aksi tersebut!",
    "Berapa penghasilan kamu bulan ini? Sudah tahu belum berapa kewajiban zakatmu? Jika belum, kamu bisa hitung disini lho!",
    "Kamu ingin menyamarkan akunmu saat berpartisipasi dalam galang amal? Bisa kok diatur disini. Kumu juga bisa mengatur notifikasi agar selalu update dengan aksi terbaru."
  ];
  

  static const List iconMenu = [
    ProfileInboxIcon.saved_galang_amal_3x,
    ProfileInboxIcon.zakat_calculator_3x,
    ProfileInboxIcon.setting_app_3x,
    ProfileInboxIcon.faq_3x,
    ProfileInboxIcon.administration_3x
  ];

  static const List colorMenu = [
    Colors.yellow,
    Colors.blue,
    Colors.red,
    Colors.lightGreen,
    Colors.purpleAccent
  ];
}
