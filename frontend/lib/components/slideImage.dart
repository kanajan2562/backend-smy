import 'package:flutter/material.dart';
class SlideImages extends StatefulWidget {
  const SlideImages({ Key? key }) : super(key: key);

  @override
  _SlideImagesState createState() => _SlideImagesState();
}

class _SlideImagesState extends State<SlideImages> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundColor: Colors.amber,
              ),
            )
          ],
        )
      ),
    );
  }
}