import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/home/home.dart';
import 'package:very_good_coffee_app/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: const Key('home_page:provider'),
      create: (_) => HomeCubit(
        coffeeRepository: CoffeeRepository(),
        likedCoffeesCubit: context.read<LikedCoffeesCubit>(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView() : super(key: const Key('home_page:view'));

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeCubit cubit;

  @override
  void initState() {
    super.initState();

    cubit = context.read<HomeCubit>();
    cubit.loadInitialCoffeeImages();
  }

  void toggleTheme() => context.read<ThemeCubit>().toggleTheme();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    cubit = context.watch<HomeCubit>();
    final themeIcon = context.watch<ThemeCubit>().themeIcon;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.appBarTitle),
        leading: IconButton(
          onPressed: toggleTheme,
          icon: Icon(themeIcon),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              AppRoutes.favorites,
            ),
            padding: const EdgeInsets.only(right: 24),
            icon: const Icon(
              Icons.bookmark_added,
              size: 28,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is HomeIdle || state is HomeLoading) {
            return const LoadingCoffee();
          } else if (state is HomeError) {
            if (kDebugMode) log(state.message, name: 'HomePage');

            return Center(
              key: const Key('home_page:error'),
              child: Text(l10n.emptyCoffeeList),
            );
          }

          if (cubit.coffeeList.isEmpty) {
            return Center(
              key: const Key('home_page:empty_list'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.emptyCoffeeList),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: cubit.loadInitialCoffeeImages,
                    icon: const Icon(Icons.refresh),
                    label: const Text('l10n.refreshButton'),
                  ),
                ],
              ),
            );
          }

          return CardSwiper(
            key: const Key('home_page:card_swiper'),
            numberOfCardsDisplayed: 3,
            controller: cubit.swiperController,
            cardsCount: cubit.coffeeList.length,
            onSwipe: cubit.onSwipe,
            onUndo: cubit.onUndoSwipe,
            padding: const EdgeInsets.all(24),
            allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
              horizontal: true,
            ),
            cardBuilder: (_, index, __, ___) => CoffeeCard(
              coffee: cubit.coffeeList[index],
            ),
          );
        },
      ),
      floatingActionButton: cubit.state.isSuccess
          ? RatingButtons(
              onLike: cubit.likeCoffee,
              onDislike: cubit.dislikeCoffee,
              onUndo: cubit.swiperController.undo,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
