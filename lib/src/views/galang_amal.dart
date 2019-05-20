import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/views/components/galang_amal_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Component
import '../services/currency_format_service.dart';

class GalangAmalView extends StatefulWidget {
  final String activityPostId;
  final String profilePictureUrl;
  final String title;
  final String profileName;
  final int postedAt;
  final String description;
  final double totalDonation;
  final double targetDonation;
  final List<dynamic> imgContent;
  final String dueDate;
  final String totalLike;
  final String totalComment;

  GalangAmalView({
    Key key,
    this.activityPostId,
    this.profilePictureUrl,
    this.title,
    this.description,
    this.profileName,
    this.imgContent,
    this.postedAt = 0,
    this.totalDonation = 0,
    this.targetDonation = 0,
    this.dueDate,
    this.totalLike,
    this.totalComment,
  });

  @override
  _GalangAmalState createState() => _GalangAmalState();
}

class _GalangAmalState extends State<GalangAmalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0.0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: new Text(
          'Galang Amal',
          style: TextStyle(fontSize: 15.0),
        ),
        centerTitle: false,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: <Widget>[
          GalangAmalContainer(
            title: widget.title,
            imgContent: widget.imgContent,
            profileName: widget.profileName,
            dueDate: widget.dueDate,
            activityPostId: widget.activityPostId,
            description: widget.description,
            postedAt: widget.postedAt,
            profilePictureUrl: widget.profilePictureUrl,
            targetDonation: widget.targetDonation,
            totalComment: widget.totalComment,
            totalDonation: widget.totalDonation,
            totalLike: widget.totalLike,
          ),
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
                        // SizedBox(height: 3.0),
                        Text(
                          'Donasi terkumpul',
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          'Rp. ' +
                              '${CurrencyFormat().currency(widget.totalDonation)}' +
                              ' / ' +
                              '${CurrencyFormat().currency(widget.targetDonation)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          'Batas waktu ' + widget.dueDate,
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
                      color: Color.fromRGBO(21, 101, 192, 1.0),
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
