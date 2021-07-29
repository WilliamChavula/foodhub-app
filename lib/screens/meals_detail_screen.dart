import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealsApp/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:mealsApp/widgets/loading_indicator.dart';

import '../models/restaurant.dart';
import '../utils/constants.dart';
import '../widgets/CustomRestaurantListTile.dart';
import './../widgets/custom_sliver_appbar.dart';
import 'error_screen.dart';

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
    context.read<FoodhubRestaurantBloc>().add(LoadRestaurantEvent(
          restaurantCategoryTitle: widget.categoryTitle,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FoodhubRestaurantBloc, FoodhubRestaurantState>(
        builder: (context, state) {
          if (state is FoodhubRestaurantsLoaded) {
            return FutureBuilder<List<Restaurant>>(
                future: state.restaurants,
                builder: (context, asyncSnapshot) {
                  if (!asyncSnapshot.hasData) {
                    return LoadingIndicatorWidget(size: size);
                  }
                  return CustomScrollView(slivers: <Widget>[
                    CustomSliverAppBar(
                      imageURL: widget.categoryImageUrl,
                      imageFit: BoxFit.cover,
                      id: widget.categoryID,
                    ),
                    SliverToBoxAdapter(
                      child: _buildRestaurantDetailCategoryName(),
                    ),
                    LiveSliverList.options(
                        controller: _scrollController,
                        options: options,
                        itemCount: asyncSnapshot.data.length,
                        itemBuilder: (context, index, animation) =>
                            buildCustomRestaurantListTile(
                              context,
                              index,
                              animation,
                              asyncSnapshot.data,
                            ))
                  ]);
                });
          }
          if (state is FoodhubRestaurantLoadingError) {
            return ErrorScreen(errorMessage: state.errorMessage);
          }
          return LoadingIndicatorWidget(size: size);
        },
      ),
    );
  }

  Container _buildRestaurantDetailCategoryName() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          widget.categoryTitle,
          style: kRestaurantDetailPageHeaderStyle,
        ),
      );
}
