import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';

class ImageStory extends StatelessWidget {

  int index = 0;
  List<StoryList> content;
  ImageStory({Key key, this.content, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Image Stories',
      child: GestureDetector(
        onVerticalDragEnd: (DragEndDetails down) {
          if (down.primaryVelocity > 800) {
            Navigator.pop(context);
          }
        },
        child: Container(
          child: FadeInImage(
            fit: BoxFit.cover,
            fadeInDuration: Duration(milliseconds: 100),
            placeholder: NetworkImage(content[index].url),
            image: NetworkImage(content[index].url),
          ),
        ),
      ),
    );
  }
}
