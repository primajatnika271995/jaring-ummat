import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/all_in_one_icon_icons.dart';

class LoginText {
  static const namaAplikasi = "Jejaring";
  static const logoUrl = "assets/icon/logo_muzakki_jejaring.png";
  static const backgroundUrl = "assets/backgrounds/accent_app_width_full_screen.png";

  static const loginBtn = "Masuk";
  static const registerBtn = "Daftar";
  static const socialMedia = "atau login dengan akun sosial media";

  // Text Field
  static const emailHint = "Alamat Email";
  static const passwordHint = "Password";

}

class ExplorerText {
  static const titleBar = "Jelajah Kebaikan";

  static const List<String> category = [
    "Populer",
    "Aktivitas Amal",
    "Akun Amil",
    "Tanya Ustad",
    "Berita"
  ];

  static const bantuKami = "Bantu Kami Segera";
  static const bantuKamiUrl = "https://img.kitabisa.cc/size/664x357/8e86f327-d4a2-4813-a2f1-228ebd35c953.jpg";
  static const bantuKamiDesc = "Bantu kami membangun rumah PANTI YPAB";

  static const bantuKamiUrl1 = "https://kitabisa-userupload-01.s3-ap-southeast-1.amazonaws.com/_production/project-desc/69684/e1e5e2163cd37e8161fa6888fd5a6fa209139019.jpeg";
  static const bantuKamiDesc1 = "Bantu operasi Resi yang memerlukan baiaya untuk operasi penyakit.";

  static const bantuKamiUrl2 = "https://img.kitabisa.cc/size/664x357/e1381a6c-2518-42f3-8ca8-190511856941.jpg";
  static const bantuKamiDesc2 = "Bantu terdampak kebakaran hutan dan Kabut Asam di Sumatera";

  static const kebaikanDisekitarmu = "Kebaikan Disekitarmu";
  static const kebaikanDisekitarUrl = "https://cdn.idntimes.com/content-images/community/2019/04/disaster-af188317ff4ce57ac4e9c540d4f6f19d_600x400.jpg";
  static const kebaikanDisekitarDesc = "Dikepung Kabut Asap, ACT Bantu Padamkan Api di Bengkalis";

  static const List<IconData> jenisKebaikan = [
    AllInOneIcon.donation_3x,
    AllInOneIcon.zakat_3x,
  ];
}

class infoJaring {
  int id;
  String title, description, imageUrl, createdBy, createdDate;

  infoJaring({this.id, this.title, this.description, this.imageUrl, this.createdBy, this.createdDate});
}


List<infoJaring> listInfoJaring = [
  new infoJaring(
      id: 1,
      title: "Bantu kami membangun rumah PANTI YPAB",
      description: "Assallamualikum warohmatullahi wabarokatu...saudara saudara kami diseluruh nusantara KAMI Yayasann Bakti Sosial Peduli Anak Bangsa(YPAB),adalah yayasan yatim piatu yg bergerak dalam kegiatan sosial menampung anak yatim piatu serta dhuapa yg tidak mampu yg berdiri sejak 24 April 2004 yg bertempat di jl kalimaya blok D1 no 16 rt.007/021 perumahan kutabumi II pasar kemis tangerang Banten.\nSemenjak berdirinya panti sampai sekarang.panti ini belum mempunyai tempat/rumah panti dan adapun rumah yg kami tempati sekarang adalah rumah pinjaman dari seorang donatur\nDan panti ini diurus serta dikelolo oleh ibu Nur effa /ami yg sudah berusia 59 tahun dan wajar kira nya kita mengerakan tenaga untuk membantu agar terrealisasi keinginan beliau agar mempunyai rumah panti sendiri berhubung anak anak panti yanga ada didalam panti sekarang berjumlah 42 orang sementara rumah pinjaman yg kami tempati sekarang sudah tidak mampu menampung anak anak lagi sehinga menumpuk tidur tidak beraturan dimana mana,andai kata kita memiliki rumah panti maka kesejatraan serta kedamaian anak anak panti lebih teratur sejatrah dan damai\nanak anak panti dan dhuapa yg kami tampung disini semua biaya kebutuhan sehari hari,makan,sekolah dll semua panti yang menangung dan yg memenuhi dibantu oleh para donatur \nbesar harapan kami kepada para donatur sudih kiranya membantu kami untuk MEMBANGUN RUMAH PANTI DARI NOL MULAI DARI TANAH SERTA MATRIAL BANGUNAN Karena hal ini sangat lah kami butuhkan saat ini demi anak anak kami kedepannya.\nAtas segala bantuan para donatur kami ucapkan terima kasih dan teriring doa dari kami semoga semua donatur yg berdonasi serta semua pihak yg telah membantu segala usaha ini kami doakan semoga Allah SWT melimpahkan segala kesajtrah baik dunia dan aherat selamat dunia dan aherat,mulya dunia dan aherat dan kelak kita semuanya dikumpulkan oleh Allah dalam surgaNya tanpa hisab aamiin\nJazakumullah syukron katsiron\nWassallamualikum warohmatullahibwabarokatu\nYayasan Bakti Sosial Peduli Anak Bangsa (segenap pengurus)",
      imageUrl: "https://img.kitabisa.cc/size/664x357/8e86f327-d4a2-4813-a2f1-228ebd35c953.jpg",
      createdBy: "Info Jaring",
      createdDate: "10 Oktober 2019"
  ),
  new infoJaring(
      id: 2,
      title: "Bantu terdampak kebakaran hutan dan Kabut Asam di Sumatera",
      description: "Bantu terdampak kebakaran hutan dan Kabut Asam di Sumatera. Bantuan kalian sangat ditunggu dan dinanti saudara-saudara di Sumatera.",
      imageUrl: "https://img.kitabisa.cc/size/664x357/e1381a6c-2518-42f3-8ca8-190511856941.jpg",
      createdBy: "Info Jaring",
      createdDate: "10 Oktober 2019"
  ),
];