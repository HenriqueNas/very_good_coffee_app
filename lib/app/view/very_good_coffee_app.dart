import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/favorites/view/view.dart';
import 'package:very_good_coffee_app/home/view/home_page.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class VeryGoodCoffeeApp extends StatelessWidget {
  const VeryGoodCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LikedCoffeesCubit(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (_) => const HomePage(),
          AppRoutes.favorites: (_) => const FavoritesPage(),
        },
      ),
    );
  }
}
