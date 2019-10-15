
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/atur_akun_icon_icons.dart';

class AturAplikasiMu {
  static const String titlePengaturanAkun = "Pengaturan Akun";

  static const List<IconData> pengaturanAkunIconList = [
    AllInOneIcon.donation_3x,
    AllInOneIcon.comment_3x,
  ];

  static List<Color> pengaturanAkunColorList = [
    Colors.yellow[600],
    Colors.red,
  ];

  static const List<dynamic> pengaturanAkunTitle = [
    'Aktivitas Amal',
    'Komentar Galang Amal',
  ];

  static const List<dynamic> pengaturanAkunSubtitle = [
    'Sembunyikan identitas saat melakukan aktivitas amal.',
    'Sembunyikan identitas saat mengomentari aksi galang amal.',
  ];

  static const String titlePengaturanNotifikasi = "Pengaturan Notifikasi";

  static const List<IconData> pengaturanNotifikasiIconList = [
    AturAkunIcon.shalat_3x,
    AturAkunIcon.alquran_3x,
    AllInOneIcon.create_galang_amal_3x,
    AllInOneIcon.news_3x,
    AllInOneIcon.edittext_name_3x,
    AllInOneIcon.chat_3x,
    AllInOneIcon.nav_portfolio_3x
  ];

  static List<Color> pengaturanNotifikasiColorList = [
    Colors.purpleAccent,
    Colors.lightGreenAccent,
    Colors.blueAccent,
    Colors.yellow[600],
    Colors.red,
    Colors.deepPurple,
    Colors.green,
  ];

  static const List<dynamic> pengaturanNotifikasiTitle = [
    'Pengingat Sholat',
    'Ayat Al-Qur\'an harian',
    'Aksi Galang Amal',
    'Berita Amil',
    'Akun Amil Baru',
    'Chat dari Amil',
    'Portofolio',
  ];

  static const List<dynamic> pengaturanNotifikasiSubtitle = [
    'Notifikasi ketika masuk waktu sholat agar kamu tidak pernah lupa untuk beribadah.',
    'Notifikasi ketika terdapat rekomendasi ayat Al-Quran untuk dibaca.',
    'Notifikasi ketika following amil membuat galang amal baru.',
    'Notifikasi ketika amil membuat berita baru.',
    'Notifikasi ketika terdapat akun amil baru yang populer.',
    'Notifikasi ketika amil mengirimkan atau membalas chat.',
    'Notifikasi ketika terdapat portofolio baru pada setiap awal bulan.',
  ];
}