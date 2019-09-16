import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/galangAmalListDonationModel.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_jaring_ummat/src/services/currency_format_service.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';

class GalangAmalContainer extends StatefulWidget {
  final ProgramAmalModel programAmal;
  GalangAmalContainer({Key key, this.programAmal});

  @override
  _GalangAmalContainerState createState() => _GalangAmalContainerState();
}

class _GalangAmalContainerState extends State<GalangAmalContainer> {
  final List<String> imgNoContent = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/1280px-No_image_3x4.svg.png"
  ];

  final String noImg =
      "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png";

  int _current = 0;

  bool isLoved = false;
  bool flag = true;

  String lessDesc;
  String moreDesc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: Column(
        children: <Widget>[
          setTopContent(),
          setMainImage(),
          setDescription(),
          new Divider(),
          setBottomContent(),
          new Divider(),
          ListTile(
            title: Text(
              'Donatur Terbaru',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                '3 donatur terbaru pada galang amal ini. Yuk ikut berdonasi bersama mereka agar target donasinya segera tercapai.'),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(NewIcon.next_small_2x),
              color: blackColor,
              iconSize: 20,
            ),
          ),
          StreamBuilder(
            stream: bloc.galangAmalDonationStream,
            builder: (context,
                AsyncSnapshot<List<GalangAmalListDonation>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('');
                  break;
                default:
                  if (snapshot.hasData) {
                    return listDonation(snapshot.data);
                  }
                  return Text('NO DATA');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getProfilePicture() {
    return CircleAvatar(
      backgroundColor: greenColor,
      child: widget.programAmal.user.imgProfile == null
          ? Text(
              widget.programAmal.createdBy.substring(0, 1),
              style: TextStyle(color: whiteColor),
            )
          : CircularProfileAvatar(widget.programAmal.user.imgProfile[0].imgUrl),
    );
  }

  Widget getTopInformation() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.programAmal.titleProgram,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Text(
            'Oleh ' +
                widget.programAmal.createdBy +
                ' • ' +
                TimeAgoService()
                    .timeAgoFormatting(widget.programAmal.createdDate),
            style: TextStyle(
              fontSize: 11.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget setTopContent() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          getProfilePicture(),
          getTopInformation(),
        ],
      ),
    );
  }

  Widget setMainImage() {
    return Stack(
      children: <Widget>[
        CarouselSlider(
          height: 250.0,
          autoPlay: false,
          reverse: false,
          viewportFraction: 1.0,
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          items: (widget.programAmal.imageContent == null)
              ? imgNoContent.map((url) {
                  return Container(
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                }).toList()
              : widget.programAmal.imageContent.map(
                  (url) {
                    return Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: url.imgUrl,
                          errorWidget: (content, url, error) =>
                              new Icon(Icons.error),
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    );
                  },
                ).toList(),
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Positioned(
          left: 10.0,
          bottom: 15.0,
          child: DotsIndicator(
            dotsCount: (widget.programAmal.imageContent == null)
                ? imgNoContent.length
                : widget.programAmal.imageContent.length,
            position: _current,
            decorator: DotsDecorator(
              color: greenColor,
              spacing: const EdgeInsets.all(2.0),
            ),
          ),
        )
      ],
    );
  }

  Widget setDescription() {
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: moreDesc.isEmpty
          ? new Text(
              lessDesc,
              textAlign: TextAlign.justify,
            )
          : new Column(
              children: <Widget>[
                new Text(
                  flag ? (lessDesc + "...") : (lessDesc + moreDesc),
                  textAlign: TextAlign.justify,
                ),
                new InkWell(
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget setContent() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10.0),
      child: Row(
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
                'Rp. ' + '4.069.830' + '/' + '25.000.000',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                'Batas waktu ' + '30 Juni 2019',
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
    );
  }

  Widget setBottomContent() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          setCommentandLikes(),
          setSave(),
        ],
      ),
    );
  }

  Widget setCommentandLikes() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              isLoved = true;
            });
          },
          child: Row(
            children: <Widget>[
              Icon(
                (isLoved) ? NewIcon.love_3x : NewIcon.love_3x,
                size: 20.0,
                color: (isLoved) ? Colors.red : blackColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${widget.programAmal.totalLikes}' + ' Likes',
                style: TextStyle(
                  fontSize: 13.0,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: <Widget>[
              Icon(
                NewIcon.comment_3x,
                color: blackColor,
                size: 20.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                '${widget.programAmal.totalComments}' + ' Komentar',
                style: TextStyle(
                  fontSize: 13.0,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget setSave() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Row(
            children: <Widget>[
              Icon(
                NewIcon.save_3x,
                color: blackColor,
                size: 20.0,
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: <Widget>[
              Icon(
                NewIcon.share_3x,
                color: blackColor,
                size: 20.0,
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget listDonation(List<GalangAmalListDonation> snapshot) {
    return ListView.builder(
        itemCount: snapshot.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var data = snapshot[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200], width: 3),
                borderRadius: BorderRadius.circular(13),
              ),
              child: ListTile(
                title: Text('${data.customerName}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle:
                    Text('${data.donasiDate}', style: TextStyle(fontSize: 11)),
                trailing: Text(
                    'Rp ${CurrencyFormat().currency(data.nominalDibayar.toDouble())}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Container(
                  width: 53.0,
                  height: 53.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    if (widget.programAmal.descriptionProgram.length > 150) {
      lessDesc = widget.programAmal.descriptionProgram.substring(0, 150);
      moreDesc = widget.programAmal.descriptionProgram
          .substring(150, widget.programAmal.descriptionProgram.length);
    } else {
      lessDesc = widget.programAmal.descriptionProgram;
      moreDesc = "";
    }

    bloc.fetchGalangAmalDonation(widget.programAmal.idProgram);
  }
}
