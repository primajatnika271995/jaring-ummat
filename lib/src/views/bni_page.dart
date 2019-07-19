import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';

class BNIPage extends StatefulWidget {
  @override
  _BNIPageState createState() => _BNIPageState();
}

class _BNIPageState extends State<BNIPage> {
  List imageBg = [
    "http://photo.kontan.co.id/photo/2017/03/10/977537197p.jpg",
    "http://bumn.go.id/data/uploads/content/99/BNI_Remitansi_Singapore_web.jpg",
    "http://infobanknews.com/wp-content/uploads/2017/09/BNI-SYARIAH_HARI-PELANGGAN-2_2017.jpg"
  ];

  List bniAccount = [
    "http://aaji.or.id/file/uploads/company/BNI%20Life.jpg.png",
    "http://aaji.or.id/file/uploads/company/BNI%20Life.jpg.png",
    "http://aaji.or.id/file/uploads/company/BNI%20Life.jpg.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Menu Under Development'),
                ),
              );
            },
            child: new Icon(
              AppBarIcons.ic_leading,
              color: Colors.grey[600],
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: 7.0,
            ),
            InkWell(
              onTap: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Chats Menu Under Development'),
                ));
              },
              child: Icon(Icons.chat, color: Colors.grey[600]),
            ),
            SizedBox(
              width: 7.0,
            ),
            InkWell(
              onTap: () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Add Menu Under Development'),
                  ),
                );
              },
              child: Icon(AppBarIcons.ic_action, color: Colors.grey[600]),
            ),
            SizedBox(
              width: 13.0,
            ),
          ],
          centerTitle: true,
          automaticallyImplyLeading: true,
          titleSpacing: 0.0,
          title: Container(
            child: TextFormField(
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(top: 7.0, bottom: 7.0, left: -15.0),
                icon: Icon(Icons.search, size: 18.0),
                border: InputBorder.none,
                hintText: 'Cari lembaga amal atau produk lainnya',
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              color: Colors.grey[200],
            ),
            padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
          ),
        ),
        preferredSize: Size.fromHeight(47.0),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 210.0,
                child: ListView.builder(
                  itemCount: imageBg.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        print('Tap index ${index}');
                      },
                      child: Container(
                        width: 140.0,
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                                child: Image.network(
                                  imageBg[index],
                                  fit: BoxFit.fitHeight,
                                  height: 140.0,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8.0),
                                child: Image.network(
                                  bniAccount[index],
                                  width: 150.0,
                                  height: 50.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 10.0),
                child: const Text(
                  'Program dan Acara BNI',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: CarouselSlider(
                  height: 298.0,
                  autoPlay: false,
                  reverse: false,
                  viewportFraction: 1.0,
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                  items: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(20.0),
                              child: Image.network(
                                "https://www.bni.co.id/Portals/1/DNNGalleryPro/uploads/2019/7/16/bnionlinebanking.jpg",
                                fit: BoxFit.contain,
                                height: 180.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: const Text(
                              'Bisnis Itu Menjawab panggilan Hati, Bukan Cuma Asal Jual Beli.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: const Text(
                              'Buka rekening BNI Taplus Bisnis dan nikmati manfaat untuk usage Anda seperti informasi total debet dan krdit, rincian transaksi yang tercetak lengkap di buku tabungan.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ClipRRect(
                              borderRadius: new BorderRadius.circular(20.0),
                              child: Image.network(
                                "https://www.bni.co.id/Portals/1/xNews/uploads/2018/2/23/more-website.jpg",
                                fit: BoxFit.contain,
                                height: 180.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: const Text(
                              'Bisnis Itu Menjawab panggilan Hati, Bukan Cuma Asal Jual Beli.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: const Text(
                              'Buka rekening BNI Taplus Bisnis dan nikmati manfaat untuk usage Anda seperti informasi total debet dan krdit, rincian transaksi yang tercetak lengkap di buku tabungan.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: DotsIndicator(
                  dotsCount: 6,
                  position: 0,
                  decorator: DotsDecorator(
                    color: Colors.grey[300],
                    activeColor: Colors.orange,
                    spacing: const EdgeInsets.all(2.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      onPressed: () {
                        print('_kembali ke atas');
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        child: const Text(
                          'Kembali ke Atas',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      print('_atur_beranda');
                    },
                    child: const Text('Atur Beranda'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
