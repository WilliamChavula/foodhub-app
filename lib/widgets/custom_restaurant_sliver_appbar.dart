import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/show_modal_bottom_sheet.dart';

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
          buildReviewsButton(context),
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

  Positioned buildReviewsButton(BuildContext context) {
    return Positioned(
        bottom: 20,
        right: 20,
        child: GestureDetector(
          onTap: () {
            buildShowModalBottomSheet(context);
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: Color(0XFF424953).withOpacity(0.5),
                // border: Border.all(
                //     width: 2.0, color: const Color(0xFFFFFFFF)),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
            child: Text(
              'Reviews',
              style: TextStyle(
                  fontSize: 16.0, color: Colors.white, letterSpacing: 1.5),
            ),
          ),
        ));
  }
}
