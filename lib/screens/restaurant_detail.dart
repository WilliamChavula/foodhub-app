import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './../models/restaurant.dart';
import './../widgets/custom_restaurant_sliver_appbar.dart';
import './../utils/constants.dart';

class RestaurantDetail extends StatefulWidget {
  final Restaurant restaurantData;

  const RestaurantDetail({
    this.restaurantData,
  });

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            imageURL: widget.restaurantData.imageURL,
            trailingIcon: FontAwesomeIcons.slidersH,
            imageFit: BoxFit.fitWidth,
            id: widget.restaurantData.id,
          ),
          SliverFillRemaining(
            child: DelayedDisplay(
              delay: Duration(milliseconds: 500),
              slidingBeginOffset: const Offset(0.0, 0.0),
              child: Container(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.restaurantData.name,
                      style: kRestaurantDetailPageHeaderStyle.copyWith(
                          fontSize: 28),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.black45,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Blantyre, Malawi',
                          style: kListTileTextStyle.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                      height: 80.0,
                      color: kBackgroundColorStyle,
                      child: Row(
                        children: [
                          const Text(
                            'Overall Rating:',
                            style: kRestaurantDetailPageTileHeaderStyle,
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const CircleAvatar(
                            backgroundColor: Color(0XFFF5BA45),
                            radius: 18,
                            child: Icon(
                              Icons.star,
                              size: 30,
                              color: Color(0XFFFFFFFF),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4.5',
                                style: kListTileTextStyle.copyWith(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Rating',
                                style:
                                    kListTileTextStyle.copyWith(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Expanded(
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: kListTileTextStyle.copyWith(
                          fontSize: 16.0,
                          height: 1.8,
                        ),
                      ),
                    ),
                    // Brief description of restaurant
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
