import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
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
    "Dalam Proses",
    "Pembayaran Sukses",
    "Tidak Dibayarkan"
  ];

  static const List<String> listPenerimaanAmal = [
    "Dalam Proses",
    "Pembayaran Sukses"
  ];

  static const List colorListPenerimaanAmal = [
    Colors.yellowAccent,
    Colors.deepPurpleAccent
  ];

  static const List iconListPenerimaanAmal = [
    AllInOneIcon.on_process_3x,
    AllInOneIcon.payment_done_3x
  ];

  /*
   *  Data Color For Transaksi
   */
  static const List listColorTransaksi = [
    Colors.yellow,
    Colors.purple,
    Colors.redAccent,
  ];

  /*
   *  Data Icon List Tile For Transaksi
   */
  static const List listIconTransaksi= [
    AllInOneIcon.on_process_3x,
    AllInOneIcon.payment_done_3x,
    AllInOneIcon.donation_cancel_3x,
  ];
}
