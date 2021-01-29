import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/Category.dart';

class CategoryRepositoryService {
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('categories');

  List<CuisineCategory> _categoriesFromSnapshot(
      QuerySnapshot categorySnapshot) {
    return categorySnapshot.docs.map((doc) {
      var data = doc.data();
      return CuisineCategory(
        id: doc.id,
        title: data["name"],
        imageURL: data["imageURL"],
      );
    }).toList();
  }

  Stream<List<CuisineCategory>> get categories {
    return categoryCollection.snapshots().map(_categoriesFromSnapshot);
  }
}
