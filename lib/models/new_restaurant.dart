import 'dart:convert';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  Restaurant({
    this.restaurant,
  });

  List<RestaurantElement> restaurant;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        restaurant: List<RestaurantElement>.from(
            json["Restaurant"].map((x) => RestaurantElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Restaurant": List<dynamic>.from(restaurant.map((x) => x.toJson())),
      };
}

class RestaurantElement {
  RestaurantElement({
    this.name,
    this.address,
    this.phoneNumber,
    this.images,
    this.category,
    this.city,
  });

  String name;
  String address;
  String phoneNumber;
  List<dynamic> images;
  List<String> category;
  List<City> city;

  factory RestaurantElement.fromJson(Map<String, dynamic> json) =>
      RestaurantElement(
        name: json["name"],
        address: json["address"],
        phoneNumber: json["phone number"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        category: List<String>.from(json["category"].map((x) => x)),
        city: List<City>.from(json["city"].map((x) => cityValues.map[x])),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "phone number": phoneNumber,
        "images": List<dynamic>.from(images.map((x) => x)),
        "category": List<dynamic>.from(category.map((x) => x)),
        "city": List<dynamic>.from(city.map((x) => cityValues.reverse[x])),
      };
}

enum City { BLANTYRE, LILONGWE }

final cityValues =
    EnumValues({"blantyre": City.BLANTYRE, "lilongwe": City.LILONGWE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
