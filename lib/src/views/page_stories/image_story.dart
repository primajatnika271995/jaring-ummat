import 'package:flutter/material.dart';

class ImageStory extends StatelessWidget {
  final String imageUri;
  ImageStory({this.imageUri});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
      },
      child: Hero(
        tag: 'Image Stories',
        child: GestureDetector(
          onVerticalDragEnd: (DragEndDetails dwon) {
            if (dwon.primaryVelocity > 800) {
              Navigator.pop(context);
            }
          },
          child: Container(
            child: FadeInImage(
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 100),
              placeholder: NetworkImage(this.imageUri),
              image: NetworkImage(this.imageUri),
            ),
          ),
        ),
      ),
    );
  }
}
