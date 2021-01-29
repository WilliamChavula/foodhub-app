import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key key,
    @required this.imageURL,
    @required this.trailingIcon,
    this.id,
    this.imageFit = BoxFit.cover,
  }) : super(key: key);

  final String imageURL;
  final IconData trailingIcon;
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
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(18.0),
                  bottomLeft: Radius.circular(18.0),
                ),
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
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(18.0),
                bottomLeft: Radius.circular(18.0),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: FaIcon(
            trailingIcon,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
