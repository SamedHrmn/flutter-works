import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../constants/asset_constants.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../extensions/size_extension.dart';
import '../widgets/categories_item_widget.dart';
import '../widgets/product_item_widget.dart';
import 'product_detail_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: curvedNavBar(context),
      body: Container(
        height: context.dynamicHeight,
        child: Padding(
          padding: context.paddingAllMedium,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: appBar(context),
              ),
              Expanded(
                flex: 2,
                child: headerStringPart(context),
              ),
              Spacer(),
              Expanded(
                flex: 2,
                child: searchPart(context),
              ),
              Spacer(),
              Expanded(
                flex: 2,
                child: categoriesPart(context),
              ),
              Spacer(),
              Expanded(
                flex: 14,
                child: productPart(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  productPart(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true, enlargeCenterPage: true, viewportFraction: 0.5, height: context.dynamicHeight * 0.4),
      items: [
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailView(),
              )),
          child: ProductSliderItemWidget(
            imagePath: "https://assets.bonappetit.com/photos/589df16c476e2c92337165b5/1:1/w_2560%2Cc_limit/bucatini-with-lemony-carbonara.jpg",
            productName: "Egg Pasta",
            productText: "Delicious",
            priceText: "9.50",
          ),
        )
      ],
    );
  }

  categoriesPart(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < 2; i++) ...[
            CategoriesItemWidget(
              categoryImagePath: AssetConstants.ICON_CATEGORY_PATH + "burger.png",
              categoryName: "Fast Food",
            ),
            context.sizedBoxHorizontalHigh,
            CategoriesItemWidget(
              categoryImagePath: AssetConstants.ICON_CATEGORY_PATH + "fruits.png",
              categoryName: "Fruits",
            ),
            context.sizedBoxHorizontalHigh,
            CategoriesItemWidget(
              categoryImagePath: AssetConstants.ICON_CATEGORY_PATH + "vegetables.png",
              categoryName: "Vegetables",
            ),
            context.sizedBoxHorizontalHigh
          ]
        ],
      ),
    );
  }

  searchPart(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 10,
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.instance.navbarBackgroundColor,
              borderRadius: context.borderRadiusAllHigh,
            ),
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none, prefixIcon: Icon(Icons.search_outlined), contentPadding: context.paddingAllLow),
            ),
          ),
        ),
        Spacer(),
        Expanded(
          flex: 2,
          child: Container(
            padding: context.paddingAllMedium,
            decoration: BoxDecoration(color: ColorConstants.instance.iconBackgroundColor, borderRadius: context.borderRadiusAllMedium),
            child: Icon(Icons.filter_alt_outlined),
          ),
        )
      ],
    );
  }

  headerStringPart(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: FittedBox(
        child: Text(
          StringConstants.HOME_HEADER_STRING,
          style: Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.more_vert),
          ),
        ),
        Expanded(
          child: Padding(
            padding: context.veritcalPaddingMedium,
            child: Container(
              decoration: BoxDecoration(
                color: ColorConstants.instance.iconBackgroundColor,
                borderRadius: context.borderRadiusAllMedium,
                image: DecorationImage(
                    image: AssetImage(AssetConstants.ICON_USER_PATH + "avatar.png"), fit: BoxFit.contain, alignment: Alignment.bottomCenter),
              ),
            ),
          ),
        )
      ],
    );
  }

  curvedNavBar(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: ColorConstants.instance.navbarBackgroundColor,
      buttonBackgroundColor: ColorConstants.instance.iconBackgroundColor,
      items: [
        Icon(Icons.home_outlined),
        Icon(Icons.chrome_reader_mode_outlined),
        Icon(Icons.shopping_bag_outlined),
        Icon(Icons.bookmark_border),
        Icon(Icons.notifications_outlined)
      ],
      onTap: (index) {},
    );
  }
}
