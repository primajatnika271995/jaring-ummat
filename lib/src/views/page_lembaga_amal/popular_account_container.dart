import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/config/preferences.dart';
import 'package:flutter_jaring_ummat/src/models/lembagaAmalModel.dart';
import 'package:flutter_jaring_ummat/src/views/page_lembaga_amal/details_lembaga.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_jaring_ummat/src/bloc/lembagaAmalBloc.dart';

class PopularAccountContainer extends StatefulWidget {
  final LembagaAmalModel value;
  final bool isFollow;
  PopularAccountContainer({Key key, this.value, this.isFollow})
      : super(key: key);

  @override
  _PopularAccountContainerState createState() =>
      _PopularAccountContainerState(value: this.value, isFollow: this.isFollow);
}

class _PopularAccountContainerState extends State<PopularAccountContainer> {
  LembagaAmalModel value;
  bool isFollow;
  _PopularAccountContainerState({this.value, this.isFollow});

  final String noImg =
      "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png";

  SharedPreferences _preferences;
  String _token;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print(value.lembagaAmalEmail);
        print(value.lembagaAmalName);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsLembaga(
              value: value,
            ),
          ),
        );
      },
      leading: Container(
        width: 55.0,
        height: 55.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
            image: (value.imageContent == null)
                ? NetworkImage(noImg)
                : NetworkImage(value.imageContent),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        value.lembagaAmalName,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            '${value.tipeAkun}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('${value.totalFollowers} Pengikut'),
          Text('${value.totalPostProgramAmal} Galang Amal'),
        ],
      ),
      trailing: (isFollow)
          ? buttonUnfollow(value.idLembagaAmal)
          : buttonFollow(value.idLembagaAmal),
    );
  }

  Widget buttonFollow(String idAccount) {
    return OutlineButton(
      onPressed: () async {
        if (_token == null) {
          Navigator.of(context).pushNamed('/login');
        } else {
          bloc.followAccount(idAccount);
          isFollow = true;
        }
      },
      color: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Text(
          'Follow',
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buttonUnfollow(String idAccountAmil) {
    return OutlineButton(
      borderSide: BorderSide(color: greenColor),
      onPressed: () {
        setState(() async {
          if (_token == null) {
            Navigator.of(context).pushNamed('/login');
          } else {
            bloc.unfollow(idAccountAmil);
            isFollow = false;
          }
        });
      },
      color: greenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        child: Text(
          'Following',
          style: TextStyle(color: greenColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  void checkToken() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _token = _preferences.getString(ACCESS_TOKEN_KEY);
    });
  }
}
