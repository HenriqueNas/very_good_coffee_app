import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:very_good_coffee_app/app/cubits/liked_coffees_cubit.dart';
import 'package:very_good_coffee_app/app/data/data.dart';
import 'package:very_good_coffee_app/favorites/view/view.dart';

import '../../helpers/helpers.dart';

class MockLikedCoffeesCubit extends MockCubit<List<CoffeeModel>>
    implements LikedCoffeesCubit {}

void main() {
  group('FavoritesPage', () {
    setUpAll(DependenciesInjector.init);

    tearDownAll(DependenciesInjector.dispose);

    testWidgets('renders FavoritesPage', (tester) async {
      await tester.pumpPage(const FavoritesPage());
      expect(find.byType(FavoritesPage), findsOneWidget);
    });
  });

  group('FavoritesView', () {
    setUpAll(DependenciesInjector.init);

    tearDownAll(DependenciesInjector.dispose);

    testWidgets('renders FavoritesView', (tester) async {
      await tester.pumpPage(const FavoritesView());
      expect(find.byType(FavoritesView), findsOneWidget);
    });

    testWidgets('renders FavoritesView without items', (tester) async {
      final homeCubit = MockLikedCoffeesCubit();

      when(() => homeCubit.likedCoffees).thenReturn(const []);

      await tester.pumpPage(
        BlocProvider.value(
          value: homeCubit,
          child: const FavoritesView(),
        ),
      );

      expect(find.byType(FavoritesView), findsOneWidget);
      expect(find.byKey(const Key('favorites_page:empty')), findsOneWidget);
    });

    testWidgets('renders FavoritesView with items', (tester) async {
      final coffeeList = List.generate(
        3,
        (index) => CoffeeModel(
          id: index.toString(),
          imageUrl: 'image=$index',
          rating: CoffeeRating.like,
        ),
      );

      final likedCoffeesCubit = MockLikedCoffeesCubit();
      when(() => likedCoffeesCubit.state).thenReturn(coffeeList);
      when(() => likedCoffeesCubit.likedCoffees).thenReturn(coffeeList);

      await mockNetworkImagesFor(
        () => tester.pumpPage(
          const FavoritesView(),
          likedCoffeesCubit: likedCoffeesCubit,
        ),
      );

      expect(find.byType(FavoritesView), findsOneWidget);
      expect(find.byKey(const Key('favorites_page:empty')), findsNothing);
      expect(find.byKey(const Key('favorites_page:list')), findsOneWidget);
    });
  });
}
