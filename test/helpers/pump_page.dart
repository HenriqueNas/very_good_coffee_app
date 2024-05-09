import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

extension PumpPage on WidgetTester {
  Future<void> pumpPage(Widget widget, {LikedCoffeesCubit? likedCoffeesCubit}) {
    return pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => likedCoffeesCubit ?? LikedCoffeesCubit()),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: widget,
        ),
      ),
    );
  }
}
