class Restaurant {
  String id;
  String name;
  String imageURL;
  String address;
  List<dynamic> city;
  String phoneNumber;
  List<dynamic> categoryName;

  Restaurant({
    this.id,
    this.name,
    this.imageURL,
    this.address,
    this.city,
    this.phoneNumber,
    this.categoryName,
  });

  factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        imageURL: json["logo"],
        address: json["address"],
        city: json["city"],
        phoneNumber: json["phoneNumber"],
        categoryName: json["category"],
      );
}
