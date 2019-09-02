import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/postModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/add_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
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

  final _titleController = new TextEditingController();
  final _descriptionController = new TextEditingController();
  final _targetController = new TextEditingController();
  final _timesDonation = new TextEditingController();

  DateTime date = new DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String dateSelected;
  String categorySelected;

  bool _loadingVisible = false;

  File imgSelected;

  @override
  Widget build(BuildContext context) {
    final textInfo = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        'Galang amal minimal 1 Gambar atau Video yang diunggah. Video maksimal berdurasi 1 menit 30 detik',
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
      ),
    );

    final imageContent = Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      color: grayColor,
      child: Stack(
        children: <Widget>[
          imgSelected == null
              ? Container()
              : Image.file(
                  imgSelected,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                ),
          Positioned(
            bottom: 5.0,
            right: 5.0,
            child: CircleAvatar(
              backgroundColor: greenColor,
              child: IconButton(
                onPressed: _asyncImageSourceDialog,
                icon: Icon(AddIconInAmil.add_large),
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );

    final titleField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: StreamBuilder<String>(
        stream: bloc.title,
        builder: (context, snapshot) => TextField(
          decoration: InputDecoration(
            hintText: 'Nama Aksi Amal',
            hasFloatingPlaceholder: true,
            labelText: 'Nama Aksi',
            errorText: snapshot.error,
          ),
          controller: _titleController,
          onChanged: bloc.changeTitle,
        ),
      ),
    );

    final categoryField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: StreamBuilder<Object>(
        stream: bloc.category,
        builder: (context, snapshot) => DropdownButtonFormField(
          value: categorySelected,
          onChanged: (newValue) {
            setState(() {
              bloc.changeCategory;
              categorySelected = newValue;
            });
          },
          items: category.map((location) {
            return DropdownMenuItem(
              child: new Text(
                location,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              value: location,
            );
          }).toList(),
          decoration: InputDecoration(
            hasFloatingPlaceholder: true,
            labelText: 'Kategori Aksi',
            errorText: snapshot.error,
          ),
        ),
      ),
    );

    final descriptionField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: StreamBuilder<Object>(
        stream: bloc.description,
        builder: (context, snapshot) => TextField(
          decoration: InputDecoration(
            hintText: 'Deskripsi Aksi Amal',
            hasFloatingPlaceholder: true,
            labelText: 'Deskripsi',
            errorText: snapshot.error,
          ),
          controller: _descriptionController,
          maxLines: 4,
          onChanged: bloc.changeDescription,
        ),
      ),
    );

    final tanggalField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Tanggal Berakhir',
            labelText: 'Tanggal Aksi',
            hasFloatingPlaceholder: true),
        controller: _timesDonation,
        onTap: _selectDate,
        readOnly: true,
      ),
    );

    final totalField = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Target Donasi Aksi Amal',
          labelText: 'Target Donasi',
          hasFloatingPlaceholder: true,
        ),
        controller: _targetController,
        keyboardType: TextInputType.number,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(NewIcon.back_small_2x, color: greenColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.black,
        ),
        title: new Text(
          'Buat Aksi Amal',
          style: TextStyle(color: blackColor),
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
            child: Column(children: <Widget>[
              imageContent,
              textInfo,
              titleField,
              SizedBox(height: 5.0),
              categoryField,
              SizedBox(height: 5.0),
              descriptionField,
              SizedBox(height: 5.0),
              tanggalField,
              SizedBox(height: 5.0),
              totalField,
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: StreamBuilder<Object>(
            stream: bloc.submitValid,
            builder: (context, snapshot) {
              return RaisedButton(
                onPressed: snapshot.hasData ? () => save() : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
                child: const Text(
                  'Buat Aksi Amal',
                  style: TextStyle(color: Colors.white),
                ),
                color: greenColor,
              );
            }),
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
        _timesDonation.text = dateFormat;
      });
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgSelected = image;
    });
  }

  Future getGallery() async {
    Navigator.of(context).pop(ImageSource.gallery);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print('Select Galery!');
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
                onPressed: getGallery,
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
      titleProgram: _titleController.text,
      category: categorySelected,
      targetDonasi: _targetController.text,
      descriptionProgram: _descriptionController.text,
      endDonasi: _timesDonation.text,
    );

    if (imgSelected == null) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        margin: EdgeInsets.all(8.0),
        borderRadius: 8.0,
        message: "Image tidak boleh kosong",
        leftBarIndicatorColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      await changeLoadingVisible();
      bloc.save(context, value, imgSelected.path);
    }
  }
}
