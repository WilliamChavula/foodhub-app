import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:mealsApp/bloc/categories_bloc/foodhub_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mealsApp/screens/sliding_up_widget.dart';
import 'package:mealsApp/widgets/loading_indicator.dart';
import 'package:mealsApp/widgets/search_widget.dart';
import '../models/Category.dart';
import './meals_detail_screen.dart';

import '../utils/constants.dart';
import 'error_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  List<CuisineCategory> categories = [];

  SlidingUpPanelController _panelController = SlidingUpPanelController();

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Scaffold(
            floatingActionButton: Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.6), //color of shadow
                    spreadRadius: 2, //spread radius
                    blurRadius: 4, // blur radius
                    offset: Offset(1, 1), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                ],
                borderRadius: BorderRadius.circular(24.0),
                color: Color(0XFFBD6600),
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: _panelController.expand,
                ),
              ),
            ),
            backgroundColor: kBackgroundColorStyle,
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.0),
                    _buildPageTitleText(),
                    SizedBox(height: 16.0),
                    _buildPageSloganText(),
                    SizedBox(height: 16.0),
                    Expanded(
                      child: BlocBuilder<FoodhubBloc, FoodhubState>(
                          builder: (BuildContext context, FoodhubState state) {
                        if (state is FoodhubCategoryLoaded) {
                          return FutureBuilder<List<CuisineCategory>>(
                              future: state.cuisineCategory,
                              builder: (BuildContext context, snapshot) {
                                if (!snapshot.hasData)
                                  return LoadingIndicatorWidget(
                                      size: MediaQuery.of(context).size);

                                return _buildStaggeredGrid(snapshot.data);
                              });
                        }
                        if (state is FoodhubCategoryLoadingError) {
                          return ErrorScreen(errorMessage: state.errorMessage);
                        }

                        return LoadingIndicatorWidget(
                            size: MediaQuery.of(context).size);
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SlidingUpScreenWidget(
            panelController: _panelController,
            slidingUpWidgetContent: SlidingUpSearchWidget(),
          )
        ],
      );

  Text _buildPageSloganText() {
    return Text(
      "Discover Malawi's finest cuisine and upcoming dining spots",
      style: TextStyle(
          color: Color(0XFF525B76),
          fontSize: 16.0,
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w500),
    );
  }

  Text _buildPageTitleText() {
    return Text(
      'Tidye',
      style: kRestaurantDetailPageHeaderStyle,
    );
  }

  StaggeredGridView _buildStaggeredGrid(List<CuisineCategory> categories) =>
      StaggeredGridView.countBuilder(
        // padding: EdgeInsets.all(16.0),
        itemCount: categories?.length ?? 0,
        crossAxisCount: 4,
        itemBuilder: (BuildContext context, int index) {
          CuisineCategory cuisineCategories = categories[index];
          return InkWell(
            splashColor: kAppSplashColor,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MealsDetail(
                    categoryID: cuisineCategories.id,
                    categoryTitle: cuisineCategories.title,
                    categoryImageUrl: cuisineCategories.imageURL),
              ),
            ),
            child: _buildCategoryThumbnail(cuisineCategories),
          );
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 3 : 2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 6.0,
      );

  Stack _buildCategoryThumbnail(CuisineCategory cuisineCategories) => Stack(
        overflow: Overflow.clip,
        alignment: Alignment.bottomLeft,
        children: [
          Hero(
            tag: cuisineCategories.id,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      cuisineCategories.imageURL,
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black26,
                    Colors.black54
                  ],
                ),
                borderRadius: BorderRadius.circular(15)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              cuisineCategories.title,
              style: kRestaurantDetailPageTileHeaderStyle.copyWith(
                  color: Color(0XFFF0ECE7)),
            ),
          ),
        ],
      );
}
