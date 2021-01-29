part of 'restaurant_bloc.dart';

@immutable
abstract class FoodhubRestaurantState {}

class FoodhubInitial extends FoodhubRestaurantState {}

class FoodhubRestaurantLoading extends FoodhubRestaurantState {}

class FoodhubRestaurantsLoaded extends FoodhubRestaurantState {
  final Stream<List<Restaurant>> restaurants;

  FoodhubRestaurantsLoaded({this.restaurants});
}

class FoodhubRestaurantLoaded extends FoodhubRestaurantState {
  final Stream<Restaurant> restaurant;

  FoodhubRestaurantLoaded({this.restaurant});
}

class FoodhubRestaurantLoadingError extends FoodhubRestaurantState {}
