import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/requestVABloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/views/page_payment/instruksi_pembayaran.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class PembayaranDonasi extends StatefulWidget {
  String toLembagaAmal;
  double nominal;
  String email;
  String phone;
  String lembagaId;
  String type;
  String idProgram;
  String nameProgram;

  PembayaranDonasi(
      {Key key,
      this.toLembagaAmal,
      this.nominal,
      this.email,
      this.phone,
      this.lembagaId,
      this.type,
      this.idProgram,
      this.nameProgram})
      : super(key: key);

  @override
  _PembayaranDonasiState createState() => _PembayaranDonasiState(
      this.toLembagaAmal,
      this.nominal,
      this.email,
      this.phone,
      this.lembagaId,
      this.type,
      this.idProgram,
      this.nameProgram);
}

class _PembayaranDonasiState extends State<PembayaranDonasi> {
  String toLembagaAmal;
  double nominal;
  String email;
  String phone;
  String lembagaId;
  String type;
  String idProgram;
  String nameProgram;

  _PembayaranDonasiState(this.toLembagaAmal, this.nominal, this.email,
      this.phone, this.lembagaId, this.type, this.idProgram, this.nameProgram);

  /*
   * Background Img
   */
  final String bgUrl = 'assets/backgrounds/payment_accent_full_width.png';

  final List<String> vaName = [
    'BNI Syariah VA Billing',
    'Mandiri Syariah VA Billing',
    'Bank Muamalat VA Billing'
  ];

  final List<String> imageVA = [
    'https://2.bp.blogspot.com/-qy7Sanutml0/WmXk88IBzNI/AAAAAAAANyg/2fENOvWf5bUgTD8T7FEAzotvjdmusMZYACLcBGAs/s600/Bank-BNI-Syariah-Logo.jpg',
    'https://www.syariahbank.com/wp-content/uploads/2015/03/profil-dan-produk-Bank-Syariah-Mandiri.jpg',
    'https://cdn2.tstatic.net/makassar/foto/bank/images/logo-bank-muamalat_20180724_102448.jpg'
  ];

  /*
   * Boolen for Loading
   */
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              titleSpacing: 0,
              elevation: 1,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(NewIcon.back_small_2x),
                iconSize: 20,
                color: blackColor,
              ),
              title: const Text('Pembayaran Donasi',
                  style: TextStyle(
                      fontSize: SizeUtils.titleSize, color: Colors.black)),
              backgroundColor: whiteColor,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    // color: Colors.pink,
                    width: screenWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 10),
                          child: const Text('Jumlah Tagihan',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtils.titleSize)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[300], width: 3),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: ListTile(
                              title: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: 'Rp ',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13)),
                                  TextSpan(
                                    text:
                                        '${CurrencyFormat().currency(nominal)}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: SizeUtils.titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                              subtitle: Text('Penerima : $toLembagaAmal',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                child: Icon(
                                  ProfileInboxIcon.donation_3x,
                                  color: whiteColor,
                                  size: 20,
                                ),
                              ),
                              trailing: OutlineButton(
                                onPressed: () {},
                                child: const Text('Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.pink,
                    width: screenWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 15, bottom: 10),
                          child: const Text('Metode Pembayaran',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeUtils.titleSize)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[300], width: 3),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: ListTile(
                                title: const Text('Dompet Jejaring'),
                                subtitle: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'Rp ',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 13)),
                                    TextSpan(
                                      text: '1.700',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: SizeUtils.titleSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(
                                    ProfileInboxIcon.balance_2x,
                                    color: whiteColor,
                                    size: 20,
                                  ),
                                ),
                                trailing: OutlineButton(
                                  onPressed: () {
                                    _modalBottomSheet();
                                  },
                                  child: const Text('Ganti',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: StreamBuilder(
                        stream: bloc.streamRequest,
                        builder: (context, snapshot) {
                          return RaisedButton(
                            onPressed: () {
                              setState(() {
                                _loadingVisible = true;
                              });
                              bloc.requestVA(
                                context,
                                toLembagaAmal,
                                nominal,
                                email,
                                toLembagaAmal,
                                phone,
                                idProgram != null ? idProgram : lembagaId,
                                type,
                              );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) => InstruksiPembayaran(
                              //           nominal: nominal,
                              //           toLembagAmal: toLembagaAmal,
                              //         )));
                            },
                            child: const Text('Selanjutnya',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            color: greenColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              bgUrl,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    print('Payment To Lembaga Amal $toLembagaAmal');
    print(toLembagaAmal);
    setState(() {
      _loadingVisible = false;
    });
    super.initState();
  }

  void _modalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: screenHeight(context, dividedBy: 2.5),
            width: screenWidth(context),
            color: Colors.transparent,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Pilih Metode Pembayaran',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: SizeUtils.titleSize)),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(NewIcon.close_2x),
                    color: greenColor,
                  )
                ],
                backgroundColor: whiteColor,
                elevation: 0,
                automaticallyImplyLeading: false,
              ),
              body: ListView.builder(
                itemCount: imageVA.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    // color: Colors.pink,
                    width: screenWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Container(
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey[300], width: 3),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: ListTile(
                                title: Text('${vaName[index]}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.redAccent,
                                  backgroundImage: NetworkImage(imageVA[index]),
                                ),
                                trailing: OutlineButton(
                                  onPressed: () {},
                                  child: const Text('Ganti',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                )),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
