import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class LembagaAmalDetailStoryPlayer extends StatefulWidget {
  final String resourceType;
  final String url;
  LembagaAmalDetailStoryPlayer({this.resourceType, this.url});

  @override
  _LembagaAmalDetailStoryPlayerState createState() =>
      _LembagaAmalDetailStoryPlayerState(
          resourceType: this.resourceType, url: this.url);
}

class _LembagaAmalDetailStoryPlayerState
    extends State<LembagaAmalDetailStoryPlayer> {
  String resourceType;
  String url;
  _LembagaAmalDetailStoryPlayerState({this.resourceType, this.url});

  final controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storiesView(),
    );
  }

  Widget storiesView() {
    List<StoryItem> widgetList = new List<StoryItem>();

    if (resourceType == "video") {
      widgetList.add(StoryItem.pageVideo(url, controller: controller));
      setState(() {});
    }

    if (resourceType == "image") {
      widgetList.add(
        StoryItem.pageImage(NetworkImage(url), imageFit: BoxFit.cover),
      );
      setState(() {});
    }

    return StoryView(
      widgetList,
      controller: controller,
      onStoryShow: (s) {
        print("Showing a story");
      },
      onComplete: () {
        print("Completed a cycle");
      },
      progressPosition: ProgressPosition.top,
      repeat: false,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
