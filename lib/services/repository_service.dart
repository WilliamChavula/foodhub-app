import 'package:cloud_firestore/cloud_firestore.dart';
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
      final querySnapshot = await categoryCollection.get();

      _categories = querySnapshot.docs
          .map((doc) => CuisineCategory.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print(e.message);
    }

    return _categories;
  }
}
