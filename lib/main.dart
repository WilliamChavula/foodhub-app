import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealsApp/screens/categories_screen.dart';
import 'package:mealsApp/services/firebase_auth.dart';
import 'package:mealsApp/utils/constants.dart';
import './bloc/categories_bloc/foodhub_bloc.dart';
import './bloc/restaurant_bloc/restaurant_bloc.dart';
import './services/repository_service.dart';
import './services/restaurant_service.dart';

import 'bloc/photos_bloc/bloc/photos_bloc_bloc.dart';
import 'services/firebase_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SignInWithFirebaseAuth().signIn();
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
            service: RestaurantRepositoryService(),
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
        title: kAppName,
        theme: ThemeData(
          primarySwatch: Colors.deepOrangeAccent[600],
          accentColor: kAccentColor,
          fontFamily: 'Oxygen',
          textTheme: ThemeData.dark().textTheme.copyWith(
                bodyText2: TextStyle(color: kBodyFontColor),
                headline6: TextStyle(
                  fontSize: kSubHeaderFontSize,
                  fontFamily: 'Oxygen',
                  fontWeight: FontWeight.w600,
                ),
              ),
        ),
        home: CategoriesScreen(),
      ),
    );
  }
}
