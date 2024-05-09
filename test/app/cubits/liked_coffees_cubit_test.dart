import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/app/app.dart';

import '../../helpers/helpers.dart';

void main() {
  const likedCoffee = CoffeeModel(
    id: '1',
    imageUrl: 'https://example.com/image.jpg',
    rating: CoffeeRating.like,
  );

  setUpAll(DependenciesInjector.init);

  tearDownAll(DependenciesInjector.dispose);

  group('LikedCoffeesCubit constructor', () {
    blocTest<LikedCoffeesCubit, List<CoffeeModel>>(
      'emits [<CoffeeModel>[]] when created from empty storage',
      build: LikedCoffeesCubit.new,
      expect: () => [<CoffeeModel>[]],
      tearDown: DependenciesInjector.localStorage.clear,
    );

    blocTest<LikedCoffeesCubit, List<CoffeeModel>>(
      'emits [[coffee]] when create from storage with one coffee',
      setUp: () => DependenciesInjector.localStorage.write(
        kLikedCoffeesKey,
        [likedCoffee.toMap()],
      ),
      build: LikedCoffeesCubit.new,
      expect: () => [
        [likedCoffee],
      ],
      tearDown: DependenciesInjector.localStorage.clear,
    );
  });

  group('LikedCoffeesCubit methods', () {
    late LikedCoffeesCubit cubit;

    setUp(() {
      cubit = LikedCoffeesCubit();
    });

    blocTest<LikedCoffeesCubit, List<CoffeeModel>>(
      'should not emits [[coffee]] when'
      ' addCoffee is called without like rating',
      build: () => cubit,
      act: (cubit) => cubit.addCoffee(
        CoffeeModel.fromImageUrl(likedCoffee.imageUrl),
      ),
      errors: () => [isA<AssertionError>()],
      tearDown: DependenciesInjector.localStorage.clear,
    );

    blocTest<LikedCoffeesCubit, List<CoffeeModel>>(
      'emits [[coffee]] when addCoffee is called with like rating',
      build: () => cubit,
      act: (cubit) => cubit.addCoffee(likedCoffee),
      expect: () => [
        [likedCoffee],
      ],
      tearDown: DependenciesInjector.localStorage.clear,
    );

    blocTest<LikedCoffeesCubit, List<CoffeeModel>>(
      'emits [<CoffeeModel>[]] when removeCoffee is called',
      build: () => cubit,
      seed: () => [likedCoffee],
      act: (cubit) => cubit.removeCoffee(likedCoffee),
      expect: () => [
        <CoffeeModel>[],
      ],
      tearDown: DependenciesInjector.localStorage.clear,
    );

    blocTest<LikedCoffeesCubit, List<CoffeeModel>>(
      'emits [[likedCoffee]] when removeCoffee'
      ' is called with no coffee in liked list',
      build: () => cubit,
      seed: () => [likedCoffee],
      act: (cubit) => cubit.removeCoffee(CoffeeModel.fromImageUrl('imageUrl')),
      expect: () => [
        [likedCoffee],
      ],
      tearDown: DependenciesInjector.localStorage.clear,
    );

    blocTest<LikedCoffeesCubit, List<CoffeeModel>>(
      'emits [] when clearCoffeeList is called',
      build: () => cubit,
      seed: () => [likedCoffee, likedCoffee],
      act: (cubit) => cubit.clearCoffeeList(),
      expect: () => [
        <CoffeeModel>[],
      ],
      tearDown: DependenciesInjector.localStorage.clear,
    );
  });
}
