import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/utils/sizeUtils.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/profile_inbox_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/page_inbox/expired_transaksi.dart';
import 'package:flutter_jaring_ummat/src/views/page_inbox/histori_transaksi.dart';
import 'package:flutter_jaring_ummat/src/views/page_inbox/inbox_text_data.dart';
import 'package:flutter_jaring_ummat/src/views/page_inbox/transaksi_selesai.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    final titleBar = Text('Inbox',
        style: TextStyle(color: blackColor, fontSize: SizeUtils.titleSize));

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
              onPressed: () {},
              icon: Icon(NewIcon.delete_3x),
              color: blackColor,
              iconSize: 25,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(ProfileInboxIcon.mark_as_read_3x),
              color: blackColor,
              iconSize: 25,
            ),
          ],
          bottom: TabBar(
            indicatorColor: greenColor,
            labelColor: greenColor,
            unselectedLabelColor: grayColor,
            tabs: <Widget>[Tab(text: 'Transaksi'), Tab(text: 'Lainnya')],
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
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ListView.separated(
          itemCount: 3,
          shrinkWrap: true,
          separatorBuilder: (context, position) {
            return Padding(
              padding: EdgeInsets.only(left: 70.0),
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
            onTap: () {
              print(index);
              if (index == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HistoriTransaksiView(),
                  ),
                );
              }
              if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TransaksiSelesaiView(),
                  ),
                );
              }
              if (index == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ExpiredTransaksi(),
                  ),
                );
              }
            },
            title: Text(
              InboxTextData.listTransaksi[index],
              style: TextStyle(fontSize: 14.0),
            ),
            leading: CircleAvatar(
              backgroundColor: InboxTextData.listColorTransaksi[index],
              child: Icon(InboxTextData.listIconTransaksi[index],
                  color: whiteColor),
            ),
            trailing: Icon(NewIcon.next_small_2x, color: blackColor, size: 20),
          ),
        ),
      ],
    );
  }

  Widget listInbox() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
            child: Text(
              'Hari Ini',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          ListView.separated(
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, position) {
              return Padding(
                padding: EdgeInsets.only(left: 70.0),
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
              title: Text(
                InboxTextData.listTitle[index],
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text(InboxTextData.listSubtitle[index]),
              leading: CircleAvatar(
                backgroundColor: InboxTextData.listColor[index],
                child: Icon(InboxTextData.listIcon[index], color: whiteColor),
              ),
              trailing:
                  Icon(NewIcon.next_small_2x, color: blackColor, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
