import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/favorites/view/view.dart';
import 'package:very_good_coffee_app/home/home.dart';

import '../../helpers/helpers.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  group('FavoritesPage', () {
    setUpAll(DependenciesInjector.init);

    tearDownAll(DependenciesInjector.dispose);

    testWidgets('renders FavoritesPage', (tester) async {
      await tester.pumpApp(const FavoritesPage());
      expect(find.byType(FavoritesPage), findsOneWidget);
    });
  });

  group('FavoriteView', () {});
}
