import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_coffee_app/app/data/models/coffee_model.dart';
import 'package:very_good_coffee_app/home/home.dart';

import '../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  group('HomePage', () {
    setUpAll(DependenciesInjector.initDependencies);

    testWidgets('renders HomePage', (tester) async {
      await tester.pumpApp(const HomePage());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });

  group('HomeView', () {
    late HomeCubit homeCubit = MockHomeCubit();

    setUpAll(() {
      homeCubit = MockHomeCubit();
      when(homeCubit.loadInitialCoffeeImages).thenAnswer((_) async {});
      when(() => homeCubit.swiperController).thenReturn(CardSwiperController());
    });

    testWidgets('renders loading state', (tester) async {
      when(() => homeCubit.state).thenReturn(HomeState.loading);

      await tester.pumpApp(
        BlocProvider.value(
          value: homeCubit,
          child: const HomeView(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders error state', (tester) async {
      when(() => homeCubit.state).thenReturn(
        HomeState.error('error message'),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: homeCubit,
          child: const HomeView(),
        ),
      );

      expect(find.byKey(const Key('home_page:error')), findsOneWidget);
    });

    testWidgets('renders success state with coffee cards', (tester) async {
      final coffees = [
        const CoffeeModel(
          id: '1',
          imageUrl: 'image1',
          rating: CoffeeRating.none,
        ),
        const CoffeeModel(
          id: '2',
          imageUrl: 'image2',
          rating: CoffeeRating.none,
        ),
        const CoffeeModel(
          id: '3',
          imageUrl: 'image3',
          rating: CoffeeRating.none,
        ),
      ];

      when(() => homeCubit.state).thenReturn(HomeState.success(coffees));

      await tester.pumpApp(
        BlocProvider.value(
          value: homeCubit,
          child: const HomeView(),
        ),
      );

      expect(find.byKey(const Key('home_page:card_swiper')), findsOneWidget);
      expect(find.byType(RatingButtons), findsOneWidget);
    });

    testWidgets('render error message when no coffees load', (tester) async {
      when(() => homeCubit.state).thenReturn(HomeState.success([]));

      await tester.pumpApp(
        BlocProvider.value(
          value: homeCubit,
          child: const HomeView(),
        ),
      );

      expect(find.byKey(const Key('home_page:empty_list')), findsOneWidget);
    });
  });
}
