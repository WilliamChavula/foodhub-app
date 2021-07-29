import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealsApp/CacheService/ICacheService.dart';
import 'package:mealsApp/CacheService/shared_preferences_cache.dart';

class CacheHelper {
  static final ICacheService cacheService = SharedPreferencesCache();
  final Map<String, dynamic> _collectionMap = Map<String, dynamic>();

  /// Convert snapshot received from Firestore collection to a Map
  Future<Map<String, dynamic>> convertFromSnapShotToMap(
    QuerySnapshot collectionSnapshot,
  ) async {
    collectionSnapshot.docs.forEach(
      (doc) => _collectionMap[doc.id] = doc.data(),
    );

    return _collectionMap;
  }

  /// cache data to shared preferences
  Future<void> cacheData(
    String key,
    Map<String, dynamic> collectionMap,
    String collectionName,
  ) async {
    final dataToCache = convertMapToJsonString(collectionMap);
    await cacheService.addToCache(key, dataToCache, collectionName);
  }

  /// convert Map of collection to a json string
  static String convertMapToJsonString(
    Map<String, dynamic> restaurantMap,
  ) {
    return jsonEncode(restaurantMap);
  }

  static bool checkIfDataIsStale(String collectionName) {
    return SharedPreferencesCache.validateDataNotStale(collectionName);
  }

  static Future<String> readData(String cacheKey, String collectionName) async {
    final collectionJsonString =
        await cacheService.readFromCache(cacheKey, collectionName);

    return collectionJsonString;
  }

  static Map<String, dynamic> getMapFromString(String collectionString) {
    // decode String from cache
    final collectionMap = jsonDecode(collectionString);
    return collectionMap;
  }
}
