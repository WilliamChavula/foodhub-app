import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:mealsApp/bloc/categories_bloc/foodhub_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mealsApp/bloc/restaurant_bloc/restaurant_bloc.dart';
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
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Scaffold(
            floatingActionButton: Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  kBoldOrangeColor,
                  kMidOrangeColor,
                  kLightOrangeColor
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: kDarkBodyFontColor, //color of shadow
                    spreadRadius: 1, //spread radius
                    blurRadius: 1, // blur radius
                    offset: Offset(0.5, 0.5), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                ],
                borderRadius: BorderRadius.circular(24.0),
                color: kMidOrangeColor,
              ),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context
                        .read<FoodhubRestaurantBloc>()
                        .add(LoadRestaurantEvent());

                    _panelController.expand();
                  },
                ),
              ),
            ),
            backgroundColor: kScaffoldColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kSmallSpaceUnits, vertical: kSmallSpaceUnits),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.0),
                    _buildPageTitleText(),
                    _buildPageSloganText(),
                    SizedBox(height: kSizedBoxUnits),
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
            editingController: _searchController,
            slidingUpWidgetContent: SlidingUpSearchWidget(
              searchInputController: _searchController,
            ),
          )
        ],
      );

  Text _buildPageSloganText() {
    return Text(
      kAppSlogan,
      style: TextStyle(
          color: kBodyFontColor,
          fontSize: kBody1FontSize,
          fontWeight: FontWeight.w500),
    );
  }

  GradientText _buildPageTitleText() {
    return GradientText(
      kAppTitle,
      gradient: LinearGradient(
          colors: [kBoldOrangeColor, kMidOrangeColor, kLightOrangeColor]),
      style: kRestaurantDetailPageHeaderStyle.copyWith(
          fontFamily: "AllertaStencil", fontSize: 28.0),
    );
  }

  StaggeredGridView _buildStaggeredGrid(List<CuisineCategory> categories) =>
      StaggeredGridView.countBuilder(
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
        mainAxisSpacing: kSmallSpaceUnits,
        crossAxisSpacing: kSmallSpaceUnits,
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
                borderRadius: kBorderRadius,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    kImageGradientColor1,
                    kImageGradientColor2,
                    kImageGradientColor3
                  ]),
              borderRadius: kBorderRadius,
            ),
          ),
          Padding(
            padding: kSmallPadding,
            child: Text(
              cuisineCategories.title,
              style: kRestaurantDetailPageTileHeaderStyle.copyWith(
                color: kShadowColor,
                fontSize: kBody2FontSize,
              ),
            ),
          ),
        ],
      );
}
