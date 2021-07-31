part of 'restaurant_bloc.dart';

@immutable
abstract class FoodhubRestaurantState {}

class FoodhubInitial extends FoodhubRestaurantState {}

class FoodhubRestaurantLoading extends FoodhubRestaurantState {}

class FoodhubRestaurantsLoaded extends FoodhubRestaurantState {
  final Future<List<Restaurant>> restaurants;

  FoodhubRestaurantsLoaded({this.restaurants}) : assert(restaurants != null);
}

class FoodhubRestaurantLoaded extends FoodhubRestaurantState {
  final Stream<Restaurant> restaurant;

  FoodhubRestaurantLoaded({this.restaurant}) : assert(restaurant != null);
}

class FoodhubRestaurantLoadingError extends FoodhubRestaurantState {
  final String errorMessage;

  FoodhubRestaurantLoadingError({@required this.errorMessage})
      : assert(errorMessage != null);
}
