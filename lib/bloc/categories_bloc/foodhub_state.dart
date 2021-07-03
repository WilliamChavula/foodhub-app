part of 'foodhub_bloc.dart';

@immutable
abstract class FoodhubState {}

class FoodhubInitial extends FoodhubState {}

class FoodhubCategoryLoading extends FoodhubState {}

class FoodhubCategoryLoaded extends FoodhubState {
  final Future<List<CuisineCategory>> cuisineCategory;

  FoodhubCategoryLoaded({this.cuisineCategory})
      : assert(cuisineCategory != null);
}

class FoodhubCategoryLoadingError extends FoodhubState {
  final String errorMessage;

  FoodhubCategoryLoadingError({@required this.errorMessage})
      : assert(errorMessage != null);
}
