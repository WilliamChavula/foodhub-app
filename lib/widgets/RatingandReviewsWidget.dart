import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import './../utils/constants.dart';

class RatingandReviewsWidget extends StatelessWidget {
  final double rating;
  final String reviews;

  const RatingandReviewsWidget({
    Key key,
    this.rating,
    this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmoothStarRating(
          rating: rating,
          isReadOnly: false,
          size: 14,
          color: Color(0XFFe84118),
          filledIconData: Icons.star,
          halfFilledIconData: Icons.star_half,
          defaultIconData: Icons.star_border,
          starCount: 5,
          allowHalfRating: true,
          spacing: 2.0,
          onRated: (value) {
            print("rating value -> $value");
          },
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          reviews,
          style: kListTileTextStyle,
        ),
      ],
    );
  }
}
