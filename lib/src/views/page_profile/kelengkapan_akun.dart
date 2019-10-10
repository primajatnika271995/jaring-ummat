import 'dart:convert';
import 'dart:io';
import 'package:flutter_jaring_ummat/src/models/DTO/ReturnData.dart';
import 'package:flutter_jaring_ummat/src/models/muzakkiUserDetails.dart';
import 'package:flutter_jaring_ummat/src/views/page_profile/place_details.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/amilDetailsModel.dart';
import 'package:flutter_jaring_ummat/src/services/loginApi.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/calculator_other_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_jaring_ummat/src/bloc/registerBloc.dart';

class KelengkapanAkunPage extends StatefulWidget {
  @override
  _KelengkapanAkunPageState createState() => _KelengkapanAkunPageState();
}

class _KelengkapanAkunPageState extends State<KelengkapanAkunPage> {
  /*
   * File Image Selected
   */
  static File selectedImage;

  /* ReadOnly For Text Field
   *
   */
  bool _fullnameReadOnly = true;
  bool _contactReadOnly = true;
  bool _emailReadOnly = true;
  bool _cityReadOnly = true;
  bool _streetReadOnly = true;
  bool _dateReadOnly = true;

  /*
   *  Text Edit Controller
   */
  final _fullnameCtrl = new TextEditingController();
  final _contactCtrl = new TextEditingController();
  final _emailCtrl = new TextEditingController();
  final _cityCtrl = new TextEditingController();
  final _kabupatenLahirCtrl = new TextEditingController();
  final _provinsiLahirCtrl = new TextEditingController();
  final _streetCtrl = new TextEditingController();
  final _provinsiCtrl = new TextEditingController();
  final _kabupatenCtrl = new TextEditingController();
  final _dateCtrl = new TextEditingController();

  /*
   *  Boolean Loading
   */
  bool _loading = false;
  
  String kotaLembaga;

  /* 
   * Date Formatter
   */
  DateTime date = new DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String dateSelected;

  /*
   * For Get Location with Geolocator and Location Lib
   */
  var location = new Location();
  String latitude;
  String longitude;
  Map<String, double> userLocation;

  static String imgProfileKey;

