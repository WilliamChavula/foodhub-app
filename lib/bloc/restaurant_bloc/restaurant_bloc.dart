import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:mealsApp/models/restaurant.dart';
import 'package:meta/meta.dart';
import '../../services/restaurant_service.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class FoodhubRestaurantBloc
    extends Bloc<FoodhubRestaurantEvent, FoodhubRestaurantState> {
  FoodhubRestaurantBloc({@required this.service})
      : assert(service != null),
        super(FoodhubInitial());

  final RestaurantRepository service;
  final _errorMessage =
      "Please verify that you have an active internet connection and try again later";

  @override
  Stream<FoodhubRestaurantState> mapEventToState(
    FoodhubRestaurantEvent event,
  ) async* {
    if (event is LoadRestaurantEvent) {
      yield FoodhubRestaurantLoading();
      try {
        Future<List<Restaurant>> restaurants;
        if (event.restaurantCategoryTitle != null) {
          restaurants = this
              .service
              .getFilteredRestaurants(event.restaurantCategoryTitle);
        } else {
          restaurants = this.service.allRestaurants;
        }

        yield FoodhubRestaurantsLoaded(restaurants: restaurants);
      } on SocketException catch (_) {
        yield FoodhubRestaurantLoadingError(
            errorMessage: "No Internet connection. Please try again later.");
      } on PlatformException {
        yield FoodhubRestaurantLoadingError(errorMessage: _errorMessage);
      } on FirebaseException {
        yield FoodhubRestaurantLoadingError(errorMessage: _errorMessage);
      } catch (e) {
        yield FoodhubRestaurantLoadingError(errorMessage: e.toString());
      }
    }
  }
}
