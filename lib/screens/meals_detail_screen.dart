import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealsApp/bloc/restaurant_bloc/restaurant_bloc.dart';

import '../models/restaurant.dart';
import '../utils/constants.dart';
import '../widgets/CustomRestaurantListTile.dart';
import './../widgets/custom_sliver_appbar.dart';

class MealsDetail extends StatefulWidget {
  final String categoryID;
  final String categoryTitle;
  final String categoryImageUrl;

  const MealsDetail(
      {Key key, this.categoryID, this.categoryTitle, this.categoryImageUrl})
      : super(key: key);

  @override
  _MealsDetailState createState() => _MealsDetailState();
}

class _MealsDetailState extends State<MealsDetail> {
  List<Restaurant> restaurantByCuisine = [];

  // list animation
  final options = LiveOptions(
      delay: Duration(seconds: 0),
      showItemInterval: Duration(milliseconds: 250),
      showItemDuration: Duration(milliseconds: 700),
      visibleFraction: 0.05,
      reAnimateOnVisibility: false);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context
        .read<FoodhubRestaurantBloc>()
        .add(LoadRestaurantEvent(widget.categoryTitle));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColorStyle,
      body: BlocBuilder<FoodhubRestaurantBloc, FoodhubRestaurantState>(
        builder: (context, state) {
          if (state is FoodhubRestaurantsLoaded) {
            return StreamBuilder<List<Restaurant>>(
              stream: state.restaurants,
              builder: (context, asyncSnapshot) {
                if (!asyncSnapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                restaurantByCuisine = filterList(asyncSnapshot.data);
                return CustomScrollView(
                  slivers: <Widget>[
                    CustomSliverAppBar(
                      imageURL: widget.categoryImageUrl,
                      trailingIcon: FontAwesomeIcons.slidersH,
                      imageFit: BoxFit.cover,
                      id: widget.categoryID,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          widget.categoryTitle,
                          style: kRestaurantDetailPageHeaderStyle,
                        ),
                      ),
                    ),
                    LiveSliverList.options(
                      controller: _scrollController,
                      options: options,
                      itemCount: restaurantByCuisine.length,
                      itemBuilder: (context, index, animation) =>
                          buildCustomRestaurantListTile(
                        context,
                        index,
                        animation,
                        restaurantByCuisine,
                      ),
                    ),
                    // SliverList(
                    //   delegate: SliverChildBuilderDelegate(
                    //     (context, index) {
                    //       return buildCustomRestaurantListTile(
                    //         context,
                    //         index,
                    //         restaurantByCuisine,
                    //       );
                    //     },
                    //     childCount: restaurantByCuisine.length,
                    //   ),
                    // )
                  ],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Restaurant> filterList(List<Restaurant> unfilteredList) {
    List<Restaurant> filteredList = unfilteredList
        .where((element) =>
            element.categoryName.contains(widget.categoryTitle.toLowerCase()))
        .toList();
    return filteredList;
  }
}
