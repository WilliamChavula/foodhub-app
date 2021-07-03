import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:mealsApp/models/restaurant.dart';
import 'package:meta/meta.dart';
import '../../services/restaurant_service.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class FoodhubRestaurantBloc
    extends Bloc<FoodhubRestaurantEvent, FoodhubRestaurantState> {
  FoodhubRestaurantBloc({@required this.restaurantRepositoryService})
      : assert(restaurantRepositoryService != null),
        super(FoodhubInitial());

  final RestaurantRepository restaurantRepositoryService;

  @override
  Stream<FoodhubRestaurantState> mapEventToState(
    FoodhubRestaurantEvent event,
  ) async* {
    if (event is LoadRestaurantEvent) {
      yield FoodhubRestaurantLoading();
      try {
        final restaurants = this.restaurantRepositoryService.restaurants;

        yield FoodhubRestaurantsLoaded(restaurants: restaurants);
      } on SocketException catch (_) {
        yield FoodhubRestaurantLoadingError(
            errorMessage: "No Internet connection. Please try again later.");
      } catch (e) {
        yield FoodhubRestaurantLoadingError(errorMessage: e.message);
      }
    }
  }
}
