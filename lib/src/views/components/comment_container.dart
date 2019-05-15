import 'package:flutter/material.dart';
import 'package:bottom_sheet_stateful/bottom_sheet_stateful.dart';

class CommentComponent extends StatefulWidget {
  @override
  _CommentComponentState createState() => _CommentComponentState();
}

class _CommentComponentState extends State<CommentComponent> {

  BSAttribute _bsAttribute;

  @override
  void initState() {
    super.initState();
    _bsAttribute = BSAttribute();
  }

  void _bsCallback(double width, double height) {
    print("bs1 callback-> width: ${width.toString()}, height: ${height.toString()}");
  }

  Widget getLikesMessageProfile(var img) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(img),
            fit: BoxFit.contain,
          )),
    );
  }

  Widget setParticipan(var name, var profilePict) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.only(left: 10.0, bottom: 0.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(profilePict),
                            fit: BoxFit.contain,
                          )),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(height: 3.0),
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3.0),
                        Container(
                          width: 270.0,
                          child: Text(
                            'Beramal dibidang pendidikan berarti kita ikut '
                                'mencerdaskan kehidupan bangsa. Semoga '
                                'semakin banyak aksi amal semacam ini.',
                            style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(122, 122, 122, 1.0)),
                          ),
                        ),
                        Text(
                          '19 menit yang lalu',
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.normal,
                              color: Color.fromRGBO(122, 122, 122, 1.0)),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _commentPopUp() {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: false,
        title: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'Bantuan Dana Pendidikan Siswa SD Tunas',
              style: TextStyle(fontSize: 15.0),
            ),
            new Text(
              'Oleh Bamuis BNI - 30 menit yang lalu',
              style: TextStyle(fontSize: 11.0),
            )
          ],
        ),
        leading: new Container(
          color: Colors.blueAccent,
          padding: EdgeInsets.all(1.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/users/bamuis_min.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 3.0),
                    Text(
                      '26.116 Muzakki menyukai akun ini',
                      style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(122, 122, 122, 1.0)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          new Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 0.0, right: 10.0),
            child: Row(
              children: <Widget>[
                getLikesMessageProfile(
                    'https://www.iphonesavvy.com/sites/default/files/%5Bcurrent-date%3Afile_path%5D/jan-profile-circle.png'),
                getLikesMessageProfile(
                    'https://37e04m2dcg7asf2fw4bk96r1-wpengine.netdna-ssl.com/wp-content/uploads/2015/07/dr-arnold-profile-in-circlePS-400.png'),
                getLikesMessageProfile(
                    'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
                getLikesMessageProfile(
                    'https://joinyena.com/wp-content/uploads/2018/01/profile-circle.png'),
                SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: new Text(
                    'tampilkan semua',
                    style:
                    TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                  ),
                )
              ],
            ),
          ),
          new Divider(),
          Container(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 3.0),
                    Text(
                      '8.127 Muzakki berkomentar pada aksi ini',
                      style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(122, 122, 122, 1.0)),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ],
            ),
          ),
          setParticipan('Abdul R Arraisi',
              'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
          SizedBox(
            height: 10.0,
          ),
          setParticipan('Rika Amalia Puteri',
              'https://i2.wp.com/www.coachcarson.com/wp-content/uploads/2018/09/Chad-Profile-pic-circle.png?resize=800%2C800&ssl=1'),
          SizedBox(
            height: 10.0,
          ),
          setParticipan('Nanra Sukedy',
              'https://joinyena.com/wp-content/uploads/2018/01/profile-circle.png'),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Container(
          height: 50.0,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Container(
              width: 100.0,
              height: 100.0,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/users/orang.png"),
//                      fit: BoxFit.contain,
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Colors.black,
                ),
                onPressed: () => {},
              ),
            ],
            centerTitle: true,
            automaticallyImplyLeading: true,
            titleSpacing: 0.0,
            title: Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
//                      autofocus: true,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.only(top: 7.0, bottom: 7.0, left: -15.0),
                    icon: Icon(Icons.search, size: 18.0),
                    border: InputBorder.none,
                    hintText: 'Tulis komentar anda disini...',
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.grey[200],
              ),
              padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetStateful(
        body: _commentPopUp()
    );
  }
}
