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
  const SlidingUpSearchWidget();

  @override
  _SlidingUpSearchWidgetState createState() => _SlidingUpSearchWidgetState();
}

class _SlidingUpSearchWidgetState extends State<SlidingUpSearchWidget> {
  // String _searchInputText;
  List<Restaurant> restaurantList;
  List<String> uniqueRestaurantNames;
  List<Restaurant> search = [];
  Timer delayQuerying;

  final TextEditingController _searchInputController = TextEditingController();

  @override
  void initState() {
    context.read<FoodhubRestaurantBloc>().add(LoadRestaurantEvent());
    _searchInputController.addListener(() {
      _setRestaurants(context, restaurants: search);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchInputController.dispose();
    delayQuerying.cancel();
    super.dispose();
  }

  _setRestaurants(BuildContext context, {List<Restaurant> restaurants}) {
    restaurantList = restaurants;
    search = List.from(restaurantList);

    performSearch();
    // FocusScope.of(context).unfocus();
    search.sort((a, b) => a.name.compareTo(b.name));
  }

  void performSearch() {
    if (_searchInputController.text != null) {
      search.retainWhere(
        (restaurant) => restaurant.name.toLowerCase().contains(
              _searchInputController.text.toLowerCase(),
            ),
      );
    }
  }

  List<String> _setRestaurantStrings(List<Restaurant> restaurants) {
    uniqueRestaurantNames =
        restaurants.map((item) => item.name).toSet().toList();
    uniqueRestaurantNames.sort((a, b) => a.compareTo(b));
    return uniqueRestaurantNames;
  }

  // void _handleSearchSubmit({String searchText}) {
  //   print(searchText);
  //   if (searchText != null) {
  //     print(searchText);
  //     search.retainWhere(
  //       (restaurant) => restaurant.name.toLowerCase().contains(
  //             _searchInputController.text.toLowerCase(),
  //           ),
  //     );
  //   }
  //   print(search.length);
  // }

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
      padding: const EdgeInsets.all(16.0),
      child: _buildSearchInput(_searchInputController),
    );
  }

  Widget _buildSearchInput(TextEditingController controller) => Theme(
        data: Theme.of(context).copyWith(
          // override textfield's icon color when selected
          primaryColor: Colors.green,
        ),
        child: TextField(
          // onChanged: (searchText) =>
          //     _handleSearchSubmit(searchText: searchText),
          controller: controller,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: Icon(
              Icons.search,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF139A43)),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.all(8.0),
            labelText: "Search by Restaurant name...",
            labelStyle: TextStyle(
                color: Color(0XFF525B76),
                fontSize: 12.0,
                fontStyle: FontStyle.italic),
            hintText: "Search by Restaurant name...",
            hintStyle: TextStyle(
              color: Color(0XFF525B76),
              fontStyle: FontStyle.italic,
              fontSize: 12.0,
            ),
          ),
          style: TextStyle(color: Color(0XFF100B00)),
        ),
      );

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
                strList: [..._setRestaurantStrings(search)],
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
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute<RestaurantDetail>(
              builder: (context) => RestaurantDetail(
                restaurantData: uniqueRestaurants[index],
              ),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: uniqueRestaurants[index].id,
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FirebaseImage(
                        uniqueRestaurants[index].imageURL,
                      ),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.circular(10),
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
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
