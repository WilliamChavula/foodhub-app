import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:mealsApp/widgets/loading_indicator.dart';

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
                padding:
                    const EdgeInsets.only(top: 8.0, left: 10.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.restaurantData.name,
                        style: kRestaurantDetailPageHeaderStyle.copyWith(
                            fontSize: 28)),
                    Row(
                      children: [
                        Text('Location:',
                            style: kListTileTextStyle.copyWith(
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5.0),
                        widget.restaurantData.city.length > 1
                            ? Text(
                                '${widget.restaurantData.city[0]} and  ${widget.restaurantData.city[1]}',
                                style: kListTileTextStyle)
                            : Text('${widget.restaurantData.city[0]}',
                                style: kListTileTextStyle),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text('Address:',
                        style: kListTileTextStyle.copyWith(
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4.0),
                    Text(widget.restaurantData.address?.blantyreAddress,
                        style: kListTileTextStyle),
                    Text(widget.restaurantData.address?.lilongweAddress,
                        style: kListTileTextStyle),
                    const SizedBox(height: 8.0),
                    Text('Phone:',
                        style: kListTileTextStyle.copyWith(
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4.0),
                    Text(widget.restaurantData.phoneNumber?.blantyrePhoneNumber,
                        style: kListTileTextStyle),
                    Text(widget.restaurantData.phoneNumber?.lilongwePhoneNumber,
                        style: kListTileTextStyle),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overview',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Color(0XFF424953), fontSize: 18.0),
                          ),
                          Text(
                            widget.restaurantData.overview,
                            style: kListTileTextStyle.copyWith(
                              fontSize: 16.0,
                              height: 1.8,
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemCount:
                                  widget.restaurantData.images?.length ?? 0,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          widget.restaurantData.images[index],
                                      placeholder: (context, _) =>
                                          LoadingIndicatorWidget(
                                        size: MediaQuery.of(context).size,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                            ),
                          ),
                        ],
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

  List<dynamic> filterRestaurantPhotos(String restaurantName,
      List<Map<String, List<dynamic>>> restaurantPhotos) {
    List<dynamic> filteredList;
    for (var photo in restaurantPhotos) {
      final restaurantKey = photo.keys.first.toLowerCase();
      if (restaurantKey == restaurantName) {
        filteredList = photo[photo.keys.first];
      }
    }
    return filteredList;
  }
}

/*
decoration: BoxDecoration(
  image: DecorationImage(
    image: CachedNetworkImageProvider(
        list[index]),
    fit: BoxFit.cover,
  ),
  borderRadius: BorderRadius.all(
      Radius.circular(4.0))),
*/
