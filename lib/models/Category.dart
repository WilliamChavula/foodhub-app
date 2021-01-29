class CuisineCategory {
  String id;
  String title;
  String imageURL;

  CuisineCategory({
    this.id,
    this.title,
    this.imageURL,
  });

  factory CuisineCategory.fromMap(Map<String, dynamic> json) => CuisineCategory(
        id: json["id"],
        title: json["name"],
        imageURL: json["imageURL"],
      );
}
