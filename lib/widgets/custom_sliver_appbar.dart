import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String imageURL;
  final BoxFit imageFit;
  final String id;

  const CustomSliverAppBar({
    Key key,
    @required this.imageURL,
    this.id,
    this.imageFit = BoxFit.cover,
  }) : super(key: key);

  Container _heroImageWidget() => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(imageURL), fit: imageFit),
        ),
      );

  Container _buildGradient() => Container(
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
      );

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      expandedHeight: deviceSize.height / 2.5,
      floating: true,
      pinned: true,
      flexibleSpace: Stack(
        children: [
          Hero(
            tag: id,
            child: _heroImageWidget(),
          ),
          _buildGradient(),
        ],
      ),
    );
  }
}
