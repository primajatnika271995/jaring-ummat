import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/key.dart';
import 'package:flutter_jaring_ummat/src/models/DTO/ReturnData.dart';
import 'package:flutter_jaring_ummat/src/models/amilDetailsModel.dart';
import 'package:flutter_jaring_ummat/src/utils/screenSize.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_profile/menu_text_data.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:location/location.dart';

class GMapsUbahAlamat extends StatefulWidget {
  @override
  _GMapsUbahAlamatState createState() => _GMapsUbahAlamatState();
}

class _GMapsUbahAlamatState extends State<GMapsUbahAlamat> {
  /*
   * Google Maps Controller
   */
  Completer<GoogleMapController> _controller = Completer();

  static final LatLng _center = const LatLng(-6.8657152, 107.5929088);

  /*
   * For Get Location with Geolocator and Location Lib
   */
  var location = new Location();
  static double currLatitude = 0;
  static double currLongitude = 0;

  static double searchLatitude;
  static double searchLongitude;

  /*
   * Set Markers
   */
  final Set<Marker> _markers = {};

  /*
   * Alamat Variable
   */
  String alamatPinPoint;
  String kota;
  String provinsi;
  String kabupaten;
  final detailAlamatCtrl = new TextEditingController();

  /*
   * Set Circle
   */
  Set<Circle> _circles = Set.from([
    Circle(
      circleId: CircleId("Circle ID"),
      center: LatLng(currLatitude, currLongitude),
      fillColor: Colors.blue.withOpacity(0.3),
      strokeColor: Colors.blue,
      radius: 40,
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        titleSpacing: 0,
        title: Text(GMapsLocation.appTitle,
            style:
                TextStyle(color: Colors.black, fontSize: SizeUtils.titleSize)),
        leading: IconButton(
          onPressed: () {
            ProfileReturn value = ProfileReturn(
              alamatLembaga: alamatPinPoint,
              kabupatenLembaga: kabupaten,
              kotaLembaga: kota,
              provinsiLembaga: provinsi,
            );

            Navigator.of(context).pop(value);
          },
          icon: Icon(NewIcon.back_small_2x, color: blackColor),
          iconSize: 20,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: stackMaps(),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 10),
              child: SingleChildScrollView(
                child: Container(
                  width: screenWidth(context),
                  // color: Colors.blue,
                  child: informationAlamat(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnSave() {
    return RaisedButton(
      onPressed: () {
        ProfileReturn value = ProfileReturn(
          alamatLembaga: alamatPinPoint,
          kabupatenLembaga: kabupaten,
          kotaLembaga: kota,
          provinsiLembaga: provinsi,
        );

        Navigator.of(context).pop(value);
      },
      child: const Text(
        'Simpan Lokasi',
        style: TextStyle(color: Colors.white),
      ),
      color: greenColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget informationAlamat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          GMapsLocation.alamatPin,
          style: TextStyle(color: Colors.grey),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          child: Text((alamatPinPoint == null) ? '-' : alamatPinPoint,
              style: TextStyle(fontSize: 15)),
        ),
        const Text(
          GMapsLocation.detailsAlamat,
          style: TextStyle(color: Colors.grey),
        ),
        TextFormField(
          maxLength: 200,
          maxLines: 2,
          decoration: InputDecoration(
            hintText:
                'Contoh: Menara Jejaring Lt. 14, Jl. Jejaring Gang 05 RT 1 / RW 9 No. 95',
            hintStyle: TextStyle(fontSize: 15),
          ),
        ),
        btnSave(),
      ],
    );
  }

  Widget stackMaps() {
    return Stack(
      children: <Widget>[
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: (LatLng latLng) {
            print(latLng.longitude);
            print(latLng.latitude);

            if (_markers.length >= 1) {
              _markers.clear();
            }

            _onAddMarkerOnClick(latLng);
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: false,
          markers: _markers,
          circles: _circles,
          initialCameraPosition: CameraPosition(target: _center, zoom: 15),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: FloatingActionButton(
              heroTag: "Searching Location",
              onPressed: () {
                _showAutocompleteAddress();
              },
              child: const Icon(NewIcon.search_small_2x,
                  color: Colors.black, size: 20),
              backgroundColor: whiteColor,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 10),
            child: FloatingActionButton(
              heroTag: "My Location",
              onPressed: _onCurrentLocation,
              child: const Icon(Icons.location_searching,
                  color: Colors.black, size: 20),
              backgroundColor: whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrLocation();
    PluginGooglePlacePicker.initialize(
      androidApiKey: GOOGLE_MAPS_KEY,
    );
  }

  /// Call Function Current Location with Geolocation

  Future<void> _onCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currLatitude, currLongitude),
          zoom: 18,
        ),
      ),
    );
  }

  /// Call Function Search Location

  Future<void> _onSearchLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(searchLatitude, searchLongitude),
          zoom: 18,
        ),
      ),
    );
  }

  /// Set Markers on Click

  void _onAddMarkerOnClick(LatLng latLng) async {
    _markers.add(
      Marker(
        position: LatLng(latLng.latitude, latLng.longitude),
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId("Tap Location"),
      ),
    );
    final coordinate = new Coordinates(latLng.latitude, latLng.longitude);
    var data = await Geocoder.local.findAddressesFromCoordinates(coordinate);
    alamatPinPoint = data.first.addressLine;
    kota = data.first.subAdminArea;
    provinsi = data.first.adminArea;
    kabupaten = data.first.subAdminArea;
    setState(() {});
  }

  /// Call Function Get Latitude & Longitude

  void _getCurrLocation() async {
    var currentLocation = await location.getLocation();
    print(currentLocation.latitude);
    print(currentLocation.longitude);

    final coordinate =
        new Coordinates(currentLocation.latitude, currentLocation.longitude);
    var data = await Geocoder.local.findAddressesFromCoordinates(coordinate);
    print(data.first.addressLine);
    setState(() {
      currLatitude = currentLocation.latitude;
      currLongitude = currentLocation.longitude;
      alamatPinPoint = data.first.addressLine;
      kota = data.first.subAdminArea;
      provinsi = data.first.adminArea;
      kabupaten = data.first.subAdminArea;
    });
  }

  /// Call Google Place Address

  void _showAutocompleteAddress() async {
    var place = await PluginGooglePlacePicker.showAutocomplete(
      mode: PlaceAutocompleteMode.MODE_OVERLAY,
      // typeFilter: TypeFilter.ADDRESS,
    );

    if (!mounted) return;

    if (_markers.length >= 1) _markers.clear();

    searchLatitude = place.latitude;
    searchLongitude = place.longitude;
    _markers.add(
      Marker(
        position: LatLng(place.latitude, place.longitude),
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId("Tap Location"),
      ),
    );

    final coordinate = new Coordinates(searchLatitude, searchLongitude);

    var data = await Geocoder.local.findAddressesFromCoordinates(coordinate);
    alamatPinPoint = place.address;
    kota = place.name;
    provinsi = data.first.adminArea;
    kabupaten = data.first.subAdminArea;
    setState(() {});

    _onSearchLocation();
  }
}
