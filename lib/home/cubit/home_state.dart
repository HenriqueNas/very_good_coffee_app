// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:flutter/foundation.dart';
import 'package:very_good_coffee_app/app/data/models/coffee_model.dart';

sealed class HomeState {
  const HomeState();

  factory HomeState.error(String message) => HomeError(message);
  factory HomeState.success(List<CoffeeModel> coffees) => HomeSuccess(coffees);

  static const HomeIdle idle = HomeIdle();
  static const HomeLoading loading = HomeLoading();

  bool get isLoading => this is HomeLoading;
  bool get isSuccess => this is HomeSuccess;
  bool get isError => this is HomeError;
}

class HomeIdle extends HomeState {
  const HomeIdle();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeIdle;
  }

  @override
  int get hashCode => 0;
}

class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeLoading;
  }

  @override
  int get hashCode => 1;
}

class HomeSuccess extends HomeState {
  const HomeSuccess(this.coffees);

  final List<CoffeeModel> coffees;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeSuccess && listEquals(other.coffees, coffees);
  }

  @override
  int get hashCode => coffees.hashCode;

  @override
  String toString() {
    final indexedCoffeesMap = coffees.indexed;

    return indexedCoffeesMap.map((value) {
      final (index, coffee) = value;

      final rating = coffee.rating;
      final id = coffee.id;

      return 'index: $index, rating: $rating, id: $id';
    }).join('\n');
  }
}

class HomeError extends HomeState {
  const HomeError(this.message);

  final String message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HomeError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
