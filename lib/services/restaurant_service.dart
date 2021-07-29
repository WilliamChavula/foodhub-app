import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mealsApp/CacheService/ICacheService.dart';
import 'package:mealsApp/CacheService/shared_preferences_cache.dart';
import 'package:mealsApp/models/restaurant.dart';
import 'package:mealsApp/services/cache_helper.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> get allRestaurants;
  Future<List<Restaurant>> getFilteredRestaurants(String criteria);
}

class RestaurantRepositoryService implements RestaurantRepository {
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('Restaurant');

  final ICacheService cacheService = SharedPreferencesCache();

  static const String COLLECTION_NAME = "restaurantCollection";
  static const String KEY = "restaurants";

  RestaurantRepositoryService({this.uid});

  final String uid;
  List<Restaurant> _restaurants;
  List<Restaurant> temp = [];

  List<Restaurant> _restaurantFromSnapshot(QuerySnapshot restaurantSnapshot) {
    final restaurantsCollection = restaurantSnapshot.docs
        .map((doc) => Restaurant.fromMap(doc.data(), doc.id))
        .toList();
    return restaurantsCollection;
  }

  @override
  Future<List<Restaurant>> get allRestaurants async {
    if (!CacheHelper.checkIfDataIsStale(COLLECTION_NAME)) {
      // read data from Cache
      final restaurantString = await CacheHelper.readData(KEY, COLLECTION_NAME);
      final restaurantMap = CacheHelper.getMapFromString(restaurantString);

      _restaurants = getListFromMap(restaurantMap);

      return _restaurants;
    } else {
      List<Restaurant> restaurants;

      try {
        final restaurantsList = await restaurantCollection
            .get(GetOptions(source: Source.serverAndCache));

        restaurants = _restaurantFromSnapshot(restaurantsList);

        // cache data

        var data = await CacheHelper().convertFromSnapShotToMap(restaurantsList);
        await CacheHelper().cacheData(KEY, data,  COLLECTION_NAME);

        return restaurants;
      } on SocketException {
        rethrow;
      } on PlatformException {
        rethrow;
      } on FirebaseException {
        rethrow;
      }
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

  static List<Restaurant> getListFromMap(Map<String, dynamic> collectionMap) {
    final collectionList = <Restaurant>[];
    collectionMap.forEach((key, value) {
      final data = value as Map<String, dynamic>;
      Restaurant object = Restaurant.fromMap(data, key);

      collectionList.add(object);
    });

    return collectionList;
  }
}
