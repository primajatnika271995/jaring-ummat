import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/programamal_bloc/programamal_bloc_event.dart';
import 'package:flutter_jaring_ummat/src/bloc/programamal_bloc/programamal_bloc_bloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_appbar_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_container.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jaring_ummat/src/views/components/appbar_custom_icons.dart';

class ProgramAmalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 8,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Colors.blueAccent,
              leading: new Icon(AppBarIcons.ic_leading),
              actions: <Widget>[
                SizedBox(
                  width: 7.0,
                ),
                Icon(Icons.chat),
                SizedBox(
                  width: 7.0,
                ),
                Icon(AppBarIcons.ic_action),
                SizedBox(
                  width: 13.0,
                ),
              ],
              centerTitle: true,
              automaticallyImplyLeading: true,
              titleSpacing: 0.0,
              title: Container(
                child: TextFormField(
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
                    hintText: 'Cari lembaga amal atau produk lainnya',
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
              ),
            ),
            preferredSize: Size.fromHeight(47.0),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                automaticallyImplyLeading: false,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(99.0),
                  child: Text(''),
                ),
                backgroundColor: Colors.white,
                elevation: 10.0,
                flexibleSpace: new Scaffold(
                  body: new UserStoryAppBar(),
                ),
              ),
              new SliverAppBar(
                expandedHeight: 20.0,
                backgroundColor: Colors.white,
                elevation: 10.0,
                automaticallyImplyLeading: true,
                floating: true,
                pinned: true,
                bottom: TabBar(
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 4.0, color: Colors.blueAccent),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    new Tab(
                      text: 'Semua Kategori',
                    ),
                    new Tab(
                      text: 'Pendidikan',
                    ),
                    new Tab(
                      text: 'Kemanusiaan',
                    ),
                    new Tab(
                      text: 'Amal',
                    ),
                    new Tab(
                      text: 'Pembangunan Masjid',
                    ),
                    new Tab(
                      text: 'Zakat',
                    ),
                    new Tab(
                      text: 'Bakti Sosial',
                    ),
                    new Tab(
                      text: 'lain-lain',
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  BlocProvider(
                    builder: (context) {
                      return ProgramamalBlocBloc(httpClient: http.Client())
                        ..dispatch(Fetch());
                    },
                    child: ProgramAmalContainer(),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
