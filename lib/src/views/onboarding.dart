import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnboardingView();
  }
}

int globalPageIndex = 0;
PageController globalPageController = PageController(initialPage: 0, keepPage: true);

class _OnboardingView extends State<OnboardingView> {

  int page = 0;
  String _title = 'Langkah 1/4';
  PageController _controller = globalPageController;
  
  final List<Widget> _pages = [
    // Step2View(onNext: (){
    //   globalPageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.ease);
    // }),
    // Step3View(onNext: (){
    //   globalPageController.animateToPage(3, duration: Duration(milliseconds: 500), curve: Curves.ease);
    // }),
    // Step4View(pageController: globalPageController,),
  ];

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: <Widget>[
          Positioned.fill(
            child: PageView(
              physics: new ClampingScrollPhysics(),
              controller: _controller,
              children: _pages,
              onPageChanged: (int p){
                setState(() {
                  page = p;
                  globalPageIndex = page;
                  _title = 'Langkah ${page+1}/${_pages.length}';
                });
              },
            )
          ),
          new Positioned( //Place it at the top, and not use the entire screen
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              centerTitle: false,
              title: Text(_title),
              leading: Offstage(
                  offstage: page==0,
                  child:  IconButton(
                      icon:  Icon(Icons.arrow_back),
                      onPressed: () => {
                        PrevPage(_controller, page)
                      },
                )
              ),
              actions: <Widget>[
                Offstage(
                  offstage: page==3,
                  child:  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () => {
                      NextPage(_controller, page)
                    },
                  )
                )
              ],
              backgroundColor: Colors.transparent, //No more green
              elevation: 0.0, //Shadow gone
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

 @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

void PrevPage(PageController _controller, int pageIndex) {
  _controller.animateToPage(pageIndex-1, duration: Duration(milliseconds: 500), curve: Curves.ease);
}

void NextPage(PageController _controller, int pageIndex) {
  _controller.animateToPage(pageIndex+1, duration: Duration(milliseconds: 500), curve: Curves.ease);
}