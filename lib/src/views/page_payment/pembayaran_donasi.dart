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
  String customerName;

  PembayaranDonasi(
      {Key key,
        this.toLembagaAmal,
        this.nominal,
        this.email,
        this.phone,
        this.lembagaId,
        this.type,
        this.idProgram,
        this.nameProgram,
        this.customerName})
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
      this.nameProgram,
      this.customerName);
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
  String customerName;

  _PembayaranDonasiState(
      this.toLembagaAmal,
      this.nominal,
      this.email,
      this.phone,
      this.lembagaId,
      this.type,
      this.idProgram,
      this.nameProgram,
      this.customerName);

  /*
   * Background Img
   */
  final String bgUrl = 'assets/backgrounds/payment_accent_full_width.png';

  /*
   * Virtual Name List
   */
  final List<String> vaName = [
    'Dompet Jejaring',
    'BNI Syariah VA Billing',
    'Mandiri Syariah VA Billing',
    'Bank Muamalat VA Billing'
  ];

  /*
   * Virtual Account Image
   */
  final List<String> imageVA = [
    'https://2.bp.blogspot.com/-qy7Sanutml0/WmXk88IBzNI/AAAAAAAANyg/2fENOvWf5bUgTD8T7FEAzotvjdmusMZYACLcBGAs/s600/Bank-BNI-Syariah-Logo.jpg',
    'https://2.bp.blogspot.com/-qy7Sanutml0/WmXk88IBzNI/AAAAAAAANyg/2fENOvWf5bUgTD8T7FEAzotvjdmusMZYACLcBGAs/s600/Bank-BNI-Syariah-Logo.jpg',
    'https://www.syariahbank.com/wp-content/uploads/2015/03/profil-dan-produk-Bank-Syariah-Mandiri.jpg',
    'https://cdn2.tstatic.net/makassar/foto/bank/images/logo-bank-muamalat_20180724_102448.jpg'
  ];

  /*
   * Boolen for Loading
   */
  bool _loadingVisible = false;

  /*
   * Metode Pembayaran Temp
   */
  String titleMetode = 'Dompet Jejaring';
  String subtitleMetode = '1.700';
  int indexTile = 0;

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
                          child: const Text(
                            'Jumlah Tagihan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
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
                                        '${CurrencyFormat().data.format(nominal)}',
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
                          child: const Text(
                            'Metode Pembayaran',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
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
                              title: Text(
                                '$titleMetode',
                                style: TextStyle(fontSize: 11),
                              ),
                              subtitle: subtitleMetode == null
                                  ? null
                                  : RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: 'Rp ',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13)),
                                  TextSpan(
                                    text: '$subtitleMetode',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: SizeUtils.titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                              ),
                              leading: CircleAvatar(
                                  backgroundColor: Colors.redAccent,
                                  backgroundImage: indexTile == 0
                                      ? null
                                      : NetworkImage(imageVA[indexTile]),
                                  child: indexTile == 0
                                      ? Icon(
                                    ProfileInboxIcon.balance_2x,
                                    color: whiteColor,
                                    size: 20,
                                  )
                                      : null),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(Icons.info_outline,
                                      size: 25, color: blackColor),
                                  SizedBox(width: 10),
                                  OutlineButton(
                                    onPressed: () {
                                      _modalBottomSheet();
                                    },
                                    child: const Text('Ganti',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                  ),
                                ],
                              ),
                            ),
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
                                customerName,
                                phone,
                                idProgram != null ? idProgram : lembagaId,
                                lembagaId,
                                type,
                              );
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
          height: screenHeight(context, dividedBy: 2),
          width: screenWidth(context),
          color: Colors.transparent,
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              title: const Text(
                'Pilih Metode Pembayaran',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: CircleAvatar(
                      backgroundColor: greenColor,
                      radius: 12.0,
                      child:
                      Icon(NewIcon.close_2x, size: 12, color: whiteColor)),
                )
              ],
              backgroundColor: whiteColor,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: ListView.builder(
              itemCount: vaName.length,
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
                            horizontal: 20, vertical: 7),
                        child: Container(
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: indexTile == index
                                    ? greenColor
                                    : Colors.grey[300],
                                width: 3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              '${vaName[index]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                            subtitle: index == 0
                                ? RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: 'Rp ',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13)),
                                TextSpan(
                                  text: '1.700',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: SizeUtils.titleSize,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            )
                                : null,
                            leading: CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                backgroundImage: index == 0
                                    ? null : NetworkImage(imageVA[index]),
                                child: index == 0
                                    ? Icon(
                                  ProfileInboxIcon.balance_2x,
                                  color: whiteColor,
                                  size: 20,
                                )
                                    : null),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.info_outline,
                                    size: 20, color: blackColor),
                                SizedBox(width: 10),
                                OutlineButton(
                                  onPressed: () {
                                    switch (index) {
                                      case 0:
                                        setState(() {
                                          titleMetode = 'Dompet Jejaring';
                                          subtitleMetode = '1.700';
                                          indexTile = 0;
                                        });
                                        break;
                                      case 1:
                                        setState(() {
                                          titleMetode =
                                          'BNI Syariah VA Billing';
                                          subtitleMetode = null;
                                          indexTile = 1;
                                        });
                                        break;
                                      case 2:
                                        setState(() {
                                          titleMetode =
                                          'Mandiri Syariah VA Billing';
                                          subtitleMetode = null;
                                          indexTile = 2;
                                        });
                                        break;
                                      case 3:
                                        setState(() {
                                          titleMetode =
                                          'Bank Muamalat VA Billing';
                                          subtitleMetode = null;
                                          indexTile = 3;
                                        });
                                        break;
                                      default:
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(getButtonTitle(index),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: indexTile != null &&
                                            indexTile == index
                                            ? greenColor
                                            : Colors.deepPurple,
                                      )),
                                  borderSide: BorderSide(
                                    color:
                                    indexTile != null && indexTile == index
                                        ? greenColor
                                        : Colors.grey[300],
                                    style: BorderStyle.solid,
                                    //Style of the border
                                    width: 3.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  String getButtonTitle(int index) {
    return indexTile != null && indexTile == index ? 'Dipilih' : 'Pilih';
  }
}
