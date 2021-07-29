import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
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

  final StorageService _storageService = FirebaseStorageService();

  final _errorMessage =
      "Please verify that you have an active internet connection and try again later";

  @override
  Stream<FoodhubState> mapEventToState(
    FoodhubEvent event,
  ) async* {
    if (event is LoadCategoriesEvent) {
      yield FoodhubCategoryLoading();
      try {
        final categories = await this.categoryRepositoryService.categories;
        final imageURLS = await _storageService.getImageURL(
          'restaurant_categories',
        );
        updateModelImageUrl(
          categories,
          imageURLS,
        );
        final categoriesFuture = Future.value(categories);
        yield FoodhubCategoryLoaded(
          cuisineCategory: categoriesFuture,
        );
      } on SocketException {
        yield FoodhubCategoryLoadingError(
          errorMessage: _errorMessage,
        );
      } on PlatformException {
        yield FoodhubCategoryLoadingError(
          errorMessage: _errorMessage,
        );
      } on FirebaseException {
        yield FoodhubCategoryLoadingError(
          errorMessage: _errorMessage,
        );
      } catch (e) {
        yield FoodhubCategoryLoadingError(errorMessage: e.message);
      }
    }
  }

  /// [List<CuisineCategory>] of Cuisine Category models with an imageURL field
  /// [List<Map<String, List>> imagesCollection] of category images URLs from firebase storage
  void updateModelImageUrl(List<CuisineCategory> categories,
      List<Map<String, List>> imagesCollection) {
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