  @override
  Widget build(BuildContext context) {
    // Profile Widget

    final profileIcon = Padding(
      padding: EdgeInsets.only(top: 30),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.transparent,
                backgroundImage: (imgProfileKey == null)
                    ? AssetImage('assets/icon/default_picture_man.png')
                    : NetworkImage(imgProfileKey),
              ),
            ),
            InkWell(
              onTap: _asyncImageSourceDialog,
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(color: greenColor, shape: BoxShape.circle),
                child: Icon(
                  NewIcon.upload_2x,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // Text Field Name

    final fullnameWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: _fullnameReadOnly,
            controller: _fullnameCtrl,
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.yellow[300],
                child: Icon(CalculatorOtherIcon.edittext_people_3x,
                    color: whiteColor, size: 20),
              ),
            ),
          ),
          Container(
            child: OutlineButton(
              onPressed: () {
                setState(() {
                  _fullnameReadOnly = !_fullnameReadOnly;
                });
              },
              child: const Text('Ubah',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );

    // Contact Field

    final contactWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: _contactReadOnly,
            controller: _contactCtrl,
            decoration: InputDecoration(
              labelText: 'Nomor Telepon',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(NewIcon.edittext_phone_3x,
                    color: whiteColor, size: 20),
              ),
            ),
          ),
          Container(
            child: OutlineButton(
              onPressed: () {
                setState(() {
                  _contactReadOnly = !_contactReadOnly;
                });
              },
              child: const Text('Ubah',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );

    // Email Field

    final emailWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: _emailReadOnly,
            controller: _emailCtrl,
            decoration: InputDecoration(
              labelText: 'Email',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child:
                    Icon(NewIcon.edittext_name_3x, color: whiteColor, size: 20),
              ),
            ),
          ),
          Container(
            child: OutlineButton(
              onPressed: () {
                setState(() {
                  // _emailReadOnly = !_emailReadOnly;
                });
              },
              child: const Text('Ubah',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );

    // City Field

    final cityWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: _cityReadOnly,
            controller: _cityCtrl,
            decoration: InputDecoration(
              labelText: 'Tempat Lahir',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Icon(Icons.place, color: whiteColor, size: 20),
              ),
            ),
          ),
          Container(
            child: OutlineButton(
              onPressed: () {
                setState(() {
                  _cityReadOnly = !_cityReadOnly;
                });
                _showAutocompleteCity();
              },
              child: const Text('Ubah',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );

    // Date Field

    final dateWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: _dateReadOnly,
            controller: _dateCtrl,
            decoration: InputDecoration(
              labelText: 'Tanggal Lahir',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Icon(CalculatorOtherIcon.edittext_birtdate_3x,
                    color: whiteColor, size: 20),
              ),
            ),
          ),
          Container(
            child: OutlineButton(
              onPressed: _selectDate,
              child: const Text('Ubah',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
            ),
          )
        ],
      ),
    );

    // Street Field

    final streetWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            maxLines: 2,
            maxLengthEnforced: true,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            controller: _streetCtrl,
            decoration: InputDecoration(
              labelText: 'Alamat',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(CalculatorOtherIcon.location_inactive_3x,
                    color: whiteColor, size: 20),
              ),
            ),
          ),
          _streetCtrl.text.length <= 10
              ? Container(
                  child: OutlineButton(
                    onPressed: () {
                      setState(() {
                        _streetReadOnly = !_streetReadOnly;
                      });
                      // _showAutocompleteAddress();
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => GMapsUbahAlamat(),
                        ),
                      )
                          .then((value) {
                        navigateGoogleMaps(context, value);
                      });
                    },
                    child: const Text('Ubah',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                )
              : Container(),
        ],
      ),
    );

    // Kabupaten Field

    final kabupatenWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: true,
            controller: _kabupatenCtrl,
            decoration: InputDecoration(
              labelText: 'Kabupaten',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Icon(
                  CalculatorOtherIcon.location_inactive_3x,
                  color: whiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // Kabupaten Field

    final provinsiWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: const Alignment(1, 0),
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            ),
            readOnly: true,
            controller: _provinsiCtrl,
            decoration: InputDecoration(
              labelText: 'Provinsi',
              hasFloatingPlaceholder: true,
              icon: CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(
                  CalculatorOtherIcon.location_inactive_3x,
                  color: whiteColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // Facebook Sosial Media

    final facebookField = ListTile(
      title: const Text('Facebook',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      subtitle: const Text('Belum ada akun yang terhubung!',
          style: TextStyle(color: Colors.redAccent, fontSize: 10)),
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(FontAwesomeIcons.facebookF, color: whiteColor, size: 20),
      ),
      trailing: OutlineButton(
        onPressed: () {},
        child: const Text('Terhubung',
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );

    // Google Sosial Media

    final googleField = ListTile(
      title: const Text('Google',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      subtitle: const Text('Belum ada akun yang terhubung!',
          style: TextStyle(color: Colors.redAccent, fontSize: 10)),
      leading: CircleAvatar(
        backgroundColor: Colors.redAccent,
        child: Icon(FontAwesomeIcons.google, color: whiteColor, size: 20),
      ),
      trailing: OutlineButton(
        onPressed: () {},
        child: const Text('Terhubung',
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );

    // Twitter Sosial Media

    final twitterField = ListTile(
      title: const Text('Twitter',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
      subtitle: const Text('Belum ada akun yang terhubung!',
          style: TextStyle(color: Colors.redAccent, fontSize: 10)),
      leading: CircleAvatar(
        backgroundColor: Colors.lightBlue,
        child: Icon(FontAwesomeIcons.twitter, color: whiteColor, size: 20),
      ),
      trailing: OutlineButton(
        onPressed: () {},
        child: const Text('Terhubung',
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );

    final saveData = Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _loading = true;
          });

          final data = MuzakkiUserDetails(
            fullname: _fullnameCtrl.text,
            contact: _contactCtrl.text,
            kotaLahir: _cityCtrl.text,
            tanggalLahir: _dateCtrl.text,
            alamat: _streetCtrl.text,
            latitudeTinggal: latitude,
            longitudeTinggal: longitude,
            email: _emailCtrl.text,
            kabupaten: _kabupatenCtrl.text,
            provinsi: _provinsiCtrl.text,
            kotaTinggal: _kabupatenCtrl.text,
            kabupatenLahir: _kabupatenLahirCtrl.text,
            provinsiLahir: _provinsiLahirCtrl.text
          );
          print("KOTA PROVINSI LAHIR");
          print(data.kabupatenLahir);
          print(data.provinsiLahir);

          bloc.updateUser(context, data);
        },
        child: const Text('Simpan Perubahan',
            style: TextStyle(color: Colors.white)),
        color: greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    return LoadingScreen(
      inAsyncCall: _loading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          titleSpacing: 0,
          elevation: 1,
          title: const Text('Kelengkapan akun',
              style: TextStyle(
                  fontSize: SizeUtils.titleSize, color: Colors.black)),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(NewIcon.back_small_2x),
            iconSize: 20,
            color: blackColor,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            // color: Colors.pink,
            width: screenWidth(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // color: Colors.blueAccent,
                  width: screenWidth(context),
                  child: Column(
                    children: <Widget>[
                      profileIcon,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: const Text('Akun Terverifikasi • 98 Following',
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: const Text('Data Pribadi',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16)),
                ),
                Container(
                  width: screenWidth(context),
                  child: fullnameWidget,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: contactWidget,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: emailWidget,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: cityWidget,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: dateWidget,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: streetWidget,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: kabupatenWidget,
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: provinsiWidget,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: const Text('Akun Sosial Media',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16)),
                ),
                Container(
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: facebookField,
                ),
                Container(
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: googleField,
                ),
                Container(
                  // color: Colors.redAccent,
                  width: screenWidth(context),
                  child: twitterField,
                ),
                Container(
                  // color: Colors.redAccent,
                  child: saveData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      _loading = false;
    });
    getUserDetails();
    // _getLocation();

    PluginGooglePlacePicker.initialize(
        androidApiKey: "AIzaSyCu1HQ1DdlfT7Sdw2kro-MJovvH6wW8DJg");
    super.initState();
  }

  /// Call Fuction Date Picker
  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: new DateTime(1945),
        lastDate: new DateTime(2100));

    if (picked != null && picked != date) {
      setState(() {
        var dateFormat = new DateFormat('yyyy-MM-dd').format(picked);
        _dateCtrl.text = dateFormat;
      });
    }
  }

  Future<ImageSource> _asyncImageSourceDialog() {
    return showDialog<ImageSource>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text('Pilih Sumber Foto '),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: getFromGallery,
              child: const Text('Gallery', style: TextStyle(fontSize: 18)),
            ),
            SimpleDialogOption(
              onPressed: getFromCamera,
              child: const Text('Camera', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  /// Call function to Get Image From Gallery

  void getFromGallery() async {
    Navigator.of(context).pop(ImageSource.gallery);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('Select Galery!');
    setState(() {
      selectedImage = image;
    });
  }

  /// Call function to Get Image From Camera

  void getFromCamera() async {
    Navigator.of(context).pop(ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print('Select Camera');
    setState(() {
      selectedImage = image;
    });
  }

  /// Call Function Get User Details

  void getUserDetails() async {
    LoginApiProvider apiProvider = new LoginApiProvider();
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var email = _pref.getString(EMAIL_KEY);

    setState(() {
      _loading = true;
    });

    apiProvider.getUserDetails(email).then((response) {
      print('Ambil Data : ${response.statusCode}');
      if (response.statusCode == 200) {
        MuzakkiUserDetails value = muzakkiUserDetailsFromJson(response.body);
        _emailCtrl.text = value.email;
        _contactCtrl.text = value.contact;
        _fullnameCtrl.text = value.fullname;
        _dateCtrl.text = value.tanggalLahir;
        _cityCtrl.text = value.kotaLahir;
        _streetCtrl.text = value.alamat;
        _provinsiCtrl.text = value.provinsi;
        _kabupatenCtrl.text = value.kabupaten;
        imgProfileKey = value.imageUrl;
        _kabupatenLahirCtrl.text = value.kabupatenLahir;
        _provinsiLahirCtrl.text = value.provinsiLahir;
        setState(() {
          _loading = false;
        });
      }
    });
  }

  /// Call Google Place City

  void _showAutocompleteCity() async {
    var place = await PluginGooglePlacePicker.showAutocomplete(
        mode: PlaceAutocompleteMode.MODE_OVERLAY,
        typeFilter: TypeFilter.REGIONS);
    final coordinate = new Coordinates(place.latitude, place.longitude);
    var data = await Geocoder.local.findAddressesFromCoordinates(coordinate);

    if (!mounted) return;

    setState(() {
      _cityCtrl.text = data.first.subAdminArea;
      _kabupatenLahirCtrl.text = data.first.subAdminArea;
      _provinsiLahirCtrl.text = data.first.adminArea;
    });
  }

  void navigateGoogleMaps(BuildContext context, ProfileReturn value) async {
    kotaLembaga = value.kotaLembaga;
    _streetCtrl.text = value.alamatLembaga;
    _provinsiCtrl.text = value.provinsiLembaga;
    _kabupatenCtrl.text = value.kabupatenLembaga;
  }
}
