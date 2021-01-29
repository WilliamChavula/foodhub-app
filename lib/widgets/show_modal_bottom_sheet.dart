import 'package:flutter/material.dart';
import 'package:mealsApp/utils/constants.dart';

import '../widgets/reviews_rating_widget.dart';

Future<void> buildShowModalBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    backgroundColor: Color(0XFFf2f2f2),
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          height: 900,
          decoration: BoxDecoration(
            // color: Color(0XFFFF0000),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    'Customer reviews & ratings',
                    style: kRestaurantDetailPageTileHeaderStyle.copyWith(
                      fontSize: 22.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '5.0',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                        Icon(Icons.star),
                      ],
                    ),
                    Text('352 ratings'),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                ReviewsRatingsWidget(
                  starRating: '5',
                  ratingCount: '300',
                ),
                SizedBox(
                  height: 5.0,
                ),
                ReviewsRatingsWidget(
                  starRating: '4',
                  ratingCount: '52',
                ),
                SizedBox(
                  height: 4.0,
                ),
                ReviewsRatingsWidget(
                  starRating: '3',
                  ratingCount: '0',
                ),
                SizedBox(
                  height: 5.0,
                ),
                ReviewsRatingsWidget(
                  starRating: '2',
                  ratingCount: '0',
                ),
                SizedBox(
                  height: 5.0,
                ),
                ReviewsRatingsWidget(
                  starRating: '1',
                  ratingCount: '0',
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14.0,
                        ),
                        Icon(Icons.star, size: 14.0),
                        Icon(Icons.star, size: 14.0),
                        Icon(Icons.star, size: 14.0),
                        Icon(Icons.star, size: 14.0),
                      ],
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Most delicious food in town!',
                      style: kRestaurantDetailPageTileHeaderStyle,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Text(
                      '- Natalie, ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
                    Text(
                      '11/27/2020',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13.0,
                          color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4,
                  thickness: 1,
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () => print('See all reviews'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'See all reviews',
                        style: kRestaurantDetailPageHeaderStyle.copyWith(
                          fontSize: 20.0,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 24.0,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4,
                  thickness: 1,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      textColor: Colors.white,
                      color: Color(0XFFBB7372),
                      onPressed: () => print('write a review'),
                      child: Text('Write a review'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
