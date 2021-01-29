import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mealsApp/models/Category.dart';
import 'package:meta/meta.dart';
import '../../services/repository_service.dart';

part 'foodhub_event.dart';
part 'foodhub_state.dart';

class FoodhubBloc extends Bloc<FoodhubEvent, FoodhubState> {
  FoodhubBloc({@required this.categoryRepositoryService})
      : super(FoodhubInitial());

  final CategoryRepositoryService categoryRepositoryService;

  @override
  Stream<FoodhubState> mapEventToState(
    FoodhubEvent event,
  ) async* {
    if (event is LoadCategoriesEvent) {
      yield FoodhubCategoryLoading();
      try {
        final categories = this.categoryRepositoryService.categories;
        yield FoodhubCategoryLoaded(cuisineCategory: categories);
      } catch (e) {
        yield FoodhubCategoryLoadingError();
      }
    }
  }
}
