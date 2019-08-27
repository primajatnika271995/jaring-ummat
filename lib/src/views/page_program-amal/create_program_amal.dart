import 'dart:io';

import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';

class CreateProgramAmal extends StatefulWidget {
  @override
  _CreateProgramAmalState createState() => _CreateProgramAmalState();
}

class _CreateProgramAmalState extends State<CreateProgramAmal> {
  List<String> category = [
    'Pendidikan',
    'Kemanusiaan',
    'Amal',
    'Pembangunan Mesjid',
    'Zakat',
    'Sosial',
    'lain-lain'
  ];

  TextEditingController _editingControllerTitle = new TextEditingController();

  TextEditingController _editingControllerDescription =
      new TextEditingController();

  TextEditingController _editingControllerDonation =
      new TextEditingController();

  TextEditingController _editingControllerTimes = new TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  DateTime date = new DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String dateSelected;
  String categorySelected;

  bool _loadingVisible = false;

  File imgSelected;

  Widget gridImage() {
    return GridView.builder(
      itemCount: 4,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 7.0),
          child: Stack(
            children: <Widget>[
              Container(
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: grayColor,
                    width: 3.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.all(
                    new Radius.circular(10.0),
                  ),
                ),
                child: new Center(
                  child: IconButton(
                    icon:
                        Icon(Icons.photo_filter, size: 30.0, color: grayColor),
                    onPressed: () {
                      _asyncImageSourceDialog();
                    },
                  ),
                ),
              ),
              Positioned(
                left: 5.0,
                top: 5.0,
                child: CircleAvatar(
                  backgroundColor: greenColor,
                  radius: 10.0,
                  child: Text(
                    index.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textInfo = Text(
      'Galang amal minimal 1 Gambar atau Video yang diunggah. Video maksimal berdurasi 1 menit 30 detik',
      textAlign: TextAlign.justify,
      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
    );

    final submitButton = RaisedButton(
      textColor: Colors.white,
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 2.0),
        child: Text('Create', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      onPressed: () => save(),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
        title: new Text(
          'Buat Aksi Amal',
          style: TextStyle(fontSize: 14.0, color: Colors.grey[800]),
        ),
        centerTitle: false,
        elevation: 1.0,
      ),
      body: LoadingScreen(
        inAsyncCall: _loadingVisible,
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Form(
              key: _keyForm,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            controller: _editingControllerTitle,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0)),
                              ),
                              hintText: 'Nama Galang Amal *',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Judul tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: 40.0,
                            padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.grey[300],
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                child: DropdownButton(
                                  elevation: 4,
                                  isDense: true,
                                  iconSize: 15.0,
                                  isExpanded: true,
                                  hint: Text(
                                    'Pilih Kategori *',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black54),
                                  ),
                                  value: categorySelected,
                                  onChanged: (newValue) {
                                    setState(() {
                                      categorySelected = newValue;
                                    });
                                  },
                                  items: category.map((location) {
                                    return DropdownMenuItem(
                                      child: new Text(
                                        location,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      value: location,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(child: gridImage()),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: textInfo,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            controller: _editingControllerDonation,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0)),
                              ),
                              hintText: 'Target Donasi*',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          flex: 5,
                          child: TextField(
                            onTap: () {
                              _selectDate();
                            },
                            readOnly: true,
                            controller: _editingControllerTimes,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0)),
                              ),
                              hintText: 'Tanggal berakhir',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      controller: _editingControllerDescription,
                      maxLines: 10,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Deskripsi tidak boleh kosong';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Minimal 20 Character *',
                          hintStyle: TextStyle(fontSize: 13.0),
                          labelText: 'Deskripsi Galang Amal',
                          labelStyle: TextStyle(fontSize: 13.0),
                          hasFloatingPlaceholder: true),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  submitButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(Duration(days: 1)),
        lastDate: new DateTime(2100));

    if (picked != null && picked != date) {
      setState(() {
        var dateFormat = new DateFormat('yyyy-MM-dd').format(picked);
        _editingControllerTimes.text = dateFormat;
      });
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imgSelected = image;
    });

    print(imgSelected.path);
  }

  Future getGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgSelected = image;
    });
  }

  Future<ImageSource> _asyncImageSourceDialog() async {
    return await showDialog<ImageSource>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            title: const Text('Pilih Sumber Foto '),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
                child: const Text('Gallery', style: TextStyle(fontSize: 18)),
              ),
              SimpleDialogOption(
                onPressed: getImage,
                child: const Text('Camera', style: TextStyle(fontSize: 18)),
              ),
            ],
          );
        });
  }

  void save() async {
    final value = PostProgramAmal(
      titleProgram: _editingControllerTitle.text,
      category: categorySelected,
      targetDonasi: _editingControllerDonation.text,
      descriptionProgram: _editingControllerDescription.text,
      endDonasi: _editingControllerTimes.text,
    );

    if (_keyForm.currentState.validate()) {
      await changeLoadingVisible();
      bloc.save(value);
      await Future.delayed(Duration(seconds: 3));

      Navigator.of(context).pushReplacementNamed('/home');
    }
  }
}
