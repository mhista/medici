import "package:flutter/material.dart";

import "../constants/colors.dart";
import "custom_themes/appbar_theme.dart";
import "custom_themes/bottom_sheet_theme.dart";
import "custom_themes/checkbox_theme.dart";
import "custom_themes/chip_theme.dart";
import "custom_themes/elevated_button_theme.dart";
import "custom_themes/outlined_button_theme.dart";
import "custom_themes/text_field_theme.dart";
import "custom_themes/text_theme.dart";

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    scrollbarTheme: const ScrollbarThemeData(
        thickness: MaterialStatePropertyAll(0),
        trackColor: MaterialStatePropertyAll(PColors.transparent)),
    fontFamily: 'nunito',
    brightness: Brightness.light,
    primaryColor: PColors.primary,
    scaffoldBackgroundColor: PColors.white,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetThemeData,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    chipTheme: TChipTheme.lightThemeChipTheme,
  );
  static ThemeData darkTheme = ThemeData(
    scrollbarTheme: const ScrollbarThemeData(
        thickness: MaterialStatePropertyAll(0),
        trackColor: MaterialStatePropertyAll(PColors.transparent)),
    fontFamily: 'nunito',
    brightness: Brightness.dark,
    primaryColor: PColors.primary,
    scaffoldBackgroundColor: PColors.black,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    chipTheme: TChipTheme.darkThemeChipTheme,
  );
}
