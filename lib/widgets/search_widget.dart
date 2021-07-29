import 'dart:async';

import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealsApp/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'package:mealsApp/models/restaurant.dart';
import 'package:mealsApp/screens/error_screen.dart';
import 'package:mealsApp/screens/restaurant_detail.dart';
import 'package:mealsApp/utils/constants.dart';

import 'loading_indicator.dart';

class SlidingUpSearchWidget extends StatefulWidget {
  final TextEditingController searchInputController;

  const SlidingUpSearchWidget({this.searchInputController});

  @override
  _SlidingUpSearchWidgetState createState() => _SlidingUpSearchWidgetState();
}

class _SlidingUpSearchWidgetState extends State<SlidingUpSearchWidget> {
  // String _searchInputText;
  List<Restaurant> restaurantList;
  List<String> uniqueRestaurantNames;
  List<Restaurant> search = [];
  Timer delayQuerying;

  @override
  void initState() {
    
    widget.searchInputController.addListener(() {
      _setRestaurants(context, restaurants: search);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.searchInputController.dispose();
    delayQuerying.cancel();
    super.dispose();
  }

  _setRestaurants(BuildContext context, {List<Restaurant> restaurants}) {
    restaurantList = restaurants;
    search = List.from(restaurantList);

    performSearch();
    search.sort((a, b) => a.name.compareTo(b.name));
  }

  void performSearch() {
    if (widget.searchInputController.text != null) {
      search.retainWhere(
        (restaurant) => restaurant.name.toLowerCase().contains(
              widget.searchInputController.text.toLowerCase(),
            ),
      );
    }
  }

  List<String> _setRestaurantStrings(List<Restaurant> restaurants) {
    Iterable<String> uniqueRestaurantMap = restaurants.map((item) => item.name);
    uniqueRestaurantNames = uniqueRestaurantMap.toSet().toList();
    uniqueRestaurantNames.sort((a, b) => a.compareTo(b));
    return uniqueRestaurantNames;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchInputWidget(context),
        Expanded(
          child: _buildRestaurantList(context),
        ),
      ],
    );
  }

  Widget _buildSearchInputWidget(BuildContext context) {
    return Padding(
      padding: kLargePadding,
      child: _buildSearchInput(widget.searchInputController),
    );
  }

  Widget _buildSearchInput(TextEditingController controller) {
    const TextStyle kSearchLabelStyle = const TextStyle(
      color: kBodyFontColor,
      fontSize: 12.0,
      fontStyle: FontStyle.italic,
    );
    return Theme(
      data: Theme.of(context).copyWith(
        // override textfield's icon color when selected
        primaryColor: kBoldOrangeColor,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: Icon(
            Icons.search,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kBoldOrangeColor),
          ),
          isDense: true,
          contentPadding: kSmallPadding,
          labelText: kSearchHintText,
          labelStyle: kSearchLabelStyle,
          hintText: kSearchHintText,
          hintStyle: kSearchLabelStyle,
        ),
        style: TextStyle(
          color: kDarkBodyFontColor,
        ),
      ),
    );
  }

  _buildRestaurantList(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<FoodhubRestaurantBloc, FoodhubRestaurantState>(
      builder: (context, state) {
        if (state is FoodhubRestaurantsLoaded) {
          return FutureBuilder<List<Restaurant>>(
            future: state.restaurants,
            builder: (context, asyncSnapshot) {
              if (!asyncSnapshot.hasData) {
                return LoadingIndicatorWidget(size: size);
              }
              _setRestaurants(context, restaurants: asyncSnapshot.data);
              return AlphabetListScrollView(
                strList: _setRestaurantStrings(search),
                indexedHeight: (_) => 60.0,
                showPreview: true,
                keyboardUsage: true,
                itemBuilder: (context, index) =>
                    restaurantListTiles(context, search, index),
              );
            },
          );
        }
        if (state is FoodhubRestaurantLoadingError) {
          return ErrorScreen(errorMessage: state.errorMessage);
        }
        return LoadingIndicatorWidget(size: size);
      },
    );
  }
}

Padding restaurantListTiles(
  BuildContext context,
  List<Restaurant> uniqueRestaurants,
  int index,
) =>
    Padding(
      padding: kMediumPadding,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute<RestaurantDetail>(
              builder: (context) => RestaurantDetail(
                restaurantData: uniqueRestaurants[index],
              ),
            ),
          );
          FocusScope.of(context).unfocus();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: uniqueRestaurants[index].id,
              child: Container(
                width: 40.0,
                height: 40.0,
                margin: EdgeInsets.only(right: kMediumSpaceUnits),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FirebaseImage(
                        uniqueRestaurants[index].imageURL,
                      ),
                      fit: BoxFit.contain),
                  borderRadius: kBorderRadius,
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    uniqueRestaurants[index].name,
                    style: kRestaurantDetailPageTileHeaderStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: kSubHeaderFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
