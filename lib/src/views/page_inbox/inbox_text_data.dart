import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';

class InboxTextData {

  /*
   *  Data Icon List Tile
   */
  static const List listIcon = [
    ProfileInboxIcon.zakat_3x,
    ProfileInboxIcon.infaq_3x,
    ProfileInboxIcon.saved_galang_amal_3x,
    ProfileInboxIcon.donation_3x
  ];


  /*
   * Data Title List Tile 
   */
  static const List<String> listTitle = [
    "Pembayaran zakatmu di Inisiatif Zakat Indonesia sukses! Terimakasih telah menyisihkan sebagian hartamu untuk membantu sesama.",
    "Pembayaran infaqmu di Dewan Da\'wah Islamiyah Indonesia sukses! Terimakasih telah menyisihkan sebagian hartamu untuk membantu sesama.",
    "Galang amal yang sudah kamu simpan sebentar lagi berakhir lho. Yuk lanjutkan niat baikmu untuk berpartisipasi pada aksi tersebut.",
    "Pembayaran donasimu di Rumah Amal Salman sukses! Terimakasih telah menyisihkan sebagian hartamu untuk membantu sesama."
  ];

  /*
   * Data Subtitle List Tile
   */
  static const List<String> listSubtitle = [
    "11 menit yang lalu",
    "3 jam yang lalu",
    "4 jam yang lalu",
    "3 jam yang lalu"
  ];

  /*
   * Data List Color
   */

  static const List listColor = [
    Colors.yellow,
    Colors.red,
    Colors.yellow,
    Colors.blue
  ];

  static const List<String> listTransaksi = [
    "Menunggu Pembayaran",
    "Selesai Dibayar",
  ];


}