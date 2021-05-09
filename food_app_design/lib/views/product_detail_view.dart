import 'dart:ui';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../constants/asset_constants.dart';
import '../constants/color_constants.dart';
import '../constants/size_constants.dart';
import '../extensions/size_extension.dart';
import '../extensions/theme_extension.dart';
import '../widgets/product_detail_info_card_widget.dart';
import '../widgets/product_ingredient_card_widget.dart';

class ProductDetailView extends StatelessWidget {
  final faker = Faker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: context.dynamicHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            blurryBackground(context),
            Positioned.fill(
              top: context.dynamicHeight * 0.4,
              child: buildBackground(context),
            ),
            Positioned(
              bottom: context.dynamicHeight * 0.6 - context.dynamicHeight * 0.06,
              child: buildProductCounter(context),
            ),
            Positioned(
              bottom: 0,
              child: buildFloatingButton(context),
            ),
            Positioned(
              top: 16,
              width: context.dynamicWidth,
              height: context.dynamicHeight * 0.4,
              child: productImage(context),
            ),
            Positioned(
              width: context.dynamicWidth,
              top: 0,
              child: appBar(context),
            ),
          ],
        ),
      ),
    ));
  }

  appBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: context.horizontalPaddingLow,
              child: CircleAvatar(
                backgroundColor: ColorConstants.instance.backgroundWhite,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: context.horizontalPaddingLow,
              child: CircleAvatar(
                backgroundColor: ColorConstants.instance.backgroundWhite,
                child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  blurryBackground(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Expanded(
          flex: 6,
          child: productImageBlurry(context),
        ),
        Spacer(
          flex: 12,
        )
      ],
    );
  }

  productImageBlurry(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            "https://www.nicepng.com/png/full/21-211113_sweet-spicy-chicken-spicy-chicken-wings-png.png",
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 128, sigmaY: 128),
        child: Container(
          decoration: BoxDecoration(color: ColorConstants.instance.backgroundWhite.withOpacity(0)),
        ),
      ),
    );
  }

  productImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
              "https://www.nicepng.com/png/full/21-211113_sweet-spicy-chicken-spicy-chicken-wings-png.png",
            ),
            fit: BoxFit.fitWidth),
      ),
    );
  }

  buildProductCounter(BuildContext context) {
    return Container(
      width: context.dynamicWidth * 0.25,
      height: context.dynamicHeight * 0.06,
      decoration: BoxDecoration(
        borderRadius: context.borderRadiusHorizontalMedium,
        color: Colors.yellow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: IconButton(
              splashColor: Colors.red,
              onPressed: () {},
              icon: Icon(Icons.remove),
            ),
          ),
          Flexible(
            child: Text(
              "1",
              style: context.textTheme.headline6,
            ),
          ),
          Flexible(
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  buildBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeConstants.instance.valueMedium), topRight: Radius.circular(SizeConstants.instance.valueMedium)),
        color: ColorConstants.instance.backgroundWhite,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: buildDetailNameAndPrice(context),
          ),
          Expanded(
            flex: 2,
            child: buildProductInfo(context),
          ),
          Expanded(
            flex: 4,
            child: buildProductDetailText(context),
          ),
          Expanded(
            flex: 4,
            child: buildProductIngredients(context),
          )
        ],
      ),
    );
  }

  buildDetailNameAndPrice(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConstants.instance.valueMedium, right: SizeConstants.instance.valueMedium, top: SizeConstants.instance.valueMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Spicy Chicken\nDimsum",
            style: context.textTheme.headline6,
          ),
          Text(
            "\$ 6.99",
            style: context.textTheme.headline6,
          ),
        ],
      ),
    );
  }

  buildProductInfo(BuildContext context) {
    return Padding(
      padding: context.paddingAllLow,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: context.dynamicHeight * 0.05,
          maxWidth: context.dynamicWidth * 0.8,
          minWidth: 1,
          minHeight: 1,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: ProductDetailInfoCardWidget(
                assetImagePath: AssetConstants.ICON_PRODUCT_PATH + 'favourites.png',
                text: '4.5',
              ),
            ),
            Expanded(
              flex: 7,
              child: ProductDetailInfoCardWidget(
                assetImagePath: AssetConstants.ICON_PRODUCT_PATH + 'flame.png',
                text: '68 Calories',
              ),
            ),
            Expanded(
              flex: 6,
              child: ProductDetailInfoCardWidget(
                assetImagePath: AssetConstants.ICON_PRODUCT_PATH + 'alarm-clock.png',
                text: '20-30 min',
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildProductDetailText(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingMedium,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: FittedBox(
              child: Text("Details", style: context.textTheme.bodyText1),
            ),
          ),
          Spacer(),
          Flexible(
              flex: 4,
              child: Text(
                faker.lorem.sentences(3).toString(),
                style: context.textTheme.caption,
              ))
        ],
      ),
    );
  }

  buildProductIngredients(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConstants.instance.valueMedium, left: SizeConstants.instance.valueMedium, bottom: SizeConstants.instance.valueMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: FittedBox(
              child: Text("Ingredients", style: context.textTheme.bodyText1),
            ),
          ),
          Spacer(),
          Flexible(
            flex: 3,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int i = 0; i < 2; i++) ...[
                    ProductIngredientCardWidget(
                      imagePath: AssetConstants.ICON_PRODUCT_PATH + 'meat.png',
                    ),
                    context.sizedBoxHorizontalMedium,
                    ProductIngredientCardWidget(
                      imagePath: AssetConstants.ICON_PRODUCT_PATH + 'broccoli.png',
                    ),
                    context.sizedBoxHorizontalMedium,
                    ProductIngredientCardWidget(
                      imagePath: AssetConstants.ICON_PRODUCT_PATH + 'onion.png',
                    ),
                    context.sizedBoxHorizontalMedium,
                    ProductIngredientCardWidget(
                      imagePath: AssetConstants.ICON_PRODUCT_PATH + 'cabbage.png',
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildFloatingButton(BuildContext context) {
    return Padding(
      padding: context.paddingOnlyBottomMedium,
      child: FloatingActionButton(
        shape: StadiumBorder(side: BorderSide(color: ColorConstants.instance.backgroundWhite, width: 2)),
        backgroundColor: Colors.yellow, // Temadan verilebilir
        child: Icon(
          Icons.add,
          color: Colors.black, // Temadan verilebilir
        ),
        onPressed: () {},
      ),
    );
  }
}
