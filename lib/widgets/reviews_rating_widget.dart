import 'package:flutter/material.dart';

class ReviewsRatingsWidget extends StatelessWidget {
  const ReviewsRatingsWidget({Key key, this.ratingCount, this.starRating})
      : super(key: key);

  final String starRating;
  final String ratingCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.09),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$starRating Stars',
          ),
          SizedBox(
            width: 10.0,
          ),
          Stack(
            children: [
              Container(
                height: 4.0,
                width: MediaQuery.of(context).size.width * 0.48,
                color: Colors.grey,
              ),
              Container(
                height: 4.0,
                width: MediaQuery.of(context).size.width * 0.3,
                color: Color(0XFFC27573),
              ),
            ],
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            ratingCount,
          ),
        ],
      ),
    );
  }
}
