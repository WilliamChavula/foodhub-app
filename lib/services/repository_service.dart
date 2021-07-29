import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../models/Category.dart';

abstract class CategoryRepository {
  Future<List<CuisineCategory>> get categories;
}

class CategoryRepositoryService implements CategoryRepository {
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  List<CuisineCategory> _categories;
  List<Map<String, List<dynamic>>> imagesCollection;

  Future<List<CuisineCategory>> get categories async {
    if (_categories != null) return _categories;

    try {
      final querySnapshot = await categoryCollection
          .get(GetOptions(source: Source.serverAndCache));

      _categories = querySnapshot.docs
          .map((doc) => CuisineCategory.fromMap(doc.data(), doc.id))
          .toList();

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
