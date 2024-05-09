import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/favorites/view/view.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage() : super(key: const Key('favorites_page'));

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      key: const Key('home_page:provider'),
      value: context.read<LikedCoffeesCubit>(),
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatefulWidget {
  const FavoritesView() : super(key: const Key('favorites_page:view'));

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final coffeeCubit = context.watch<LikedCoffeesCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appBarTitle),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            padding: const EdgeInsets.only(right: 24),
            onPressed: () {
              if (coffeeCubit.likedCoffees.isEmpty) return;
              ClearListDialog.open(context);
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          final coffees = coffeeCubit.state.toSet().toList();

          if (coffees.isEmpty) {
            return Center(
              key: const Key('favorites_page:empty'),
              child: Text(l10n.emptyCoffeeList),
            );
          }

          return ListView.separated(
            key: const Key('favorites_page:list'),
            itemCount: coffees.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            padding: const EdgeInsets.all(24),
            itemBuilder: (_, index) {
              final coffee = coffees[index];

              return CoffeeListTile(
                coffee: coffee,
                onRemoveCoffee: coffeeCubit.removeCoffee,
              );
            },
          );
        },
      ),
    );
  }
}
