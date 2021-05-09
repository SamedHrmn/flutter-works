import 'package:flutter/material.dart';
import '../extensions/size_extension.dart';
import '../extensions/theme_extension.dart';

import '../constants/color_constants.dart';
import '../constants/size_constants.dart';

class CategoriesItemWidget extends StatelessWidget {
  final String categoryImagePath;
  final String categoryName;

  const CategoriesItemWidget({Key key, @required this.categoryImagePath, @required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.2,
        maxWidth: MediaQuery.of(context).size.width * 0.32,
      ),
      child: Container(
        padding: context.paddingAllLow,
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.instance.iconBackgroundColor),
          borderRadius: BorderRadius.circular(SizeConstants.instance.valueLow),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                categoryImagePath,
                fit: BoxFit.cover,
              ),
            ),
            Spacer(),
            Flexible(
              flex: 6,
              child: Text(
                categoryName,
                style: context.textTheme.bodyText2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
