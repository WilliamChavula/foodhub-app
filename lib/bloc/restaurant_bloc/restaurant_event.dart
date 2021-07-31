part of 'restaurant_bloc.dart';

@immutable
abstract class FoodhubRestaurantEvent {}

class LoadRestaurantEvent extends FoodhubRestaurantEvent {
  final String restaurantCategoryTitle;

  LoadRestaurantEvent({this.restaurantCategoryTitle});
}
