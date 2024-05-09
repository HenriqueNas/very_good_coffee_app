import 'package:flutter/material.dart';
import 'package:very_good_coffee_app/app/view/theme/theme.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  appBarTheme: appBar(lightColorScheme),
  iconButtonTheme: iconButton(lightColorScheme),
  elevatedButtonTheme: elevatedButton(lightColorScheme),
  floatingActionButtonTheme: floatingActionButton(lightColorScheme),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: lightColorScheme.primary,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  appBarTheme: appBar(darkColorScheme),
  iconButtonTheme: iconButton(lightColorScheme),
  elevatedButtonTheme: elevatedButton(darkColorScheme),
  floatingActionButtonTheme: floatingActionButton(darkColorScheme),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: darkColorScheme.primary,
  ),
);
