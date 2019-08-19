import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/programAmalBloc.dart';
import 'package:toast/toast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_jaring_ummat/src/models/program_amal.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_jaring_ummat/src/views/components/userstory_appbar_container.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/program_amal_content.dart';

class ProgramAmalPage extends StatefulWidget {
  @override
  _ProgramAmalPageState createState() => _ProgramAmalPageState();
}

class _ProgramAmalPageState extends State<ProgramAmalPage> {
  String selectedCategory = "";
  bool hide_story = false;

  StoriesApiProvider _provider = new StoriesApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 8,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
              child: AppBar(
                titleSpacing: 10.0,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                centerTitle: true,
                backgroundColor: Colors.white,
                title: Container(
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blueAccent,
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
                    color: Colors.grey[300],
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.chat, color: Colors.black),
                      onPressed: () {}),
                ],
              ),
              preferredSize: Size.fromHeight(47.0)),
          body: CustomScrollView(
            slivers: <Widget>[
              !hide_story
                  ? new SliverAppBar(
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(100.0),
                        child: Text(''),
                      ),
                      elevation: 20.0,
                      flexibleSpace: new Scaffold(
                        backgroundColor: Colors.white,
                        body: new UserStoryAppBar(),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([]),
                    ),
              new SliverAppBar(
                backgroundColor: Colors.white,
                elevation: 10.0,
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                flexibleSpace: AppBar(
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(width: 4.0, color: Colors.blueAccent),
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    onTap: (int index) {
                      switch (index) {
                        case 1:
                          setState(() {
                            selectedCategory = "Pendidikan";
                          });
                          break;
                        case 2:
                          setState(() {
                            selectedCategory = "Kemanusiaan";
                          });
                          break;
                        case 3:
                          setState(() {
                            selectedCategory = "Amal";
                          });
                          break;
                        case 4:
                          setState(() {
                            selectedCategory = "Pembangunan Mesjid";
                          });
                          break;
                        case 5:
                          setState(() {
                            selectedCategory = "Zakat";
                          });
                          break;
                        case 6:
                          setState(() {
                            selectedCategory = "Sosial";
                          });
                          break;
                        case 7:
                          setState(() {
                            selectedCategory = "lain-lain";
                          });
                          break;
                        default:
                          setState(() {
                            selectedCategory = "";
                          });
                      }
                      bloc.fetchAllProgramAmal(selectedCategory);
                    },
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
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: <Widget>[
                        StreamBuilder(
                          stream: bloc.allProgramAmal,
                          builder: (context, AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
                            if (snapshot.hasData) {
                              return buildList(snapshot);
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<List<ProgramAmalModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.data[index];
        return ProgramAmalContent(
          programAmal: value,
        );
      },
    );
  }

  @override
  void initState() {
    bloc.fetchAllProgramAmal(selectedCategory);
    hideStory();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void hideStory() async {
    await _provider.response().then((response) {
      if (response.statusCode == 204) {
        setState(() {
          hide_story = true;
        });
      } else {
        if (response.statusCode == 200) {
          setState(() {
            hide_story = false;
          });
        }
      }
    });
  }
}
