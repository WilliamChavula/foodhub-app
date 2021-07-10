import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'loading_indicator.dart';

Widget restaurantImagesCarouselSlider(
  BuildContext context, {
  List<String> restaurantMealSamplesImages,
}) =>
    CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: MediaQuery.of(context).size.height * 0.5,
      ),
      items: restaurantMealSamplesImages
          .map(
            (image) => Builder(
              builder: (BuildContext context) => Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: CachedNetworkImage(
                  height: MediaQuery.of(context).size.height * 0.5,
                  imageUrl: image,
                  placeholder: (context, _) => LoadingIndicatorWidget(
                    size: MediaQuery.of(context).size,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
          .toList(),
    );
