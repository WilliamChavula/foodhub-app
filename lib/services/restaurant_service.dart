import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealsApp/models/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> get restaurants;
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

  Future<List<Restaurant>> get restaurants async {
    if (_restaurants != null) return _restaurants;

    var restaurants;

    try {
      final restaurantsList = await restaurantCollection.get();

      restaurants = _restaurantFromSnapshot(restaurantsList);
    } catch (e) {
      print(e.message);
    }

    return restaurants;
  }
}
