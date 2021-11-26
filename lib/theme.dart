
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme({bool dark = false}) {
  final base = ThemeData(
      primaryColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'SFUIText',
      brightness: dark ? Brightness.dark : Brightness.light);
  return base.copyWith(
    backgroundColor: dark ? Color(0xFF343433) : Color(0xFFFCFCFC),
    dividerColor: dark ? ThemeColors.grey595959 : ThemeColors.greyDEDEDE,
    textTheme: base.textTheme.copyWith(
      bodyText1: base.textTheme.bodyText1!.copyWith(
          fontSize: 20,
          color: dark ? Color(0xFFDDDDDD) : ThemeColors.grey414747,
          fontWeight: FontWeight.normal),
      bodyText2: base.textTheme.bodyText1!.copyWith(
        // fontSize: 24,
        color: dark ? Color(0xFFDDDDDD) : Color(0xFF414747),
      ),
      caption: base.textTheme.caption!.copyWith(
        fontSize: 20,
        color: dark ? ThemeColors.greyABABAB : ThemeColors.grey595959,
      ),
    ),
    iconTheme: base.iconTheme.copyWith(
      color: ThemeColors.appBarIconColor,
    ),
    buttonTheme: base.buttonTheme.copyWith(),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: Color(0xFF202023),
      // primaryColor: Color(0xFF027CFE),
    ),
    scrollbarTheme: ScrollbarThemeData().copyWith(
      thumbColor: MaterialStateProperty.all(ThemeColors.grey414747),
    ),
  );
}

class AppStyles {
  static TextStyle titleStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          );

  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ThemeColors.backgroundGrey
          : ThemeColors.greyEEEEEE;

  static Color textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ThemeColors.greyDEDEDE
          : ThemeColors.grey2E3235;

  static Color appBarColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ThemeColors.grey2E2E2E
          : ThemeColors.greyF7F7F7;
}

class ThemeColors {
  static Color backgroundGrey = Color(0xFF2E3235);
  static Color textGrey = Color(0xFFBCBCC0);
  static Color appBarIconColor = Color(0xFFC2C2C2);
  static Color grey414747 = Color(0xFF414747);
  static Color greyB2B2B2 = Color(0xFFB2B2B2);
  static Color greyC2C2C2 = Color(0xFFC2C2C2);
  static Color grey222222 = Color(0xFF222222);
  static Color grey2E2E2E = Color(0xFF2E2E2E);
  static Color grey2E3235 = Color(0xFF2E3235);
  static Color greyBCBCCO = Color(0xFFBCBCC0);
  static Color grey808082 = Color(0xFF808082);
  static Color grey595959 = Color(0xFF595959);
  static Color grey9B9B9B = Color(0xFF9B9B9B);
  static Color greyDBDADE = Color(0xFFDBDADE);
  static Color greyABABAB = Color(0xFFABABAB);
  static Color greyDEDEDE = Color(0xFFDEDEDE);
  static Color greyECECEC = Color(0xFFECECEC);
  static Color grey212428 = Color(0xFF212428);
  static Color greyEEEEEE = Color(0xFFEFEFEF);
  static Color greyF7F7F7 = Color(0xFFF7F7F7);
  static Color greyA7B0B3 = Color(0xFFA7B0B3);

  static Color blue027CFE = Color(0xFF027CFE);

  static Color redDD4C4F = Color(0xFFDD4C4F);

  static Color grey4A5151 = Color(0xFF4A5151);

  static var pinkFFB1AC = Color(0xFFFFB1AC);

  static var greyAAA7AA = Color(0xFFAAA7AA);

  static var blue007AFF = Color(0xFF007AFF);

  static var blue4681D2 = Color(0xFF4681D2);

  static var blueC9E8E2 = Color(0xFFC9E8E2);

  static var pinkF6DACC = Color(0xFFF6DACC);
  static var pinkB2552D = Color(0xFFB2552D);

  static var redFE3D2F = Color(0xFFFe3D2F);

  static var goldCB8355 = Color(0xFFC09138);

  static Color saveText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ThemeColors.grey595959
          : ThemeColors.grey414747;

  static segmented(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? grey222222 : grey414747;

  static pill(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? greyABABAB : grey808082;

  static pillBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? grey414747 : greyDEDEDE;

// Translucent, very light gray that is painted on top of the blurred backdrop
// as the action sheet's background color.
// TODO(LongCatIsLooong): https://github.com/flutter/flutter/issues/39272. Use
// System Materials once we have them.
// Extracted from https://developer.apple.com/design/resources/.
  static const Color actionBackgroundColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xC7F9F9F9),
    darkColor: Color(0xC7252525),
  );
}
