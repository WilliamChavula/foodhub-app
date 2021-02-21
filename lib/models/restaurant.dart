class Restaurant {
  String id;
  String overview;
  String name;
  String imageURL;
  Address address;
  List<dynamic> city;
  PhoneNumber phoneNumber;
  List<dynamic> categoryName;

  Restaurant({
    this.id,
    this.overview,
    this.name,
    this.imageURL,
    this.address,
    this.city,
    this.phoneNumber,
    this.categoryName,
  });

  factory Restaurant.fromMap(Map<String, dynamic> json, String id) =>
      Restaurant(
        id: id,
        overview: json["overview"],
        name: json["name"],
        imageURL: json["logo"],
        address: Address.fromMap(json["address"]),
        city: json["city"],
        phoneNumber: PhoneNumber.fromMap(json["phone number"]),
        categoryName: json["category"],
      );
}

class PhoneNumber {
  String blantyrePhoneNumber;
  String lilongwePhoneNumber;

  PhoneNumber({this.blantyrePhoneNumber, this.lilongwePhoneNumber});

  factory PhoneNumber.fromMap(Map<String, dynamic> json) => PhoneNumber(
        blantyrePhoneNumber: json["Blantyre"] ?? "",
        lilongwePhoneNumber: json["Lilongwe"] ?? "",
      );
}

class Address {
  String blantyreAddress;
  String lilongweAddress;

  Address({this.blantyreAddress, this.lilongweAddress});

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        blantyreAddress: json["Blantyre"] ?? "",
        lilongweAddress: json["Lilongwe"] ?? "",
      );
}
