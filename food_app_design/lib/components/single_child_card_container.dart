import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../extensions/size_extension.dart';

class CardContainerSingleChild extends StatelessWidget {
  final Widget widget;

  const CardContainerSingleChild({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxWidth: context.dynamicWidth * 0.2,
          maxHeight: context.dynamicHeight * 0.1,
          minHeight: context.dynamicHeight * 0.1,
          minWidth: context.dynamicWidth * 0.1),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: context.borderRadiusHorizontalMedium,
            border: Border.all(
              color: ColorConstants.instance.navbarBackgroundColor,
            )),
        child: Padding(
          padding: context.paddingAllLow,
          child: widget,
        ),
      ),
    );
  }
}
