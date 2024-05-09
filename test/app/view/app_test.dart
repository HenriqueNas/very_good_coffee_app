import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/app/app.dart';
import 'package:very_good_coffee_app/home/view/home_page.dart';

import '../../helpers/helpers.dart';

void main() {
  setUpAll(DependenciesInjector.initDependencies);

  group('VeryGoodCoffeeApp', () {
    testWidgets('renders VeryGoodCoffeeApp', (tester) async {
      await tester.pumpApp(const VeryGoodCoffeeApp());
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
