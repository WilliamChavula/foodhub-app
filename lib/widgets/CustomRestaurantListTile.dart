import 'package:flutter/material.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:mealsApp/models/restaurant.dart';
import 'package:mealsApp/utils/constants.dart';

import './../screens/restaurant_detail.dart';

// List tempData,
Widget buildCustomRestaurantListTile(BuildContext context, int index,
    Animation<double> animation, List<Restaurant> tempData) {
  return FadeTransition(
    opacity: Tween<double>(begin: 0, end: 1).animate(animation),
    child: Card(
      color: Color(0XFFFEFEFE),
      elevation: 0.5,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute<RestaurantDetail>(
              builder: (context) => RestaurantDetail(
                restaurantData: tempData[index],
              ),
            )),
        child: Padding(
          padding: kMediumPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: tempData[index].id,
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(right: kMediumSpaceUnits),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FirebaseImage(tempData[index].imageURL),
                        fit: BoxFit.contain),
                    borderRadius: kBorderRadius,
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tempData[index].name,
                      style: kRestaurantDetailPageTileHeaderStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: kBody2FontSize,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      tempData[index].overview,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: kBodyFontColor,
                          letterSpacing: 1.2,
                          fontSize: 14.0),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
