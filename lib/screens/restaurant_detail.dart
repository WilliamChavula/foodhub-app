import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

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
                          size: 18,
                          color: Color(0XFFDF713E),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        widget.restaurantData.city.length > 1
                            ? Text(
                                '${widget.restaurantData.city[0]}, ${widget.restaurantData.city[1]}',
                                style: kListTileTextStyle,
                              )
                            : Text(
                                '${widget.restaurantData.city[0]}',
                                style: kListTileTextStyle,
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
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
