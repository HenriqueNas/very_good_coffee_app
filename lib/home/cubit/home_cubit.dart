import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/home/home.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required CoffeeRepository coffeeRepository,
    required LikedCoffeesCubit likedCoffeesCubit,
  })  : _coffeeRepository = coffeeRepository,
        _likedCoffeesCubit = likedCoffeesCubit,
        super(HomeState.idle);

  final CoffeeRepository _coffeeRepository;
  final LikedCoffeesCubit _likedCoffeesCubit;

  final swiperController = CardSwiperController();

  Future<void> loadInitialCoffeeImages() async {
    emit(HomeState.loading);
    try {
      final coffeeImages = await _coffeeRepository.getListOfCoffeeImages();

      final coffees = coffeeImages //
          .map(CoffeeModel.fromImageUrl)
          .toList();

      emit(HomeState.success(coffees));
    } catch (error) {
      emit(HomeState.error(error.toString()));
    }
  }

  bool onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    try {
      if (!state.isSuccess) return false;

      final coffee = (state as HomeSuccess).coffees[previousIndex];

      rateCoffee(coffee, direction.toCoffeeRating());

      return true;
    } catch (error) {
      if (kDebugMode) {
        log(
          'Error on swipe: previousIndex: $previousIndex, '
          'currentIndex: $currentIndex, direction: $direction',
          name: 'HomeController',
          error: error,
        );
      }
      return true;
    }
  }

  void rateCoffee(CoffeeModel coffee, CoffeeRating newRating) {
    if (!state.isSuccess) return;

    final updatedCoffee = CoffeeModel(
      id: coffee.id,
      rating: newRating,
      imageUrl: coffee.imageUrl,
    );

    if (newRating.isLike) _likedCoffeesCubit.addCoffee(updatedCoffee);

    final currentCoffees = (state as HomeSuccess).coffees;
    currentCoffees[currentCoffees.indexOf(coffee)] = updatedCoffee;

    addNewCoffeeToStack();
  }

  Future<void> addNewCoffeeToStack() async {
    if (!state.isSuccess) return;
    final currentCoffees = (state as HomeSuccess).coffees;

    try {
      final coffeeImage = await _coffeeRepository.getCoffeeImage();
      final newCoffee = CoffeeModel.fromImageUrl(coffeeImage);

      final updatedCoffees = [...currentCoffees, newCoffee];
      HomeState.success(updatedCoffees);
      emit(HomeState.success(updatedCoffees));
    } catch (error) {
      emit(HomeState.error(error.toString()));
    }
  }

  void likeCoffee() => swiperController.swipe(CardSwiperDirection.right);

  void dislikeCoffee() => swiperController.swipe(CardSwiperDirection.left);
}

extension on CardSwiperDirection {
  CoffeeRating toCoffeeRating() {
    switch (this) {
      case CardSwiperDirection.left:
        return CoffeeRating.dislike;
      case CardSwiperDirection.right:
        return CoffeeRating.like;
      case CardSwiperDirection.none:
      case CardSwiperDirection.top:
      case CardSwiperDirection.bottom:
        return CoffeeRating.none;
    }
  }
}
