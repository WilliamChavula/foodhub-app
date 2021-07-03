// import 'package:firebase_image/firebase_image.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mealsApp/bloc/categories_bloc/foodhub_bloc.dart';
// // import 'package:mealsApp/services/firebase_storage_service.dart';
// import '../models/Category.dart';
// import './meals_detail_screen.dart';

// import '../utils/constants.dart';

// class CategoriesScreen extends StatefulWidget {
//   @override
//   _CategoriesScreenState createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen>
//     with SingleTickerProviderStateMixin {
//   List<CuisineCategory> categories = [];

//   @override
//   void initState() {
//     context.read<FoodhubBloc>().add(LoadCategoriesEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBackgroundColorStyle,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text(
//           'FoodHub',
//           style: kRestaurantDetailPageHeaderStyle,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
//         child: BlocBuilder<FoodhubBloc, FoodhubState>(
//             builder: (BuildContext context, FoodhubState state) {
//           if (state is FoodhubCategoryLoaded) {
//             return FutureBuilder<List<CuisineCategory>>(
//                 future: state.cuisineCategory,
//                 builder: (BuildContext context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                   categories = snapshot.data;
//                   return GridView.builder(
//                     // padding: EdgeInsets.all(16.0),
//                     itemCount: (categories != null) ? categories.length : 0,

//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10),
//                     itemBuilder: (context, index) {
//                       CuisineCategory cuisineCategories = categories[index];
//                       return InkWell(
//                         splashColor: kAppSplashColor,
//                         onTap: () {
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => MealsDetail(
//                                   categoryID: cuisineCategories.id,
//                                   categoryTitle: cuisineCategories.title,
//                                   categoryImageUrl: cuisineCategories.imageURL),
//                             ),
//                           );
//                         },
//                         child: Stack(
//                           overflow: Overflow.clip,
//                           alignment: Alignment.bottomLeft,
//                           children: [
//                             Hero(
//                               tag: cuisineCategories.id,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: FirebaseImage(
//                                         cuisineCategories.imageURL,
//                                       ),
//                                       fit: BoxFit.cover),
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                     colors: <Color>[
//                                       Colors.black.withAlpha(0),
//                                       Colors.black26,
//                                       Colors.black54
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(15)),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 cuisineCategories.title,
//                                 style: kRestaurantDetailPageTileHeaderStyle
//                                     .copyWith(color: Color(0XFFF0ECE7)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 });
//           } else if (state is FoodhubCategoryLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return Center(child: CircularProgressIndicator());
//         }),
//       ),
//     );
//   }
// }
