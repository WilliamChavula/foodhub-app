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
      elevation: 0,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetail(
                  restaurantData: tempData[index],
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: tempData[index].id,
                child: Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FirebaseImage(tempData[index].imageURL),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tempData[index].name,
                      style: kRestaurantDetailPageTileHeaderStyle.copyWith(
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                          color: Color(0XFFDF713E),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        tempData[index].city.length > 1
                            ? Text(
                                '${tempData[index].city[0]}, ${tempData[index].city[1]}',
                                style: kListTileTextStyle,
                              )
                            : Text(
                                '${tempData[index].city[0]}',
                                style: kListTileTextStyle,
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
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
