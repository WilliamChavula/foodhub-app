part of 'foodhub_bloc.dart';

@immutable
abstract class FoodhubState {}

class FoodhubInitial extends FoodhubState {}

class FoodhubCategoryLoading extends FoodhubState {}

class FoodhubCategoryLoaded extends FoodhubState {
  final Stream<List<CuisineCategory>> cuisineCategory;

  FoodhubCategoryLoaded({this.cuisineCategory});
}

class FoodhubCategoryLoadingError extends FoodhubState {}
