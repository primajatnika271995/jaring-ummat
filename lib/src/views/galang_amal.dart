import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/views/components/galang_amal_container.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';

// Component
import '../services/currency_format_service.dart';

class GalangAmalView extends StatefulWidget {
  final ProgramAmalModel programAmal;
  GalangAmalView({Key key, this.programAmal});

  @override
  _GalangAmalState createState() => _GalangAmalState();
}

class _GalangAmalState extends State<GalangAmalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0.0,
        elevation: 1.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(NewIcon.back_big_3x, color: greenColor),
        ),
        title: new Text(
          'Galang Amal',
          style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          GalangAmalContainer(programAmal: widget.programAmal)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Container(
          height: 75.0,
          child: new Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Donasi terkumpul',
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        ),
                        Text(
                          'Rp. ' +
                              '${CurrencyFormat().currency(widget.programAmal.totalDonation)}' +
                              ' / ' +
                              '${CurrencyFormat().currency(widget.programAmal.targetDonation)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Batas waktu ' + widget.programAmal.endDate,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        )
                      ],
                    ),
                    RaisedButton(
                      onPressed: () {},
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      color: greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                        child: Text('Kirim Donasi'),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
