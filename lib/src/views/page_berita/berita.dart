import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/bloc/beritaBloc.dart';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/models/beritaModel.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/home_page_icons_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/icon_text/new_icon_icons.dart';
import 'package:flutter_jaring_ummat/src/views/components/loadingContainer.dart';
import 'package:flutter_jaring_ummat/src/views/page_berita/berita_content.dart';
import 'package:flutter_svg/svg.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({Key key}) : super(key: key);

  @override
  _BeritaPageState createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  final String title = "Berita Jejaring";
  String selectedCategory = "";

  final List<String> imgList = [
    'http://www.radar-palembang.com/wp-content/uploads/2017/06/BNI.jpg',
    'https://cdn2.tstatic.net/sumsel/foto/bank/images/muhammad-adil-direktur-utama-bank-sumselbabel-berfoto-dengan-anak-panti_20150710_151920.jpg',
    'http://informatika.narotama.ac.id/file/content/150730105606_bukber2014_2.jpg'
  ];
  int _current = 0;

  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      inAsyncCall: _loadingVisible,
      child: Scaffold(
        body: DefaultTabController(
          length: 8,
          child: Scaffold(
            backgroundColor: whiteColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: whiteColor,
              elevation: 0.0,
              title: Text(
                title,
                style: TextStyle(color: blackColor, fontSize: 18.0),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.only(right: 10.0),
                  icon: Icon(NewIcon.search_big_3x),
                  iconSize: 20.0,
                  color: greenColor,
                ),
              ],
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                new SliverAppBar(
                  backgroundColor: whiteColor,
                  elevation: 1.0,
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                  flexibleSpace: AppBar(
                    backgroundColor: whiteColor,
                    elevation: 2.0,
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      isScrollable: true,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: greenColor),
                      ),
                      labelColor: blackColor,
                      unselectedLabelColor: grayColor,
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
                        bloc.fetchAllBerita(selectedCategory);
                      },
                      tabs: <Widget>[
                        new Tab(
                          text: 'Populer',
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
                  delegate: SliverChildListDelegate([
                    Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              getFullScreenCarousel(context),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 20.0, top: 10.0),
                                child: const Text(
                                  'Kegiatan',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 20.0, top: 0.0),
                                child: const Text(
                                  'Pleatihan Da\'i Mandiri Se-Jawa Barat Di YABNI Sumedang',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10.0, right: 5.0, top: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const Text(
                                        'Bamuis BNI | 08:56, 02 Januari 2019'),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, right: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(NewIcon.love_3x,
                                              color: greenColor, size: 20.0),
                                          SizedBox(width: 10.0),
                                          Icon(NewIcon.comment_3x,
                                              color: greenColor, size: 20.0),
                                          SizedBox(width: 10.0),
                                          Icon(NewIcon.save_3x,
                                              color: greenColor, size: 20.0),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                                child: new Center(
                                  child: new Container(
                                    margin: new EdgeInsetsDirectional.only(
                                        start: 1.0, end: 1.0),
                                    height: 5.0,
                                    color: softGreyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        StreamBuilder(
                          stream: bloc.allBerita,
                          builder: (context,
                              AsyncSnapshot<List<BeritaModel>> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                _loadingVisible = true;
                                return Text('');
                                break;
                              default:
                                if (snapshot.hasData) {
                                  _loadingVisible = false;
                                  return buildList(snapshot);
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                _loadingVisible = false;
                                return Container(
                                  width: 500.0,
                                  margin: EdgeInsets.only(top: 30.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        'assets/icon/no-content.svg',
                                        height: 250.0,
                                      ),
                                      Text(
                                        'Oops..',
                                        style: TextStyle(
                                          fontFamily: 'Proxima',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        'There\'s nothing \'ere, yet.',
                                        style: TextStyle(
                                          fontFamily: 'Proxima',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                break;
                            }
                          },
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  CarouselSlider getFullScreenCarousel(BuildContext context) {
    return CarouselSlider(
      autoPlay: false,
      viewportFraction: 3.0,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      items: imgList.map(
        (url) {
          return Container(
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          );
        },
      ).toList(),
    );
  }

  Widget buildList(AsyncSnapshot<List<BeritaModel>> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        var value = snapshot.data[index];
        return BeritaContent(
          berita: value,
        );
      },
    );
  }

  Future<void> changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchAllBerita(selectedCategory);
  }
}
