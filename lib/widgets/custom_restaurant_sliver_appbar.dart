import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key key,
    @required this.imageURL,
    this.id,
    this.imageFit = BoxFit.cover,
  }) : super(key: key);

  final String imageURL;
  final BoxFit imageFit;
  final String id;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      expandedHeight: deviceSize.height / 3,
      floating: true,
      pinned: true,
      flexibleSpace: Stack(
        children: [
          Hero(
            tag: id,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FirebaseImage(imageURL), fit: imageFit),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.01)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
