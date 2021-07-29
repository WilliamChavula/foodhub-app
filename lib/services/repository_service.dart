import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mealsApp/CacheService/ICacheService.dart';
import 'package:mealsApp/CacheService/shared_preferences_cache.dart';
import 'package:mealsApp/services/cache_helper.dart';
import '../models/Category.dart';

abstract class CategoryRepository {
  Future<List<CuisineCategory>> get categories;
}

class CategoryRepositoryService implements CategoryRepository {
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  final ICacheService cacheService = SharedPreferencesCache();

  static const String COLLECTION_NAME = "categoryCollection";
  static const String KEY = "categories";

  List<CuisineCategory> _categories;
  List<Map<String, List<dynamic>>> imagesCollection;

  Future<List<CuisineCategory>> get categories async {
    if (!CacheHelper.checkIfDataIsStale(COLLECTION_NAME)) {
      // read data from Cache
      final categoryString = await CacheHelper.readData(KEY, COLLECTION_NAME);
      final categoryMap = CacheHelper.getMapFromString(categoryString);

      _categories = getListFromMap(categoryMap);

      return _categories;
    } else {
      try {
        final querySnapshot = await categoryCollection
            .get(GetOptions(source: Source.serverAndCache));

        _categories = querySnapshot.docs
            .map((doc) => CuisineCategory.fromMap(doc.data(), doc.id))
            .toList();

        // cache data

        final data =
            await CacheHelper().convertFromSnapShotToMap(querySnapshot);
        CacheHelper().cacheData(KEY, data, COLLECTION_NAME);

        return _categories;
      } on SocketException {
        rethrow;
      } on PlatformException {
        rethrow;
      } on FirebaseException {
        rethrow;
      }
    }
  }

  static List<CuisineCategory> getListFromMap(
      Map<String, dynamic> collectionMap) {
    final collectionList = <CuisineCategory>[];
    collectionMap.forEach((key, value) {
      final data = value as Map<String, dynamic>;
      CuisineCategory object = CuisineCategory.fromMap(data, key);

      collectionList.add(object);
    });

    return collectionList;
  }
}
