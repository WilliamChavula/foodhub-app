import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealsApp/models/restaurant.dart';

class RestaurantRepositoryService {
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('Restaurant');

  final String uid;

  RestaurantRepositoryService({this.uid});

  List<Restaurant> _restaurantFromSnapshot(QuerySnapshot restaurantSnapshot) {
    return restaurantSnapshot.docs.map((doc) {
      var data = doc.data();
      return Restaurant(
        id: doc.id,
        name: data["name"],
        imageURL: data["logo"],
        address: data["address"],
        city: data["city"],
        phoneNumber: data["phone number"],
        categoryName: data["category"],
      );
    }).toList();
  }

  Stream<List<Restaurant>> get restaurants {
    return restaurantCollection.snapshots().map(_restaurantFromSnapshot);
  }
}
