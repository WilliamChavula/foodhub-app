import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:mealsApp/widgets/restaurant_carousel_image_slider.dart';

import '../widgets/loading_indicator.dart';
import '../models/restaurant.dart';
import '../widgets/custom_restaurant_sliver_appbar.dart';
import '../utils/constants.dart';
import '../extensions/capitalize_word_ext.dart';
import '../extensions/trim_whiteSpace_ext.dart';
import 'sliding_up_widget.dart';

class RestaurantDetail extends StatefulWidget {
  final Restaurant restaurantData;

  const RestaurantDetail({
    this.restaurantData,
  });

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  ScrollController _scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        panelController.expand();
      } else if (_scrollController.offset <=
              _scrollController.position.minScrollExtent &&
          !_scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgs = widget.restaurantData.images.cast<String>();
    return Stack(
      children: [
        Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              CustomSliverAppBar(
                imageURL: widget.restaurantData.imageURL,
                imageFit: BoxFit.fitWidth,
                id: widget.restaurantData.id,
              ),
              SliverFillRemaining(
                child: DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  slidingBeginOffset: const Offset(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 10.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.restaurantData.name,
                            style: kRestaurantDetailPageHeaderStyle.copyWith(
                                fontSize: 28)),
                        _locationAndContactInfo(),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: _overviewAndPhotos(context, imgs),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SlidingUpScreenWidget(
          isCarouselImages: true,
          panelController: panelController,
          slidingUpWidgetContent: restaurantImagesCarouselSlider(
            context,
            restaurantMealSamplesImages: imgs,
          ),
        ),
      ],
    );
  }

  Column _overviewAndPhotos(BuildContext context, List<String> imgs) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Info',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Color(0XFF424953), fontSize: 18.0),
          ),
          Text(
            widget.restaurantData.overview,
            style: kListTileTextStyle.copyWith(
              fontSize: 16.0,
              height: 1.8,
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: widget.restaurantData.images?.length ?? 0,
              itemBuilder: (context, index) => _buildGridImage(imgs, index),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
            ),
          ),
        ],
      );

  Column _locationAndContactInfo() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Location:',
                  style:
                      kListTileTextStyle.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(width: 5.0),
              _getListDataAndReturnWidget(widget.restaurantData.city)
            ],
          ),
          const SizedBox(height: 12.0),
          Text('Address:',
              style: kListTileTextStyle.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4.0),
          _buildCityOrPhoneWidget(
            textOne: widget.restaurantData.address?.blantyreAddress,
            textTwo: widget.restaurantData.address?.lilongweAddress,
          ),
          const SizedBox(height: 12.0),
          Text('Phone:',
              style: kListTileTextStyle.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4.0),
          _buildCityOrPhoneWidget(
            textOne: widget.restaurantData.phoneNumber?.blantyrePhoneNumber,
            textTwo: widget.restaurantData.phoneNumber?.lilongwePhoneNumber,
          ),
        ],
      );

  Container _buildGridImage(List<String> imgs, int index) => Container(
        width: 40,
        height: 40,
        clipBehavior: Clip.antiAlias,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Container(
          width: 40,
          height: 40,
          child: GestureDetector(
            onTap: () => panelController.expand(),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imgs[index].stripWhiteSpace(),
              placeholder: (context, _) => LoadingIndicatorWidget(
                size: MediaQuery.of(context).size,
              ),
            ),
          ),
        ),
      );

  Widget _getListDataAndReturnWidget(List<dynamic> city) {
    Widget cityWidget;

    if (city.length > 1) {
      cityWidget = _buildTextWidget(textOne: city[0], textTwo: city[1]);
    } else {
      cityWidget = _buildTextWidget(textOne: city[0]);
    }
    return cityWidget;
  }

  Text _buildTextWidget({@required String textOne, String textTwo = ''}) {
    var textValue;
    if (textTwo.isNotEmpty) {
      textValue = '${textOne.sentenceCase()} and ${textTwo.sentenceCase()}';
    } else {
      textValue = '${textOne.sentenceCase()}';
    }
    return Text(
      textValue,
      style: kListTileTextStyle,
    );
  }

  Widget _buildCityOrPhoneWidget({String textOne, String textTwo}) {
    if (textOne.isNotEmpty && textTwo.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextWidget(textOne: textOne),
          _buildTextWidget(textOne: textTwo),
        ],
      );
    } else {
      return textOne.isNotEmpty
          ? _buildTextWidget(textOne: textOne)
          : _buildTextWidget(textOne: textTwo);
    }
  }
}
