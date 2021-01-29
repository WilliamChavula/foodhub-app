import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;
  final String imageURL;

  const CategoryItem({this.title, this.color, this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(imageURL), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black26,
                  Colors.black54
                ],
              ),
              borderRadius: BorderRadius.circular(15)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: kRestaurantDetailPageTileHeaderStyle.copyWith(
                color: Color(0XFFF0ECE7)),
          ),
        ),
      ],
    );
  }
}
