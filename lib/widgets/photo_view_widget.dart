import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'loading_indicator.dart';

class PhotoViewWidget extends StatefulWidget {
  const PhotoViewWidget({this.index, this.galleryItems, this.restaurantName});
  final int index;
  final List<String> galleryItems;
  final String restaurantName;

  @override
  _PhotoViewWidgetState createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {
  int currentIndex;

  void onPageChanged(int index) {
    indexController(index);
  }

  void indexController(index) {
    if (currentIndex == widget.galleryItems.length - 1) {
      setState(() {
        currentIndex = 0;
      });
    } else {
      setState(() {
        ++currentIndex;
      });
    }
  }

  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (context, index) => _buildItem(context, currentIndex),
            itemCount: widget.galleryItems.length,
            loadingBuilder: (context, _) => LoadingIndicatorWidget(
              size: MediaQuery.of(context).size,
            ),
            onPageChanged: onPageChanged,
            scrollDirection: Axis.horizontal,
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "${widget.restaurantName}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.0,
      imageProvider: CachedNetworkImageProvider(item),
      initialScale: PhotoViewComputedScale.contained,
      heroAttributes:
          PhotoViewHeroAttributes(tag: '${widget.restaurantName}-$index'),
    );
  }
}
