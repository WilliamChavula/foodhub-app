import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mealsApp/models/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> get allRestaurants;
  Future<List<Restaurant>> getFilteredRestaurants(String criteria);
}

class RestaurantRepositoryService implements RestaurantRepository {
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('Restaurant');

  RestaurantRepositoryService({this.uid});

  final String uid;
  List<Restaurant> _restaurants;

  List<Restaurant> _restaurantFromSnapshot(QuerySnapshot restaurantSnapshot) {
    final restaurantsCollection = restaurantSnapshot.docs
        .map((doc) => Restaurant.fromMap(doc.data(), doc.id))
        .toList();

    return restaurantsCollection;
  }

  @override
  Future<List<Restaurant>> get allRestaurants async {
    if (_restaurants != null) return _restaurants;

    List<Restaurant> restaurants;

    try {
      final restaurantsList = await restaurantCollection
          .get(GetOptions(source: Source.serverAndCache));

      restaurants = _restaurantFromSnapshot(restaurantsList);

      _restaurants = restaurants;

      return _restaurants;
    } on SocketException {
      rethrow;
    } on PlatformException {
      rethrow;
    } on FirebaseException {
      rethrow;
    }
  }

  @override
  Future<List<Restaurant>> getFilteredRestaurants(String criteria) async {
    try {
      final allRestaurants = await RestaurantRepositoryService().allRestaurants;

      List<Restaurant> filteredRestaurant = allRestaurants
          .where((restaurant) =>
              restaurant.categoryName.contains(criteria.toLowerCase()))
          .toList();
      return filteredRestaurant;
    } on SocketException {
      rethrow;
    } on PlatformException {
      rethrow;
    } on FirebaseException {
      rethrow;
    }
  }
}
