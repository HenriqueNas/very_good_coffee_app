import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void toggleTheme() {
    final newTheme = state == ThemeMode.light //
        ? ThemeMode.dark
        : ThemeMode.light;

    emit(newTheme);
  }

  ThemeMode get themeMode => state;

  IconData get themeIcon => state == ThemeMode.light //
      ? Icons.dark_mode
      : Icons.light_mode;
}
