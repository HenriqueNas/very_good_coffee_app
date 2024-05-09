import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  late HomeCubit homeCubit;

  setUpAll(DependenciesInjector.initDependencies);

  setUp(() {
    homeCubit = HomeCubit(
      coffeeRepository: CoffeeRepository(),
      likedCoffeesCubit: LikedCoffeesCubit(),
    );
  });

  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] when loadInitialCoffeeImages is called',
      build: () => homeCubit,
      act: (cubit) => cubit.loadInitialCoffeeImages(),
      expect: () {
        final coffeeUrl = DependenciesInjector.httpClient.fileUrl;
        final expectedCoffeeList = List.generate(
          kDefaultCoffeeListSize,
          (_) => CoffeeModel.fromImageUrl(coffeeUrl),
        );

        return [
          HomeState.loading,
          HomeState.success(expectedCoffeeList),
        ];
      },
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] when onSwipe is called with direction left',
      build: () => homeCubit,
      act: (cubit) async {
        await cubit.loadInitialCoffeeImages();
        return cubit.onSwipe(0, 1, CardSwiperDirection.left);
      },
      expect: () {
        final coffeeUrl = DependenciesInjector.httpClient.fileUrl;

        final unratedCoffee = CoffeeModel.fromImageUrl(coffeeUrl);

        final dislikedCoffee = CoffeeModel(
          imageUrl: coffeeUrl,
          id: CoffeeModel.getIdFromCoffeeUrl(coffeeUrl),
          rating: CoffeeRating.dislike,
        );

        final coffeeList = List.generate(
          kDefaultCoffeeListSize,
          (index) => index == 0
              ? dislikedCoffee //
              : unratedCoffee,
        );

        final afterSwipeCoffeeList = [...coffeeList, unratedCoffee];

        return [
          HomeState.loading,
          HomeState.success(coffeeList),
          HomeState.success(afterSwipeCoffeeList),
        ];
      },
    );
  });
}
