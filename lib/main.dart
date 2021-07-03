import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/categories_bloc/foodhub_bloc.dart';
import './bloc/restaurant_bloc/restaurant_bloc.dart';
import './services/repository_service.dart';
import './services/restaurant_service.dart';

import 'bloc/photos_bloc/bloc/photos_bloc_bloc.dart';
import 'screens/categories_screen.dart';
import 'services/firebase_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // testData();
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoodhubRestaurantBloc>(
          create: (context) => FoodhubRestaurantBloc(
            restaurantRepositoryService: RestaurantRepositoryService(),
          ),
        ),
        BlocProvider<FoodhubBloc>(
          create: (context) => FoodhubBloc(
              categoryRepositoryService: CategoryRepositoryService())
            ..add(LoadCategoriesEvent()),
        ),
        BlocProvider<PhotosBlocBloc>(
          create: (context) =>
              PhotosBlocBloc(storageService: FirebaseStorageService())
                ..add(PhotosLoadingEvent(photosReference: 'restaurant_photos')),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FoodHub',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.brown,
          fontFamily: 'RobotoCondensed',
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyText2: TextStyle(color: Color.fromRGBO(19, 30, 30, 1)),
                headline6: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                ),
              ),
        ),
        home: CategoriesScreen(),
      ),
    );
  }
}
