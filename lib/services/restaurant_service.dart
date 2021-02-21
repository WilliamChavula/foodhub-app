import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealsApp/models/restaurant.dart';

class RestaurantRepositoryService {
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('Restaurant');

  final String uid;

  RestaurantRepositoryService({this.uid});

  List<Restaurant> _restaurantFromSnapshot(QuerySnapshot restaurantSnapshot) {
    return restaurantSnapshot.docs.map((doc) {
      return Restaurant.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Stream<List<Restaurant>> get restaurants {
    return restaurantCollection.snapshots().map(_restaurantFromSnapshot);
  }
}
