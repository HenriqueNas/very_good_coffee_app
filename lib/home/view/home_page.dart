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
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = context.read<HomeCubit>();
  }

  @override
  void initState() {
    super.initState();

    cubit = context.read<HomeCubit>();
    cubit.loadInitialCoffeeImages();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.appBarTitle),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              AppRoutes.favorites,
            ),
            icon: const Icon(
              Icons.bookmark_added,
              color: Colors.green,
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
              child: Text(l10n.favoritesEmptyList),
            );
          }

          final coffees = (state as HomeSuccess).coffees;

          if (coffees.isEmpty) {
            return Center(
              key: const Key('home_page:empty_list'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.favoritesEmptyList),
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

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: CardSwiper(
                    key: const Key('home_page:card_swiper'),
                    numberOfCardsDisplayed: 3,
                    controller: cubit.swiperController,
                    cardsCount: coffees.length,
                    onSwipe: cubit.onSwipe,
                    allowedSwipeDirection:
                        const AllowedSwipeDirection.symmetric(
                      horizontal: true,
                    ),
                    cardBuilder: (_, index, __, ___) => CoffeeCard(
                      coffee: coffees[index],
                    ),
                  ),
                ),
                Flexible(
                  child: RatingButtons(
                    onLike: cubit.likeCoffee,
                    onDislike: cubit.dislikeCoffee,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
