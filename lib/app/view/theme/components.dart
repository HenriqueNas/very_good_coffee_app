import 'package:flutter/material.dart';

ElevatedButtonThemeData elevatedButton(ColorScheme colors) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateColor.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? colors.surface
            : colors.primaryContainer,
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      foregroundColor: MaterialStateProperty.all(colors.onPrimaryContainer),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
    ),
  );
}

FloatingActionButtonThemeData floatingActionButton(ColorScheme colors) {
  return FloatingActionButtonThemeData(
    foregroundColor: colors.onPrimary,
    backgroundColor: colors.primary,
  );
}

IconButtonThemeData iconButton(ColorScheme colors) {
  return IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(colors.primary),
    ),
  );
}

AppBarTheme appBar(ColorScheme colors) {
  return AppBarTheme(
    backgroundColor: colors.inversePrimary,
    foregroundColor: colors.background,
    iconTheme: IconThemeData(
      color: colors.background,
    ),
  );
}
