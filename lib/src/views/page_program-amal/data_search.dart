import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';

class DataSearch extends SearchDelegate<String> {
  final keyword = [
    "Bayar Zakat",
    "Zakat",
    "Bamuis BNI",
    "Bantuan Pendidikan",
    "Wakaf Mesjid",
    "Gempa Lombok",
    "Donasi",
    "Infaq",
    "Akun Amil"
  ];

  final recentSearch = [
    "Bantuan Pendidikan",
    "Wakaf Mesjid",
    "Gempa Lombok",
    "Donasi",
  ];

  final String noImg =
      "https://kempenfeltplayers.com/wp-content/uploads/2015/07/profile-icon-empty.png";

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for Appbar
    return [
      IconButton(
          icon: Icon(NewIcon.close_2x),
          color: blackColor,
          iconSize: 20,
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show some result based ont the selection
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when someone search for something
    final suggetionList = query.isEmpty
        ? recentSearch
        : keyword.where((p) => p.startsWith(query)).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text('Rekomendasi Kata Pencarian',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Zakat', style: TextStyle(color: Colors.purple)),
                  color: grayColor,
                ),
                OutlineButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Gempa Lombok',
                      style: TextStyle(color: Colors.purple)),
                  color: grayColor,
                ),
                OutlineButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Bamuis BNI',
                      style: TextStyle(color: Colors.purple)),
                  color: grayColor,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Bantuan Pendidikan',
                      style: TextStyle(color: Colors.purple)),
                  color: grayColor,
                ),
                OutlineButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text('Wakaf Mesjid',
                      style: TextStyle(color: Colors.purple)),
                  color: grayColor,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text('Riwayat Pencarian',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ),
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, position) {
                return Padding(
                  padding: EdgeInsets.only(left: 60.0),
                  child: new SizedBox(
                    height: 10.0,
                    child: new Center(
                      child: new Container(
                          margin: new EdgeInsetsDirectional.only(
                              start: 1.0, end: 1.0),
                          height: 5.0,
                          color: Colors.grey[200]),
                    ),
                  ),
                );
              },
              itemBuilder: (context, index) => ListTile(
                title: Text(suggetionList[index]),
                leading: Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                      image: NetworkImage(noImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              itemCount: suggetionList.length,
            ),
          ],
        ),
      ),
    );
  }
}
