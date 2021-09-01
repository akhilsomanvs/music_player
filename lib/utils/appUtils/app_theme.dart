import 'package:flutter/material.dart';
import 'package:music_player/utils/commonUtils/size_config.dart';

class AppTheme {
  static _AppColors appColors = _AppColors();
  static _AppTextThemes textThemes = _AppTextThemes(primaryTextColor: appColors.primaryTextColor);
  static _AppShapes appShapes = _AppShapes();

  static double get borderRadius => appShapes.borderRadius;

  static double get dialogBorderRadius => appShapes.dialogBorderRadius;
  static Shadow appLogoTextShadow = Shadow(color: Colors.black, blurRadius: 4.0, offset: Offset(0, 4));
}

//region AppColors
class _AppColors {
  //region App Primary Color
  Color appPrimaryColorRed = Color(0xFFE12026);
  Color appPrimaryColorWhite = Color(0xFFFFFFFF);
  Color pageBackground = Color(0xFFF9F9F9);
  Color appPinkColor = Color(0xFFFFE9E9);
  Color appBlackColor = Color(0xFF2E353A);
  Color appLightGreen = Color(0xFF92E3A9);
  Color appGrey = Color(0xFFEEEEEE);
  Color textFieldBorder = Color(0xFFADADAD);
  Color focusedTextFieldBorder = Color(0xFF92E3A9);

  //endregion
  //region Text Colors
  Color primaryTextColor = Color(0xFF242E42);
  Color secondaryTextColor = Color(0xFF706A6A);
  Color blackTextColor = Color(0xFF4B4B4B);
  Color disabledTextColor = Color(0xFFCFCFCF);
  Color hintTextColor = Color(0xFFCFCFCF);
  Color greyTextColor = Color(0xFF8E8E8E);
  Color greenTextColor = Color(0xFF75B687);

  //endregion
  //region Button Colors
  Color enabledButtonColor = Color(0xFF2E353A);
  Color disabledButtonColor = Color(0xFFB8B8B8);
//endregion
}
//endregion

//region Text Themes
class _AppTextThemes {
  static const String _fontFamily = "Poppins";
  late TextStyle _textStyle;

  ///Commonly used text style in the app.

  // late TextStyle subtitle1;
  // late TextStyle subtitle2;
  // late TextStyle bodyText1;
  // late TextStyle bodyText2;
  // late TextStyle headline1;
  // late TextStyle headline2;
  // late TextStyle headline3;
  late TextStyle subtitle1 = _textStyle.copyWith(fontSize: SizeConfig.getTextSize(8), fontWeight: FontWeight.normal);
  late TextStyle subtitle2 = _textStyle.copyWith(fontSize: SizeConfig.getTextSize(10), fontWeight: FontWeight.normal);
  late TextStyle bodyText1 = _textStyle.copyWith(fontSize: SizeConfig.getTextSize(12), fontWeight: FontWeight.normal);
  late TextStyle bodyText2 = _textStyle.copyWith(fontSize: SizeConfig.getTextSize(14), fontWeight: FontWeight.normal);
  late TextStyle headline1 = _textStyle.copyWith(fontSize: SizeConfig.getTextSize(14), fontWeight: FontWeight.bold);
  late TextStyle headline2 = _textStyle.copyWith(fontSize: SizeConfig.getTextSize(16), fontWeight: FontWeight.bold);
  late TextStyle headline3 = _textStyle.copyWith(fontSize: SizeConfig.getTextSize(22), fontWeight: FontWeight.bold);
  late TextStyle headline4 = _textStyle.copyWith(fontSize: SizeConfig.getTextSize(30), fontWeight: FontWeight.bold);

  // late TextStyle primaryTextStyle = bodyText2;

  Color primaryTextColor;

  _AppTextThemes({required this.primaryTextColor}) {
    _textStyle = TextStyle(fontFamily: _fontFamily, color: this.primaryTextColor, height: 1);
    /*subtitle1 = _textStyle.copyWith(fontSize: 10.sp, fontWeight: FontWeight.normal);
    subtitle2 = _textStyle.copyWith(fontSize: 12.sp, fontWeight: FontWeight.normal);
    bodyText1 = _textStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal);
    bodyText2 = _textStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.normal);
    headline1 = _textStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold);
    headline2 = _textStyle.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold);
    headline3 = _textStyle.copyWith(fontSize: 24.sp, fontWeight: FontWeight.bold);
    headline4 = _textStyle.copyWith(fontSize: 32.sp, fontWeight: FontWeight.bold);
    primaryTextStyle = bodyText2;*/
  }
}
//endregion

//region App backgrounds
class _AppShapes {
  static const double _borderRadius = 8;
  static const double _dialogBorderRadius = 16;

  double get dialogBorderRadius => _dialogBorderRadius;

  double get borderRadius => _borderRadius;

  RoundedRectangleBorder cardShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius));
}
//endregion
