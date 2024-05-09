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
    final themeCubit = ThemeCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => themeCubit),
        BlocProvider(create: (_) => LikedCoffeesCubit()),
      ],
      child: BlocBuilder(
        bloc: themeCubit,
        builder: (context, state) => MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeCubit.themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          initialRoute: AppRoutes.home,
          routes: {
            AppRoutes.home: (_) => const HomePage(),
            AppRoutes.favorites: (_) => const FavoritesPage(),
          },
        ),
      ),
    );
  }
}
