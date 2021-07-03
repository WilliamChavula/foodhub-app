import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mealsApp/models/Category.dart';
import 'package:mealsApp/services/firebase_storage_service.dart';
import 'package:meta/meta.dart';
import '../../services/repository_service.dart';

part 'foodhub_event.dart';
part 'foodhub_state.dart';

class FoodhubBloc extends Bloc<FoodhubEvent, FoodhubState> {
  FoodhubBloc({@required this.categoryRepositoryService})
      : assert(categoryRepositoryService != null),
        super(FoodhubInitial());

  final CategoryRepository categoryRepositoryService;

  final FirebaseStorageService _storageService = FirebaseStorageService();

  @override
  Stream<FoodhubState> mapEventToState(
    FoodhubEvent event,
  ) async* {
    if (event is LoadCategoriesEvent) {
      yield FoodhubCategoryLoading();
      try {
        final categories = await this.categoryRepositoryService.categories;
        final imageURLS =
            await _storageService.getImageURL('restaurant_categories');
        updateModelImageUrl(categories, imageURLS);
        final categoriesFuture = Future.value(categories);
        yield FoodhubCategoryLoaded(cuisineCategory: categoriesFuture);
      } on SocketException catch (_) {
        yield FoodhubCategoryLoadingError(
            errorMessage: "No Internet connection. Please try again later.");
      } catch (e) {
        yield FoodhubCategoryLoadingError(errorMessage: e.message);
      }
    }
  }

  void updateModelImageUrl(List<CuisineCategory> categories,
      List<Map<String, List>> imagesCollection) {
    /// [List<CuisineCategory>] of Cuisine Category models with an imageURL field
    /// [List<Map<String, List>> imagesCollection] of category images URLs from firebase storage
    for (var i = 0; i < categories.length; i++) {
      var category = categories[i];

      imagesCollection.forEach((image) {
        var imageName = image.keys.first;
        var match = category.title.toLowerCase();

        if (match.contains(" ")) {
          var item = match.split(" ");
          matchItemAndUpdateCategoryModel(imageName, item[0], category, image);
        } else {
          matchItemAndUpdateCategoryModel(imageName, match, category, image);
        }
      });
    }
  }

  void matchItemAndUpdateCategoryModel(
    String imageName,
    String name,
    CuisineCategory model,
    Map<String, List<dynamic>> image,
  ) {
    if (imageName.contains(name)) {
      var imageURL = image[imageName][0];
      model.imageURL = imageURL;
    }
  }
}
