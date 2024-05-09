import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/favorites/view/view.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FavoritesView();
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final likedCoffeesCubit = context.watch<LikedCoffeesCubit>();
    final likedCoffeeList = likedCoffeesCubit.likedCoffees;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appBarTitle),
        leading: const BackButton(),
      ),
      body: likedCoffeeList.isEmpty
          ? Center(child: Text(l10n.favoritesEmptyList))
          : ListView.separated(
              itemCount: likedCoffeeList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              padding: const EdgeInsets.all(24),
              itemBuilder: (_, index) {
                final coffee = likedCoffeeList[index];

                return CoffeeListTile(
                  coffee: coffee,
                  onRemoveCoffee: () => likedCoffeesCubit.removeCoffee(coffee),
                );
              },
            ),
    );
  }
}
