import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_coffee_app/home/home.dart';

import '../../helpers/helpers.dart';

void main() {
  late final CoffeeRepository coffeeRepository;

  setUpAll(() {
    DependenciesInjector.init();
    coffeeRepository = CoffeeRepository();
  });

  tearDownAll(DependenciesInjector.dispose);

  group('CoffeeRepository', () {
    test('getListOfCoffeeImages returns list of image URLs', () async {
      const listSize = 3;
      final expectedUrls = List.generate(
        listSize,
        (_) => DependenciesInjector.httpClient.fileUrl,
      );

      final result = await coffeeRepository.getListOfCoffeeImages(listSize);

      expect(result, expectedUrls);
    });

    test('getCoffeeImage returns a single image URL', () async {
      final result = await coffeeRepository.getCoffeeImage();

      expect(result, DependenciesInjector.httpClient.fileUrl);
    });

    test(
      'getListOfCoffeeImages throws assertion error for invalid list size',
      () {
        expect(
          () => coffeeRepository.getListOfCoffeeImages(0),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  });
}
