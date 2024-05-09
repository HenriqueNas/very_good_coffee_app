import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/favorites/view/view.dart';

import '../../../helpers/helpers.dart';

void main() {
  setUpAll(DependenciesInjector.init);

  tearDownAll(DependenciesInjector.dispose);

  group('ClearListDialog', () {
    testWidgets('renders ClearListDialog', (tester) async {
      await tester.pumpPage(const ClearListDialog());
      expect(find.byType(ClearListDialog), findsOneWidget);
    });
  });
}
