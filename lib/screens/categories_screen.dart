import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealsApp/bloc/categories_bloc/foodhub_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mealsApp/widgets/loading_indicator.dart';
import '../models/Category.dart';
import './meals_detail_screen.dart';

import '../utils/constants.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  List<CuisineCategory> categories = [];
  String _searchValue;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // add LoadEvent to the bloc to start process of fetching data from Firebase
    // context.read<FoodhubBloc>().add(LoadCategoriesEvent());
  }

  @override
  void dispose() {
    super.dispose();

    // dispose the TextEditingController when the Widget is removed from the Widget tree
    _controller.dispose();
  }

  _handleSearchSubmit(BuildContext context, String searchInput) {
    print(searchInput);
    _controller.text = "";
    FocusScope.of(context).unfocus(); // remove focus and dismiss keyboard
    /*TODO
    * filter restaurant list for items matching search term
    * display results into the UI
    * add error handling for empty search terms
    */
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: kBackgroundColorStyle,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPageTitleText(),
                _buildPageSloganText(),
                SizedBox(height: 12.0),
                _buildSearchInputWidget(context),
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
                    // else if (state
                    //     is FoodhubCategoryLoading) //TODO: handle error state here
                    //   return LoadingIndicatorWidget(size: MediaQuery.of(context).size);

                    return LoadingIndicatorWidget(
                        size: MediaQuery.of(context).size);
                  }),
                ),
              ],
            ),
          ),
        ),
      );

  Row _buildSearchInputWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildSearchInput(_controller)),
        IconButton(
          onPressed: () => _handleSearchSubmit(context, _searchValue),
          icon: Icon(Icons.search),
          iconSize: 28.0,
        )
      ],
    );
  }

  Text _buildPageSloganText() {
    return Text(
      "Discover Malawi's finest cuisine",
      style: TextStyle(
          color: Color(0XFF525B76),
          fontSize: 18.0,
          fontFamily: 'NunitoSans',
          fontWeight: FontWeight.w500),
    );
  }

  Text _buildPageTitleText() {
    return Text(
      'FoodHub',
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

  TextField _buildSearchInput(TextEditingController controller) => TextField(
        controller: controller,
        onChanged: (val) {
          this.setState(() {
            _searchValue = val;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFF139A43)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFF139A43)),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(12.0),
          labelText: "Search...",
          labelStyle: TextStyle(color: Color(0XFF525B76), fontSize: 14.0),
          hintText: "Search by Cuisine or Restaurant name...",
          hintStyle: TextStyle(
            color: Color(0XFF525B76),
            fontStyle: FontStyle.italic,
            fontSize: 12.0,
          ),
        ),
        style: TextStyle(color: Color(0XFF100B00)),
      );
}
