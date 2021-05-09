import 'package:flutter/material.dart';

import '../constants/size_constants.dart';

extension SizeExtension on BuildContext {
  double get dynamicHeight => MediaQuery.of(this).size.height;
  double get dynamicWidth => MediaQuery.of(this).size.width;

  EdgeInsets get horizontalPaddingLow => EdgeInsets.symmetric(horizontal: SizeConstants.instance.valueLow);
  EdgeInsets get horizontalPaddingMedium => EdgeInsets.symmetric(horizontal: SizeConstants.instance.valueMedium);
  EdgeInsets get horizontalPaddingHigh => EdgeInsets.symmetric(horizontal: SizeConstants.instance.valueHigh);

  EdgeInsets get veritcalPaddingLow => EdgeInsets.symmetric(vertical: SizeConstants.instance.valueLow);
  EdgeInsets get veritcalPaddingMedium => EdgeInsets.symmetric(vertical: SizeConstants.instance.valueMedium);
  EdgeInsets get veritcalPaddingHigh => EdgeInsets.symmetric(vertical: SizeConstants.instance.valueHigh);

  EdgeInsets get paddingOnlyRightLow => EdgeInsets.only(right: SizeConstants.instance.valueLow);
  EdgeInsets get paddingOnlyRightMedium => EdgeInsets.only(right: SizeConstants.instance.valueMedium);
  EdgeInsets get paddingOnlyRightHigh => EdgeInsets.only(right: SizeConstants.instance.valueHigh);

  EdgeInsets get paddingOnlyLeftLow => EdgeInsets.only(left: SizeConstants.instance.valueLow);
  EdgeInsets get paddingOnlyLeftMedium => EdgeInsets.only(left: SizeConstants.instance.valueMedium);
  EdgeInsets get paddingOnlyLeftHigh => EdgeInsets.only(left: SizeConstants.instance.valueHigh);

  EdgeInsets get paddingOnlyBottomLow => EdgeInsets.only(bottom: SizeConstants.instance.valueLow);
  EdgeInsets get paddingOnlyBottomMedium => EdgeInsets.only(bottom: SizeConstants.instance.valueMedium);
  EdgeInsets get paddingOnlyBottomHigh => EdgeInsets.only(bottom: SizeConstants.instance.valueHigh);

  EdgeInsets get paddingAllLow => EdgeInsets.all(SizeConstants.instance.valueLow);
  EdgeInsets get paddingAllMedium => EdgeInsets.all(SizeConstants.instance.valueMedium);
  EdgeInsets get paddingAllHigh => EdgeInsets.all(SizeConstants.instance.valueHigh);

  Widget get sizedBoxHorizontalLow => SizedBox(width: this.dynamicWidth * 0.01);
  Widget get sizedBoxHorizontalMedium => SizedBox(width: this.dynamicWidth * 0.02);
  Widget get sizedBoxHorizontalHigh => SizedBox(width: this.dynamicWidth * 0.04);

  BorderRadius get borderRadiusHorizontalLow =>
      BorderRadius.horizontal(left: Radius.circular(SizeConstants.instance.valueLow), right: Radius.circular(SizeConstants.instance.valueLow));
  BorderRadius get borderRadiusHorizontalMedium =>
      BorderRadius.horizontal(left: Radius.circular(SizeConstants.instance.valueMedium), right: Radius.circular(SizeConstants.instance.valueMedium));
  BorderRadius get borderRadiusHorizontalHigh =>
      BorderRadius.horizontal(left: Radius.circular(SizeConstants.instance.valueHigh), right: Radius.circular(SizeConstants.instance.valueHigh));

  BorderRadius get borderRadiusAllLow => BorderRadius.all(Radius.circular(SizeConstants.instance.valueLow));
  BorderRadius get borderRadiusAllMedium => BorderRadius.all(Radius.circular(SizeConstants.instance.valueMedium));
  BorderRadius get borderRadiusAllHigh => BorderRadius.all(Radius.circular(SizeConstants.instance.valueHigh));
}
