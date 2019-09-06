import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_inbox/inbox_text_data.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    final titleBar = Text('Notifikasi', style: TextStyle(color: blackColor));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          elevation: 1,
          title: titleBar,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(left: 30),
              onPressed: null,
              icon: Icon(NewIcon.delete_3x),
              color: blackColor,
              iconSize: 20,
            ),
            IconButton(
              onPressed: null,
              icon: Icon(ProfileInboxIcon.mark_as_read_3x),
              color: blackColor,
              iconSize: 20,
            ),
          ],
          bottom: TabBar(
            indicatorColor: greenColor,
            labelColor: greenColor,
            unselectedLabelColor: grayColor,
            tabs: <Widget>[Tab(text: 'Transaksi'), Tab(text: 'Inbox')],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            listTransaction(),
            listInbox(),
          ],
        ),
      ),
    );
  }

  Widget listTransaction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
          child: Text(
            'Pembayaran',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.separated(
          itemCount: 2,
          shrinkWrap: true,
          separatorBuilder: (context, position) {
            return Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: new SizedBox(
                height: 10.0,
                child: new Center(
                  child: new Container(
                      margin:
                          new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                      height: 5.0,
                      color: Colors.grey[200]),
                ),
              ),
            );
          },
          itemBuilder: (context, index) => ListTile(
            title: Text(InboxTextData.listTransaksi[index]),
            trailing: Icon(NewIcon.next_small_2x, color: blackColor, size: 20),
          ),
        ),
      ],
    );
  }

  Widget listInbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
          child: Text(
            'Hari Ini',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.separated(
          itemCount: 4,
          shrinkWrap: true,
          separatorBuilder: (context, position) {
            return Padding(
              padding: EdgeInsets.only(left: 80.0),
              child: new SizedBox(
                height: 10.0,
                child: new Center(
                  child: new Container(
                      margin:
                          new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                      height: 5.0,
                      color: Colors.grey[200]),
                ),
              ),
            );
          },
          itemBuilder: (context, index) => ListTile(
            title: Text(InboxTextData.listTitle[index]),
            subtitle: Text(InboxTextData.listSubtitle[index]),
            leading: CircleAvatar(
              backgroundColor: InboxTextData.listColor[index],
              child: Icon(InboxTextData.listIcon[index], color: whiteColor),
            ),
            trailing: Icon(NewIcon.next_small_2x, color: blackColor, size: 20),
          ),
        ),
      ],
    );
  }
}
