import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mealsApp/models/restaurant.dart';
import 'package:meta/meta.dart';
import '../../services/restaurant_service.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class FoodhubRestaurantBloc
    extends Bloc<FoodhubRestaurantEvent, FoodhubRestaurantState> {
  FoodhubRestaurantBloc({@required this.restaurantRepositoryService})
      : super(FoodhubInitial());

  final RestaurantRepositoryService restaurantRepositoryService;

  @override
  Stream<FoodhubRestaurantState> mapEventToState(
    FoodhubRestaurantEvent event,
  ) async* {
    if (event is LoadRestaurantEvent) {
      yield FoodhubRestaurantLoading();
      try {
        final restaurants = this.restaurantRepositoryService.restaurants;
        yield FoodhubRestaurantsLoaded(restaurants: restaurants);
      } catch (e) {
        yield FoodhubRestaurantLoadingError();
      }
    }
  }
}
